Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030473AbWJ3PXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030473AbWJ3PXV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 10:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030482AbWJ3PXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 10:23:21 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:64714 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1030473AbWJ3PXU (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 10:23:20 -0500
Message-Id: <200610301522.k9UFMXmM004701@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Oleg Verych <olecom@flower.upol.cz>
Cc: Jan Beulich <jbeulich@novell.com>, dsd@gentoo.org, kernel@gentoo.org,
       draconx@gmail.com, jpdenheijer@gmail.com, Andrew Morton <akpm@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] replacement for broken kbuild-dont-put-temp-files-in-the-source-tree.patch
In-Reply-To: Your message of "Mon, 30 Oct 2006 14:42:16 GMT."
             <slrnekc3q8.2vm.olecom@flower.upol.cz>
From: Valdis.Kletnieks@vt.edu
References: <20061028230730.GA28966@quickstop.soohrt.org> <200610281907.20673.ak@suse.de> <20061029120858.GB3491@quickstop.soohrt.org> <200610290816.55886.ak@suse.de> <slrnek9qv0.2vm.olecom@flower.upol.cz> <20061029225234.GA31648@uranus.ravnborg.org> <4545C2D8.76E4.0078.0@novell.com> <slrnekbv60.2vm.olecom@flower.upol.cz>
            <slrnekc3q8.2vm.olecom@flower.upol.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1162221753_3894P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 30 Oct 2006 10:22:33 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1162221753_3894P
Content-Type: text/plain; charset=us-ascii

On Mon, 30 Oct 2006 14:42:16 GMT, Oleg Verych said:

> So, how about (using your btmp directory) create symlink to /dev/null in
> the (dev) sub-directory and then set no write permission? No tmp,
> things are local to build output, old gas's happy:
> ,__
> |olecom@flower:/tmp/_build_2.6.19-rc3/btmp
> !__$ mkdir dev
> ,__
> |olecom@flower:/tmp/_build_2.6.19-rc3/btmp
> !__$ cd dev ; ln -s /dev/null null ; chmod u-w . ; ls -la
> total 0
> dr-xr-x--- 2 olecom root 60 2006-10-30 15:34 .
> drwxr-x--- 3 olecom root 80 2006-10-30 15:34 ..
> lrwxrwxrwx 1 olecom root  9 2006-10-30 15:34 null -> /dev/null
> ,__
> |olecom@flower:/tmp/_build_2.6.19-rc3/btmp/dev
> !__$ cd .. ; rm dev/null
> rm: cannot remove dev/null': Permission denied

Did you try this as root, which is where the original "/dev/null dissapears"
problem shows up?

[/tmp]3 id
uid=0(root) gid=0(root) groups=0(root),1(bin),2(daemon),3(sys),4(adm),6(disk),10(wheel) context=valdis:staff_r:staff_t
[/tmp]3 mkdir z9
[/tmp]3 touch z9/foo
[/tmp]3 chmod 0 z9
[/tmp]3 rm z9/foo
[/tmp]3 ln -s /dev/null z9
[/tmp]3 ls -l z9
total 0
lrwxrwxrwx 1 root root 9 Oct 30 10:20 null -> /dev/null
[/tmp]3 rm z9/null
[/tmp]3 ls -ld z9
d--------- 2 root root 40 Oct 30 10:21 z9

Hmm.. and even the 'ln' worked even when z9 was chmod 0. ;)


--==_Exmh_1162221753_3894P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFRhi5cC3lWbTT17ARAmcRAJ9B2/zWMtWMjjTNLzLMVTTABQ+gawCgwLZJ
nNabey12AEenA7yYyUOcChA=
=yywR
-----END PGP SIGNATURE-----

--==_Exmh_1162221753_3894P--
