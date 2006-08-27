Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWH0KR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWH0KR0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 06:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWH0KR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 06:17:26 -0400
Received: from master.altlinux.org ([62.118.250.235]:18706 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1750706AbWH0KRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 06:17:25 -0400
Date: Sun, 27 Aug 2006 14:16:56 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Lee Trager <Lee@PicturesInMotion.net>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: HPA Resume patch
Message-Id: <20060827141656.0e4d2c17.vsu@altlinux.ru>
In-Reply-To: <44F15ADB.5040609@PicturesInMotion.net>
References: <44F15ADB.5040609@PicturesInMotion.net>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.10.1; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sun__27_Aug_2006_14_16_56_+0400_KmQY0HRYRUWSpa6Z"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sun__27_Aug_2006_14_16_56_+0400_KmQY0HRYRUWSpa6Z
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 27 Aug 2006 04:42:03 -0400 Lee Trager wrote:

> This patch fixes a problem with computers that have HPA on their hard
> drive and not being able to come out of resume from RAM or disk. I've
> tested this patch on 2.6.17.x and 2.6.18-rc4 and it works great on both
> of these. This patch also fixes the bug #6840. This is my first patch to
> the kernel and I was told to e-mail the above people to get my patch
> into the kernel. If I made a mistake please be gentle and correct me ;)

The patch adds a call from ide.c to a function inside ide-disk.c - this
won't work when IDE support is built as modules (it will cause a
circular dependency between ide-core and ide-disk modules).

The proper way to do such calls is to add a new method to ide_driver_t
and call it from generic_ide_resume().  Also, if the ide_do_drive_cmd()
call failed, it is probably unsafe to reset HPA, so you need to check
the result and call the resume method only if the low-level resume has
succeeded.

And please and "-p" to diff options.

--Signature=_Sun__27_Aug_2006_14_16_56_+0400_KmQY0HRYRUWSpa6Z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE8XEcW82GfkQfsqIRAiwaAJ4sB+oiXUP/TUUa0KvF831PpYN0zgCfSz9U
1ZhSb7fpMOr/2ExK9m984Q4=
=WDlr
-----END PGP SIGNATURE-----

--Signature=_Sun__27_Aug_2006_14_16_56_+0400_KmQY0HRYRUWSpa6Z--
