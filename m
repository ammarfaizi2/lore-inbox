Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311462AbSCTWfd>; Wed, 20 Mar 2002 17:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312245AbSCTWfZ>; Wed, 20 Mar 2002 17:35:25 -0500
Received: from CPE-203-51-26-136.nsw.bigpond.net.au ([203.51.26.136]:53232
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S311462AbSCTWfO>; Wed, 20 Mar 2002 17:35:14 -0500
Message-ID: <3C990E9E.CC23F0AA@eyal.emu.id.au>
Date: Thu, 21 Mar 2002 09:35:10 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre3-ac1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre3-ac4: ATTRIB_NORET
In-Reply-To: <E16nje1-0002oN-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> This is the small stuff. Next patch is the next IDE updates so its about to
> get more fun again 8)
> 
> [+ indicates stuff that went to Marcelo, o stuff that has not,
>  * indicates stuff that is merged in mainstream now, X stuff that proved
>    bad and was dropped out]
> 
> Linux 2.4.19pre3-ac4
> o       Ensure jfs readdir doesn't spin on bad metadata (Dave Kleikamp)
> o       Fix iconfig with no modules                     (Randy Dunlap)
> o       Don't enfore rlimit on block device files       (Peter Hartley)
> o       Add belkin wireless card idents                 (Brendan McAdams)
> o       Add HP VA7400 to the scsi blacklist quirks      (Alar Aun)
> o       JFS race fix                                    (Dave Kleikamp)
> o       Fix wafer5823 watchdog merge error I made       (Justin Cormack)
> o       Fix Config rule for phonejack pcmcia card       (Eyal Lebedinsky)
> o       Test improved OOM handler for rmap              (Rik van Riel)
> o       Update defconfig/experimental bits              (Neils Jensen)
> o       The incredible shrinking kernel patch           (Andrew Morton)
> o       Clean up BUG() implementation                   (Andrew Morton)

-ac4 includes this:

--- linux.19p3/include/linux/kernel.h   Thu Mar 14 21:51:34 2002
+++ linux.19pre3-ac4/include/linux/kernel.h     Wed Mar 20 16:02:22 2002
@@ -181,4 +181,6 @@
        char _f[20-2*sizeof(long)-sizeof(int)]; /* Padding: libc5 uses
this.. */
 };
 
+extern void out_of_line_bug(void) ATTRIB_NORET;
+
 #endif

However ATTRIB_NORET is only defined if __KERNEL__, and the above line
is outside that segment. In may case it is lm_sensors 2.6.2 that fails
here.

I moved it up and the build completes now.


BTW, this undef is still around too:
depmod: *** Unresolved symbols in
/lib/modules/2.4.19-pre3-ac4/kernel/drivers/hotplug/ibmphp.o
depmod:         IO_APIC_get_PCI_irq_vector

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
