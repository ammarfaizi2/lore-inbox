Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbTFBTwb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 15:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbTFBTwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 15:52:30 -0400
Received: from camus.xss.co.at ([194.152.162.19]:46859 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id S261651AbTFBTw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 15:52:28 -0400
Message-ID: <3EDBAE1D.7010504@xss.co.at>
Date: Mon, 02 Jun 2003 22:05:49 +0200
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Pam.Delaney@lsil.com
Subject: Misleading comment for CONFIG_FUSION (LSI fusion MPT driver)
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

(I've already reported this previously as post scriptum
to a different bugreport, so it might have slipped through
unnoticed...)

The linux kernel configuration help text for the LSI fusion MPT
driver (CONFIG_FUSION) provides this information:

[...]
  If you have Fusion MPT hardware and want to use it, you can say
  Y or M here to add MPT (base + ScsiHost) drivers.
    <Y> = build lib (fusion.o), and link [static] into the kernel [2]
          proper
    <M> = compiled as [dynamic] modules [3] named: (mptbase.o,
          mptscsih.o)

          [2] In order enable capability to boot the linux kernel
              natively from a Fusion MPT target device, you MUST
               answer Y here! (currently requires CONFIG_BLK_DEV_SD)
[...]

This is at least misleading: It _is_ possible to boot from
a SCSI drive connected to a LSI Fusion MPT controller and have
the device driver loaded as module: just use an initial ramdisk
which contains the necessary modules and load them in linuxrc

There is nothing special here: I do this all the time with
all kind of hardware: RAID controllers, SCSI controllers,
IDE controllers (ok, modular IDE is now broken with 2.4.2x,
but it used to work in the good old times), even diskless
root fs is possible using initrd (as you all know)

When I first tried to figure if Linux did support the LSI1030
controller, this comment made me quite insecure: I did not want
to compile a custom kernel just for this controller and wondered,
what might be so special about this driver.

But it turned out this wasn't necessary. You can have a modular
kernel and boot from your harddisk connected to a fusion MPT
controller quite fine, using the initial ramdisk method. No
special customized kernel needed!  :-)

With linux-2.4.21-rc6-ac1 (my current test system), just the
following modules are needed (order is important):

scsi_mod
mptbase
mptscsih
sd_mod

and any other module (like filesystem driver) you need to
access your root fs.

I just thought this might be of interest for you...
Perhaps the comment could be changed so it doesn't confuse
people (like me), who are actually reading the documentation... ;-)

- - andreas

- --
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+264ZxJmyeGcXPhERAoN8AJwLe8zMHNN/yCq5gj5BuZ0amFwH3QCdFi0Y
8fOSlS6LCg4J5W2YgCuFpH4=
=e0mr
-----END PGP SIGNATURE-----

