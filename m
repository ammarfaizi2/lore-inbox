Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281656AbRKPX5R>; Fri, 16 Nov 2001 18:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281655AbRKPX5I>; Fri, 16 Nov 2001 18:57:08 -0500
Received: from vsdc01.corp.publichost.com ([64.7.196.123]:32777 "EHLO
	vsdc01.corp.publichost.com") by vger.kernel.org with ESMTP
	id <S281647AbRKPX45>; Fri, 16 Nov 2001 18:56:57 -0500
Message-ID: <3BF5A7C2.40207@vitalstream.com>
Date: Fri, 16 Nov 2001 15:56:50 -0800
From: Rick Stevens <rstevens@vitalstream.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>,
        Linux-SCSI <linux-scsi@vger.kernel.org>
Subject: Build problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This may or may not have been discussed.  Yesterday, I was building
2.4.14 (yes, a bit behind the time) for a system where the root
filesystem lives on a Symbios 53c8xx SCSI drive.  I built the system
as fully modularized (the root driver and such were modules).  When
I finally got around to building the initrd image, I noticed that
the scsi_mod.o and sd_mod.o drivers were NOT loaded into the ramdisk
image.

Hmmm.  I looked at the /lib/modules/2.4.14/kernel/drivers/scsi
directory and discovered that scsi_mod.o and sd_mod.o weren't
present!  Looking back at the source tree, they had indeed been built.
Apparently the "make modules_install" didn't move them to the /lib
tree.  So I copied them manually, re-depmoded it and re-built the
initrd image.  This time, the scsi_mod and sd_mod modules WERE
inserted into the ramdisk image.  However, when booting using that
image, neither scsi_mod nor sd_mod are loaded.  The sym53c8xx driver
DOES load, but we have an instant panic because the root filesystem
can't be found.

What did I do wrong here?  Is "make modules_install" broken in 2.4.14?
Am I suffering from a short between the keyboard and floor?  For
further info, this is a baseline RedHat 7.1 system, but I want the
2.4.14 kernel (the virtual memory system seems to work better for
our purposes than that found in kernels <= 2.4.9 and no, I don't
want to get into a discussion about the merits of the aa and ac
VM systems).


P.S. I'm posting this to linux-kernel and linux-scsi.  Someone should
be able to tell me what I did wrong.

----------------------------------------------------------------------
- Rick Stevens, SSE, VitalStream, Inc.      rstevens@vitalstream.com -
- 949-743-2010 (Voice)                    http://www.vitalstream.com -
-                                                                    -
-     Never put off 'til tommorrow what you can forget altogether!   -
----------------------------------------------------------------------

