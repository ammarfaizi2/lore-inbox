Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279845AbRKAXDg>; Thu, 1 Nov 2001 18:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279853AbRKAXD0>; Thu, 1 Nov 2001 18:03:26 -0500
Received: from punt-2.aladdin.de ([212.14.90.2]:39343 "HELO punt.aladdin.de")
	by vger.kernel.org with SMTP id <S279845AbRKAXDV>;
	Thu, 1 Nov 2001 18:03:21 -0500
To: linux-kernel@vger.kernel.org
Cc: cpg@aladdin.de
Subject: Alphastation stopped booting with 2.4.10+
From: Christian Groessler <cpg@aladdin.de>
Date: 02 Nov 2001 00:02:34 +0100
Message-ID: <87wv1a5c39.fsf@gibbon.cnet.aladdin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.4.9 worked fine, but starting with 2.4.10 my Alphastation 200
stopped booting. It simply halts immediately after being called by
aboot:


------------
aboot> 6
aboot: loading compressed boot/srm-vmlinux-2.4.10.gz...
aboot: zero-filling 147840 bytes at 0xfffffc0000a82520
aboot: starting kernel boot/srm-vmlinux-2.4.10.gz with arguments root=/dev/sda5 video=tga:font:SUN12x22,mode:1024x768-76 console=ttyS0

halted CPU 0

halt code = 5
HALT instruction executed
PC = fffffc00009b0cc0
>>>
------------


I think the problem is the newly introduced opDEC_check, if I do the
following change 


------------
--- arch/alpha/kernel/traps.c   Thu Nov  1 02:48:15 2001
+++ arch/alpha/kernel/traps.c.good      Thu Nov  1 23:07:32 2001
@@ -998,6 +998,6 @@ trap_init(void)
         * a bug in the handling of the opDEC fault.  Fix it up if so.
         */
        if (implver() == IMPLVER_EV4) {
-               opDEC_check();
+               /*opDEC_check();*/
        }
 }
------------


the computer boots OK.
I'm using SRM V7.0-9 and aboot 0.8 on an AlphaStation 200 4/100

regards,
chris

