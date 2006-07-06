Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965120AbWGFD2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965120AbWGFD2U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 23:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965132AbWGFD2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 23:28:20 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:3204 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S965120AbWGFD2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 23:28:19 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [klibc 30/31] Remove in-kernel resume-from-disk invocation code
Date: Thu, 6 Jul 2006 13:28:12 +1000
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, klibc@zytor.com
References: <klibc.200606272217.00@tazenda.hos.anvin.org> <200607061218.39202.ncunningham@linuxmail.org> <44AC7F46.3050204@zytor.com>
In-Reply-To: <44AC7F46.3050204@zytor.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4863890.Q37vy5dBHs";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607061328.16376.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4863890.Q37vy5dBHs
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 06 July 2006 13:11, H. Peter Anvin wrote:
> Nigel Cunningham wrote:
> > Hi again.
> >
> > (Excuse me replying to myself, but this might help someone else).
> >
> > On Thursday 06 July 2006 11:45, Nigel Cunningham wrote:
> >> Is there a klibc howto somewhere? I tried googling for 'klibc howto',
> >> reading the files in Documentation/ and browsing your klibc mailing li=
st
> >> archive before asking!
> >>
> >> What I'm wondering specifically is: Say a user needs to run some
> >> commands to set up access to encrypted storage before they can resume.
> >> At the moment, we'd tell them to put these commands and the echo >
> >> do_resume in their linuxrc (or init) script prior to mounting their ro=
ot
> >> filesystem. Forgive me if I'm asking a stupid question but it's not
> >> immediately obvious to me how they would now do that. I'd much rather
> >> follow a simple howto than spend a good amount of time tracing function
> >> calls etc. I still see init/initramfs.c, and it mentions both
> >> CONFIG_BLK_DEV_INITRD and CONFIG_BLK_DEV_RAM. Would I be right in
> >> surmising that you can still have an initrd or ramfs to do such things
> >> as the above, after klibc has done its work? If not, is there some oth=
er
> >> way I'm ignorant of?
> >
> > For the record, I've since discovered that what you really want is an
> > initramfs howto. I think I stuck with those old-fangled initrds for too
> > long. Better update my desktop from Mandrake 10 too :)... is there a
> > pattern here?
>
> Okay, let's try to start from the beginning...
>
> initramfs is, indeed, a replacement for initrd, but it's not a 1:1 map.
>   Instead, initramfs contents -- which can come from multiple sources!
> -- is simply extracted right into rootfs.
>
> kinit is a replacement for the in-kernel root-handling code, as well as
> other related in-kernel code like resume from disk.  It is compiled as a
> monolithic binary for size reasons.
>
> klibc is a very small C library which *can* be used to produce initramfs
> binaries; in particular, it's used to produce kinit, and is small enough
> that it can be realistically included with the kernel distribution.
>
> If you provide your own /init in an initramfs, it will override the
> default, which is /init -> /kinit.  You can then choose to invoke kinit
> if you want to; for example, you could try to resume from suspend2, and
> invoke kinit if that fails.

Ah... ok. That helps a lot.

Thanks!

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart4863890.Q37vy5dBHs
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBErINQN0y+n1M3mo0RAgs1AKCPP+gcZD3et7b8CEkpEDpGKQvTXgCeIy3z
a2SyNkFU+POJoTrF8pCYxso=
=t1iu
-----END PGP SIGNATURE-----

--nextPart4863890.Q37vy5dBHs--
