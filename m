Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261581AbTADWYS>; Sat, 4 Jan 2003 17:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261624AbTADWYR>; Sat, 4 Jan 2003 17:24:17 -0500
Received: from pD9EC209A.dip.t-dialin.net ([217.236.32.154]:25216 "HELO
	schottelius.net") by vger.kernel.org with SMTP id <S261581AbTADWYQ>;
	Sat, 4 Jan 2003 17:24:16 -0500
Date: Sat, 4 Jan 2003 12:39:01 +0100
From: Nico Schottelius <schottelius@wdt.de>
To: "Alfred M. Szmidt" <ams@kemisten.nu>
Cc: bug-fileutils@gnu.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bugs in df [problem of fileutils or kernel?]
Message-ID: <20030104113901.GB255@schottelius.org>
References: <20021231141036.GA494@schottelius.org> <E18TRt6-0004wx-00@lgh163a.kemisten.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline
In-Reply-To: <E18TRt6-0004wx-00@lgh163a.kemisten.nu>
User-Agent: Mutt/1.4i
X-Operating-System: Linux flapp 2.5.53
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Alfred M. Szmidt [Tue, Dec 31, 2002 at 08:17:16PM +0100]:
>    I am using 2.5.53,ext3 on /dev/root,isofs on /mnt/dvd and df is
>=20
> 2.5.53 of what exactly?

the kernel. I will try 2.5.54 soon,too.

>    flapp:/home/user/nico # df --version
>    df (GNU fileutils) 4.0.35
>=20
> Could you try and see if this still presists in GNU Fileutils 4.1 [1]?

nico@flapp:~/fileutils-4.1/src $ ./df  -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/root              18G   19G  136M 100% /
/dev/cdroms/cdrom0     71M   71M     0 100% /mnt/dvd
nico@flapp:~/fileutils-4.1/src $ ./df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/root             19228276  19088984    139292 100% /
/dev/cdroms/cdrom0       72434     72434         0 100% /mnt/dvd
nico@flapp:~/fileutils-4.1/src $ ./du /mnt/dvd/ -sh
505M    /mnt/dvd


yes, it does.

> Or if you feel brave GNU Coreutils (an merge of Fileutils, Shutils and
> Textutils) [2]?=20

nico@flapp:~/coreutils-4.5.4/src $ ./df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/root             19228276  19080532    147744 100% /
/dev/cdroms/cdrom0       72434     72434         0 100% /mnt/dvd
nico@flapp:~/coreutils-4.5.4/src $ ./df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/root              19G   19G  145M 100% /
/dev/cdroms/cdrom0     71M   71M     0 100% /mnt/dvd
nico@flapp:~/coreutils-4.5.4/src $ ./du /mnt/dvd/ -sh
505M    /mnt/dvd/

yes, it does. but at least is the size now correct in -h.

=3D=3D=3D=3D> now trying with 2.5.54 <=3D=3D=3D=3D
nico@flapp:~ $ df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/root             19228276  19086992    141284 100% /
/dev/cdroms/cdrom0       72434     72434         0 100% /mnt/dvd
nico@flapp:~ $ df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/root              18G   19G  137M 100% /
/dev/cdroms/cdrom0     71M   71M     0 100% /mnt/dvd
nico@flapp:~ $ df --version
df (fileutils) 4.1

and the cdrom is again 505 MB big...

nico@flapp:~/coreutils-4.5.4/src $ ./df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/root             19228276  19087008    141268 100% /
/dev/cdroms/cdrom0       72434     72434         0 100% /mnt/dvd
nico@flapp:~/coreutils-4.5.4/src $ ./df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/root              19G   19G  138M 100% /
/dev/cdroms/cdrom0     71M   71M     0 100% /mnt/dvd
nico@flapp:~/coreutils-4.5.4/src $ ./du /mnt/dvd/ -sh
505M    /mnt/dvd/


=3D=3D> so coreutils at least prints correct human values...
    I am still thinking it could be a kernel bug..so I am rebooting to
    2.4.21-pre2.

But this does not make a difference...

> If it still exists in those, could you try debugging
> it?

nice,1002 lines of code in df.c.. okay, let's have a look into it...
(currently I think it _could_ be a kernel bug, so I will pass this message
alon to lkml)

I had a quick view at the code, but didn't have the time to look into
it closely. Perhaps the next days!

Am I the only one where df reports wrong disk space?

Nico


--=20
Please send your messages pgp-signed and/or pgp-encrypted (don't encrypt ma=
ils
to mailing list!). If you don't know what pgp is visit www.gnupg.org.
(public pgp key: ftp.schottelius.org/pub/familiy/nico/pgp-key)

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+FsfVtnlUggLJsX0RAqhlAJ0axIQS1suUXAK+zbXdweU0+PCH/ACfb3F1
YEPU4hPZgNgWVb3LwLZQFGo=
=lUZw
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
