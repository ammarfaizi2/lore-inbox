Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271222AbTG2Bit (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 21:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271225AbTG2Bit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 21:38:49 -0400
Received: from pop018pub.verizon.net ([206.46.170.212]:35310 "EHLO
	pop018.verizon.net") by vger.kernel.org with ESMTP id S271222AbTG2Bis
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 21:38:48 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test2 make failure
Date: Mon, 28 Jul 2003 21:38:44 -0400
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307282138.44960.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at pop018.verizon.net from [151.205.10.84] at Mon, 28 Jul 2003 20:38:47 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greets everybody;

Here is one I haven't seen before, and its my first thru 4th try at 
building 2.6.0-test2.

The error exit looks like this:
-------------------------
gcc  -DMODVERSIONS -include 
/lib/modules/2.4.22-pre8/build/include/linux/modversions.h 
-D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. 
-Ikernel/include -I/usr/local/include 
-I/lib/modules/2.4.22-pre8/build/include  -nostdinc -I 
/usr/lib/gcc-lib/i386-redhat-linux/3.2/include  -Wall -O2   -c 
kernel/busses/i2c-nforce2.c -o kernel/busses/i2c-nforce2.o
kernel/busses/i2c-nforce2.c: In function `nforce2_probe_smb':
kernel/busses/i2c-nforce2.c:337: structure has no member named `owner'
make: *** [kernel/busses/i2c-nforce2.o] Error 1
--------------------------
Please note the wrong /lib/modules/version reference above!  It 
faintly resembles the i2c errors, errors made because the version is 
apparently being extracted from a uname return by the Makefile.

Backtracking up thru half a meg of shell history, I find this:
---------------
Ahh, never mind, I see all sorts of warnings about NOT building in i2c 
stuff, it must be modules, and the fscking makefile is broken anyway 
since it determines the architecture its being built from via the use 
of uname, which of course is reporting 2.4.22-pre8.  Like I said, the 
Makefile in the i2c subdir is busted, and I will have to build, and 
boot to, 2.6.0-test2 before I can build the hardware sensors stuff...

That I can fix...

Ok, back to the real exit above, I've no doubt got something fubared, 
but I do have a GForce2 MX-200 32 meg card it would be nice to be 
able to use since its the only video in this machine :-)

Do I have to turn that off, build to the vga screen first, boot to it, 
and then rebuild it so the module versions are correct before this 
will build?

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

