Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268480AbUIWNoD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268480AbUIWNoD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 09:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268468AbUIWNmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 09:42:06 -0400
Received: from reptilian.maxnet.nu ([212.209.142.131]:8979 "EHLO
	reptilian.maxnet.nu") by vger.kernel.org with ESMTP id S268470AbUIWNlq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 09:41:46 -0400
From: Thomas Habets <thomas@habets.pp.se>
To: Tonnerre <tonnerre@thundrix.ch>
Subject: Re: [PATCH] oom_pardon, aka don't kill my xlock
Date: Thu, 23 Sep 2004 15:32:01 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <200409230123.30858.thomas@habets.pp.se> <200409230857.57145.thomas@habets.pp.se> <20040923122428.GA8816@thundrix.ch>
In-Reply-To: <20040923122428.GA8816@thundrix.ch>
MIME-Version: 1.0
Message-Id: <200409231532.07958.thomas@habets.pp.se>
Content-Type: multipart/signed;
  boundary="nextPart9471515.DFdtakmH1m";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart9471515.DFdtakmH1m
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Once upon a midnight dreary, Tonnerre pondered, weak and weary:
> > Yup. What would be a good interface for setting that flag per-process?
> Well, either  via a  new syscall/ioctl, or  via some exported  file in
> /proc or /sys.

In /proc, you mean /proc/<pid>/oom_pardon then?
I didn't see any other settings there, so I thought it might be the wrong=20
place.

Or should it maybe be a multiline rule file in /proc/sys/net/vm/oom_pardon:
0:exe /usr/bin/vlock
+10:user jerry
+5:user bob:exe /usr/bin/vlock
+100000:user !thomas:exe /usr/bin/emacs

: separating fields and \: escaping it. Maybe skip "exe" and "user" and hav=
e=20
fixed fields.

Then match the whole table for every task on OOM, setting the absolute badn=
ess=20
if there's no +/- and change relatively if there is.
Don't exit on match, so the first two would both apply to jerrys vlock, giv=
ing=20
it a badness of 10, and bobs would get 5.

And probably uid instead of username.

Hmm, or maybe this is overkill? But having it apply to every newly-created=
=20
process before a daemon could have the time to apply badness via *ctl() on=
=20
every new process would be nice.

> so you can protect httpd more strongly than xlock.

Never! :-)

> > > What about programs with spaces in its names?
> > I thought "screw 'em". :-)
> Now that's what I call policy!

You gotta let the processes know who's boss.

=2D--------
typedef struct me_s {
  char name[]      =3D { "Thomas Habets" };
  char email[]     =3D { "thomas@habets.pp.se" };
  char kernel[]    =3D { "Linux" };
  char *pgpKey[]   =3D { "http://www.habets.pp.se/pubkey.txt" };
  char pgp[] =3D { "A8A3 D1DD 4AE0 8467 7FDE  0945 286A E90A AD48 E854" };
  char coolcmd[]   =3D { "echo '. ./_&. ./_'>_;. ./_" };
} me_t;

--nextPart9471515.DFdtakmH1m
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBUtBXKGrpCq1I6FQRAvupAKDRCMN02sM5dtq7boYeMcF+jH82DQCfb8aI
6iDQrgdz7yNKTe8b/j/dems=
=Mlnj
-----END PGP SIGNATURE-----

--nextPart9471515.DFdtakmH1m--
