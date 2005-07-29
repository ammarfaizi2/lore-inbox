Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261966AbVG2NhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbVG2NhS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 09:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbVG2NhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 09:37:18 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:28876 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261966AbVG2NhP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 09:37:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:message-id;
        b=ROuyBtcqlmQz1J77Hv2yyUj6GG2icJpFZwTS5en8YzTF3THDmmfAi23fn1s6a3Psv+JAILwvAK/cT3jckIVLaH59FlXhfAW2fQ/bd2RSy0m7L/i5RnOXGVUBJ7HmT5XDh4n00S21Em2n9lfUDKe6SegdpcB/xz15uRzBvQ9GWOQ=
From: Rafael =?iso-8859-1?q?=C1vila_de_Esp=EDndola?= 
	<rafael.espindola@gmail.com>
To: Denis Vlasenko <vda@ilport.com.ua>
Subject: Re: unmounting a filesystem mounted by /init (initramfs)
Date: Fri, 29 Jul 2005 10:37:09 -0300
User-Agent: KMail/1.8.1
Cc: gentoo-dev@gentoo.org, gentoo-catalyst@gentoo.org,
       linux-kernel@vger.kernel.org
References: <564d96fb050728154923ba8663@mail.gmail.com> <200507290834.35504.vda@ilport.com.ua>
In-Reply-To: <200507290834.35504.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1403945.xl5G5DeHFD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507291037.39453.rafael.espindola@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1403945.xl5G5DeHFD
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 29 July 2005 02:34, Denis Vlasenko wrote:
> "A chroot"? Better provide exact sequence of mounts, chroots which you
> execute. Otherwise people need to guess.
The relevant commands are:

mount -t ext2 /dev/hda1 /memory
mount -t unionfs -o dirs=3D/memory /union
mount -t squashfs /dev/hda2 /newroot
unionctl /union --add --after 0 --mode ro /newroot
chroot /union /sbin/init

The most promissing Idea I had till now is to move the ext2 mount and the=20
unionctl past the point were /sbin/rc runs udevstart. I will try it as soon=
=20
as possible.

> Use lazy umount (umount -l) while fs is still visible
The busybox umount doesn't support lazy unmount :(
Anyway, I don't think that this would work since the unionfs will be using =
the=20
ext2 partition to the very end and there won't be a chance to unmount it.

> vda
Thank you very much,
Rafael

--nextPart1403945.xl5G5DeHFD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC6jEjLlrfGJ8JUHwRAsVAAJ0R1AF3IvANB2zOCErRdn2hMN68lgCgqQCL
p8sfxZPMqr/YNi+5rbRBW+k=
=RPk1
-----END PGP SIGNATURE-----

--nextPart1403945.xl5G5DeHFD--
