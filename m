Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262258AbULCPWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbULCPWe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 10:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262259AbULCPWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 10:22:33 -0500
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:43428 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S262258AbULCPWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 10:22:30 -0500
Date: Fri, 03 Dec 2004 10:22:28 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: wakeup_pmode_return jmp failing?
To: Linux kernel <linux-kernel@vger.kernel.org>
Message-id: <41B084B4.1050402@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

Not sure who to direct this to.  I've been trying to get acpi s3 to work
on my pentium M laptop (tecra m2).  Without the nvidia driver loaded, I
can echo 3 > /proc/acpi/sleep and the machine does indeed suspend (power
light throbs and all).  However, when I try to wake up the thing, it
would flash the bios screen and throw me back to grub.

I've been investigating the code at arch/i386/kernel/acpi/wakeup.S, and
have discovered that if I place a busy wait directory before the ljmpl
to wakeup_pmode_return, that I indeed do see 'Lin' on the screen instead
of the bios screen.

The joke is, if I place a busy wait first thing after the
wakeup_pmode_return label, it never gets executed and I get a regular boot.

It would appear as though the jump from 16bit code into the 32bit code
is failing and the bios is kicking in with a regular startup.

Anybody have any suggestions?

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBsIS0dQs4kOxk3/MRAjlMAJ9HZus6LJ7oTj/OYpzn+D9nle0fsACghVot
tpOzjmA3Klxvyig/SIMr+xo=
=LvHT
-----END PGP SIGNATURE-----
