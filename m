Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbUL2MF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbUL2MF6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 07:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbUL2MF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 07:05:58 -0500
Received: from h80ad257d.async.vt.edu ([128.173.37.125]:56000 "EHLO
	h80ad257d.async.vt.edu") by vger.kernel.org with ESMTP
	id S261336AbUL2MFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 07:05:50 -0500
Message-Id: <200412291205.iBTC52RX016345@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: selvakumar nagendran <kernelselva@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: System calls effect after booting phase ?? 
In-Reply-To: Your message of "Wed, 29 Dec 2004 03:25:10 PST."
             <20041229112510.63226.qmail@web60606.mail.yahoo.com> 
From: Valdis.Kletnieks@vt.edu
References: <20041229112510.63226.qmail@web60606.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-672209888P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 29 Dec 2004 07:05:01 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-672209888P
Content-Type: text/plain; charset=us-ascii

On Wed, 29 Dec 2004 03:25:10 PST, selvakumar nagendran said:

>   Now, I want to store them in a table. But I want
> this operation to be started right after the initial
> booting phase itself part of the loading kernel
> itself. What should I do to add my module into the
> already compiled kernel image just like a standard
> kernel module?

Possibility 1:
Load them from an initrd image while booting.  If you're already
using an initrd, and this is "early enough", you just need to put the
module into the initrd, and make sure the /linuxrc or whatever script
does an insmod for it.  This has the advantage of working for out-of-tree
modules.

Possibility 2:
Build them into the kernel.  For in-tree modules, this is done with
a bit of Kconfig/Makefile magic. In the Kconfig file, you can define
a CONFIG_FOO variable, and then in the Makefile, do this:

obj-$(CONFIG_FOO) += foo.o

So if CONFIG_FOO is set to 'y' (build into kernel), it gets
added to the obj-y target list and then linked in.  If it's set to
'm' (module) or 'n' (don't build at all), it's added to the obj-m or obj-n
targets, which then aren't linked into the kernel.

Not sure how you'd go about building an out-of-tree module into the kernel,
or if that's even supposed to be possible...

--==_Exmh_-672209888P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB0p1scC3lWbTT17ARAktaAJ4vYYIanluqHDZrJHOfqtGPUX1xVgCg3Bec
A3i5f9suBVC3jEwMlRYDScI=
=M0is
-----END PGP SIGNATURE-----

--==_Exmh_-672209888P--
