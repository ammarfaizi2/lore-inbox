Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbWCWG1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWCWG1A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 01:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWCWG1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 01:27:00 -0500
Received: from elasmtp-mealy.atl.sa.earthlink.net ([209.86.89.69]:11932 "EHLO
	elasmtp-mealy.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S932090AbWCWG04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 01:26:56 -0500
To: "Yu, Luming" <luming.yu@intel.com>
cc: linux-kernel@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Tom Seeley" <redhat@tomseeley.co.uk>,
       "Dave Jones" <davej@redhat.com>, "Jiri Slaby" <jirislaby@gmail.com>,
       michael@mihu.de, mchehab@infradead.org,
       "Brian Marete" <bgmarete@gmail.com>,
       "Ryan Phillips" <rphillips@gentoo.org>, gregkh@suse.de,
       "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org,
       "Mark Lord" <lkml@rtr.ca>, "Randy Dunlap" <rdunlap@xenotime.net>,
       jgarzik@pobox.com, "Duncan" <1i5t5.duncan@cox.net>,
       "Pavlik Vojtech" <vojtech@suse.cz>, "Meelis Roos" <mroos@linux.ee>
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
In-Reply-To: Your message of "Thu, 23 Mar 2006 12:46:20 +0800."
             <3ACA40606221794F80A5670F0AF15F840B468F5D@pdsmsx403> 
X-Mailer: MH-E 7.91; nmh 1.1; GNU Emacs 21.4.1
Date: Thu, 23 Mar 2006 01:25:42 -0500
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FMJGQ-0000zx-8U@approximate.corpus.cam.ac.uk>
X-ELNK-Trace: dcd19350f30646cc26f3bd1b5f75c9f474bf435c0eb9d478a122c03f3aaf2a204d3bd010d7403663d1126d4055037e2f350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.41.6.91
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Good, then the hang should be caused by:

			     Store (Arg0, HCSL)
			     Store (ShiftLeft (Arg1, 0x01), HMAD)
			     Store (Arg2, HMCM)
			     Store (0x0B, HMPR)

   Could you add this at the beginning of this block:
	   Store (Arg0,  Debug)
   And add this at the end of this block:
	   Store( HMPR, Debug)

I added those two lines to the DSDT with only THM0 zone, but with
nothing else commented out.  Below are the dmesgs for one sleep-wake
cycle, plus an 'acpi -t'.  I thought it would hang if I did one more
cycle, but it didn't.  So I tried five more, and it was fine too.

Then I reset /proc/acpi/acpi_debug_layer to 0x10 (the boot paramater is
acpi_dbg_layer although the /proc file is acpi_debug_layer), and
unloaded and reloaded the thermal module.  And it hung in the (expected)
two cycles.  I've seen this behavior before: It won't hang with lots of
debugging turned on, but it does hang with less debugging.  Strange!

> Yes, that's good idea to have separate i2rb copy for THM0 which we are
> hacking.

I tried that, but the ACPI system got a bit sick.  It didn't support any
Sn states, for example.  So I must have done something wrong and I'll
come back to the idea later.

-Sanjoy

`A society of sheep must in time beget a government of wolves.'
   - Bertrand de Jouvenal


eth0: removing device
Unloaded prism54 driver
PM: Preparing system for mem sleep
Stopping tasks: ====================================================|
Execute Method: [\_SB_.LID0._PSW] (Node c1574808)
 acpi_ec-0458 [23] ec_intr_read          : Read [02] from address [32]
 acpi_ec-0508 [23] ec_intr_write         : Wrote [06] to address [32]
Execute Method: [\_SB_.SLPB._PSW] (Node c1574708)
Execute Method: [\_S3_] (Node e3f8a988)
Execute Method: [\_PTS] (Node e3f8ab48)
 acpi_ec-0458 [23] ec_intr_read          : Read [d6] from address [00]
 acpi_ec-0508 [23] ec_intr_write         : Wrote [96] to address [00]
 acpi_ec-0458 [23] ec_intr_read          : Read [9f] from address [05]
 acpi_ec-0508 [23] ec_intr_write         : Wrote [9e] to address [05]
 acpi_ec-0458 [22] ec_intr_read          : Read [87] from address [16]
 acpi_ec-0508 [23] ec_intr_write         : Wrote [07] to address [16]
 acpi_ec-0458 [22] ec_intr_read          : Read [2f] from address [17]
 acpi_ec-0508 [23] ec_intr_write         : Wrote [2e] to address [17]
 acpi_ec-0508 [23] ec_intr_write         : Wrote [83] to address [54]
 acpi_ec-0508 [23] ec_intr_write         : Wrote [83] to address [55]
 acpi_ec-0508 [23] ec_intr_write         : Wrote [83] to address [56]
 acpi_ec-0508 [23] ec_intr_write         : Wrote [83] to address [57]
 acpi_ec-0508 [23] ec_intr_write         : Wrote [83] to address [58]
 acpi_ec-0508 [23] ec_intr_write         : Wrote [83] to address [59]
 acpi_ec-0508 [23] ec_intr_write         : Wrote [83] to address [5a]
 acpi_ec-0508 [23] ec_intr_write         : Wrote [00] to address [5b]
 acpi_ec-0508 [23] ec_intr_write         : Wrote [83] to address [5c]
 acpi_ec-0508 [23] ec_intr_write         : Wrote [83] to address [5d]
 acpi_ec-0508 [23] ec_intr_write         : Wrote [83] to address [5e]
 acpi_ec-0508 [23] ec_intr_write         : Wrote [83] to address [5f]
 acpi_ec-0508 [23] ec_intr_write         : Wrote [00] to address [60]
 acpi_ec-0508 [23] ec_intr_write         : Wrote [83] to address [61]
 acpi_ec-0508 [23] ec_intr_write         : Wrote [00] to address [62]
 acpi_ec-0508 [23] ec_intr_write         : Wrote [00] to address [63]
 acpi_ec-0458 [23] ec_intr_read          : Read [00] from address [3a]
 acpi_ec-0508 [23] ec_intr_write         : Wrote [00] to address [3a]
 acpi_ec-0508 [23] ec_intr_write         : Wrote [02] to address [52]
 acpi_ec-0508 [23] ec_intr_write         : Wrote [09] to address [53]
 acpi_ec-0508 [23] ec_intr_write         : Wrote [10] to address [74]
 acpi_ec-0508 [23] ec_intr_write         : Wrote [0a] to address [50]
 acpi_ec-0458 [22] ec_intr_read          : Read [00] from address [50]
 acpi_ec-0458 [22] ec_intr_read          : Read [80] from address [51]
 acpi_ec-0458 [22] ec_intr_read          : Read [80] from address [51]
 acpi_ec-0458 [23] ec_intr_read          : Read [06] from address [32]
 acpi_ec-0508 [23] ec_intr_write         : Wrote [16] to address [32]
Execute Method: [\_SI_._SST] (Node e3f8a8c8)
 acpi_ec-0508 [23] ec_intr_write         : Wrote [03] to address [06]
 acpi_ec-0458 [23] ec_intr_read          : Read [00] from address [3a]
 acpi_ec-0508 [23] ec_intr_write         : Wrote [01] to address [3a]
 acpi_ec-0508 [23] ec_intr_write         : Wrote [01] to address [0e]
 acpi_ec-0508 [23] ec_intr_write         : Wrote [00] to address [0d]
 acpi_ec-0508 [23] ec_intr_write         : Wrote [00] to address [0c]
 acpi_ec-0508 [23] ec_intr_write         : Wrote [80] to address [0e]
 acpi_ec-0508 [23] ec_intr_write         : Wrote [00] to address [0d]
 acpi_ec-0508 [23] ec_intr_write         : Wrote [80] to address [0c]
uhci_hcd 0000:00:07.2: suspend_rh
uhci_hcd 0000:00:07.2: uhci_suspend
uhci_hcd 0000:00:07.2: --> PCI D0/legacy
PM: Entering mem sleep
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Back to C!
PM: Finishing wakeup.
Execute Method: [\_GPE._L0B] (Node e3f8a848)
 acpi_ec-0458 [23] ec_intr_read          : Read [10] from address [4e]
PCI: Found IRQ 11 for device 0000:00:02.0
PCI: Sharing IRQ 11 with 0000:00:06.0
PCI: Sharing IRQ 11 with 0000:01:00.0
 acpi_ec-0741 [06] ec_gpe_intr_query     : Evaluating _Q42
Execute Method: [\_SB_.PCI0.ISA0.EC0_._Q42] (Node e3f82408)
 acpi_ec-0458 [26] ec_intr_read          : Read [01] from address [3a]
 acpi_ec-0508 [26] ec_intr_write         : Wrote [01] to address [3a]
 acpi_ec-0508 [26] ec_intr_write         : Wrote [02] to address [52]
 acpi_ec-0508 [26] ec_intr_write         : Wrote [04] to address [53]
 acpi_ec-0508 [26] ec_intr_write         : Wrote [0b] to address [50]
 acpi_ec-0458 [25] ec_intr_read          : Read [0b] from address [50]
 acpi_ec-0458 [25] ec_intr_read          : Read [00] from address [50]
 acpi_ec-0458 [25] ec_intr_read          : Read [80] from address [51]
 acpi_ec-0458 [25] ec_intr_read          : Read [80] from address [51]
 acpi_ec-0458 [25] ec_intr_read          : Read [80] from address [54]
 acpi_ec-0458 [25] ec_intr_read          : Read [0c] from address [55]
 acpi_ec-0458 [25] ec_intr_read          : Read [4e] from address [58]
 acpi_ec-0458 [25] ec_intr_read          : Read [0c] from address [59]
 acpi_ec-0458 [25] ec_intr_read          : Read [f4] from address [60]
 acpi_ec-0458 [25] ec_intr_read          : Read [0b] from address [61]
 acpi_ec-0458 [25] ec_intr_read          : Read [08] from address [62]
 acpi_ec-0458 [25] ec_intr_read          : Read [0c] from address [63]
PCI: Found IRQ 11 for device 0000:00:02.1
uhci_hcd 0000:00:07.2: PCI legacy resume
PCI: Found IRQ 11 for device 0000:00:07.2
uhci_hcd 0000:00:07.2: uhci_resume
uhci_hcd 0000:00:07.2: uhci_check_and_reset_hc: legsup = 0x2000
uhci_hcd 0000:00:07.2: Performing full reset
usb usb1: root hub lost power or was reset
uhci_hcd 0000:00:07.2: suspend_rh
usb usb1: finish resume
uhci_hcd 0000:00:07.2: wakeup_rh
Restarting tasks...<7>hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
 done
Execute Method: [\_SI_._SST] (Node e3f8a8c8)
 acpi_ec-0508 [26] ec_intr_write         : Wrote [01] to address [0e]
 acpi_ec-0508 [26] ec_intr_write         : Wrote [00] to address [0d]
 acpi_ec-0508 [26] ec_intr_write         : Wrote [01] to address [0c]
 acpi_ec-0508 [26] ec_intr_write         : Wrote [80] to address [0e]
 acpi_ec-0508 [26] ec_intr_write         : Wrote [80] to address [0d]
 acpi_ec-0508 [26] ec_intr_write         : Wrote [80] to address [0c]
Execute Method: [\_WAK] (Node e3f8aac8)
 acpi_ec-0458 [26] ec_intr_read          : Read [96] from address [00]
 acpi_ec-0508 [26] ec_intr_write         : Wrote [d6] to address [00]
 acpi_ec-0458 [26] ec_intr_read          : Read [16] from address [32]
 acpi_ec-0508 [26] ec_intr_write         : Wrote [16] to address [32]
 acpi_ec-0458 [26] ec_intr_read          : Read [16] from address [32]
 acpi_ec-0508 [26] ec_intr_write         : Wrote [06] to address [32]
 acpi_ec-0458 [26] ec_intr_read          : Read [06] from address [32]
 acpi_ec-0508 [26] ec_intr_write         : Wrote [06] to address [32]
 acpi_ec-0458 [25] ec_intr_read          : Read [34] from address [36]
 acpi_ec-0458 [25] ec_intr_read          : <7>uhci_hcd 0000:00:07.2: suspend_rh (auto-stop)
Read [14] from address [34]
 acpi_ec-0458 [25] ec_intr_read          : Read [07] from address [16]
 acpi_ec-0508 [26] ec_intr_write         : Wrote [87] to address [16]
 acpi_ec-0458 [26] ec_intr_read          : Read [01] from address [3a]
 acpi_ec-0508 [26] ec_intr_write         : Wrote [01] to address [3a]
 acpi_ec-0508 [26] ec_intr_write         : Wrote [81] to address [52]
 acpi_ec-0508 [26] ec_intr_write         : Wrote [00] to address [53]
 acpi_ec-0508 [26] ec_intr_write         : Wrote [07] to address [50]
 acpi_ec-0458 [25] ec_intr_read          : Read [00] from address [50]
 acpi_ec-0458 [25] ec_intr_read          : Read [90] from address [51]
 acpi_ec-0458 [25] ec_intr_read          : Read [90] from address [51]
 acpi_ec-0458 [25] ec_intr_read          : Read [90] from address [51]
 acpi_ec-0458 [26] ec_intr_read          : Read [06] from address [32]
 acpi_ec-0508 [26] ec_intr_write         : Wrote [06] to address [32]
 acpi_ec-0458 [25] ec_intr_read          : Read [0f] from address [28]
 acpi_ec-0508 [26] ec_intr_write         : Wrote [8f] to address [28]
 acpi_ec-0458 [25] ec_intr_read          : Read [0f] from address [28]
 acpi_ec-0458 [25] ec_intr_read          : Read [0f] from address [28]
 acpi_ec-0458 [25] ec_intr_read          : Read [0f] from address [28]
 acpi_ec-0458 [25] ec_intr_read          : Read [86] from address [39]
 acpi_ec-0508 [26] ec_intr_write         : Wrote [18] to address [0e]
 acpi_ec-0508 [26] ec_intr_write         : Wrote [00] to address [0d]
 acpi_ec-0508 [26] ec_intr_write         : Wrote [10] to address [0c]
 acpi_ec-0458 [25] ec_intr_read          : Read [28] from address [17]
 acpi_ec-0508 [26] ec_intr_write         : Wrote [29] to address [17]
 acpi_ec-0458 [26] ec_intr_read          : Read [01] from address [3a]
 acpi_ec-0508 [26] ec_intr_write         : Wrote [01] to address [3a]
 acpi_ec-0508 [26] ec_intr_write         : Wrote [02] to address [52]
 acpi_ec-0508 [26] ec_intr_write         : Wrote [04] to address [53]
 acpi_ec-0508 [26] ec_intr_write         : Wrote [0b] to address [50]
 acpi_ec-0458 [25] ec_intr_read          : Read [00] from address [50]
 acpi_ec-0458 [25] ec_intr_read          : Read [00] from address [50]
 acpi_ec-0458 [25] ec_intr_read          : Read [80] from address [51]
 acpi_ec-0458 [25] ec_intr_read          : Read [80] from address [51]
 acpi_ec-0458 [25] ec_intr_read          : Read [80] from address [54]
 acpi_ec-0458 [25] ec_intr_read          : Read [0c] from address [55]
 acpi_ec-0458 [25] ec_intr_read          : Read [4e] from address [58]
 acpi_ec-0458 [25] ec_intr_read          : Read [0c] from address [59]
 acpi_ec-0458 [25] ec_intr_read          : Read [f4] from address [60]
 acpi_ec-0458 [25] ec_intr_read          : Read [0b] from address [61]
 acpi_ec-0458 [25] ec_intr_read          : Read [08] from address [62]
 acpi_ec-0458 [25] ec_intr_read          : Read [0c] from address [63]
Execute Method: [\_TZ_.THM0._PSV] (Node e3f8be48)
Execute Method: [\_TZ_.THM0._TC1] (Node e3f8bdc8)
Execute Method: [\_TZ_.THM0._TC2] (Node e3f8bd88)
Execute Method: [\_TZ_.THM0._TSP] (Node e3f8bd48)
Execute Method: [\_TZ_.THM0._AC0] (Node e3f8bf48)
 acpi_ec-0458 [34] ec_intr_read          : Read [00] from address [20]
Execute Method: [\_TZ_.THM0._TMP] (Node e3f8bf88)
 acpi_ec-0458 [36] ec_intr_read          : Read [01] from address [3a]
 acpi_ec-0508 [36] ec_intr_write         : Wrote [01] to address [3a]
 acpi_ec-0508 [36] ec_intr_write         : Wrote [02] to address [52]
 acpi_ec-0508 [36] ec_intr_write         : Wrote [04] to address [53]
 acpi_ec-0508 [36] ec_intr_write         : Wrote [0b] to address [50]
 acpi_ec-0458 [35] ec_intr_read          : Read [00] from address [50]
 acpi_ec-0458 [35] ec_intr_read          : Read [00] from address [50]
 acpi_ec-0458 [35] ec_intr_read          : Read [80] from address [51]
 acpi_ec-0458 [35] ec_intr_read          : Read [80] from address [51]
 acpi_ec-0458 [35] ec_intr_read          : Read [8a] from address [54]
 acpi_ec-0458 [35] ec_intr_read          : Read [0c] from address [55]
 acpi_ec-0458 [35] ec_intr_read          : Read [4e] from address [58]
 acpi_ec-0458 [35] ec_intr_read          : Read [0c] from address [59]
 acpi_ec-0458 [35] ec_intr_read          : Read [f4] from address [60]
 acpi_ec-0458 [35] ec_intr_read          : Read [0b] from address [61]
 acpi_ec-0458 [35] ec_intr_read          : Read [08] from address [62]
 acpi_ec-0458 [35] ec_intr_read          : Read [0c] from address [63]
Execute Method: [\_SI_._SST] (Node e3f8a8c8)
 acpi_ec-0458 [26] ec_intr_read          : Read [01] from address [3a]
 acpi_ec-0508 [26] ec_intr_write         : Wrote [00] to address [3a]
 acpi_ec-0508 [26] ec_intr_write         : Wrote [05] to address [06]
 acpi_ec-0508 [26] ec_intr_write         : Wrote [01] to address [0e]
 acpi_ec-0508 [26] ec_intr_write         : Wrote [00] to address [0d]
 acpi_ec-0508 [26] ec_intr_write         : Wrote [01] to address [0c]
 acpi_ec-0508 [26] ec_intr_write         : Wrote [80] to address [0e]
 acpi_ec-0508 [26] ec_intr_write         : Wrote [00] to address [0d]
 acpi_ec-0508 [26] ec_intr_write         : Wrote [00] to address [0c]
Execute Method: [\_SB_.LID0._PSW] (Node c1574808)
 acpi_ec-0458 [27] ec_intr_read          : Read [06] from address [32]
 acpi_ec-0508 [27] ec_intr_write         : Wrote [02] to address [32]
Execute Method: [\_SB_.SLPB._PSW] (Node c1574708)
ds: ds_open(socket 0)
ds: ds_open(socket 1)
ds: ds_open(socket 2)
pccard: card ejected from slot 1
PCMCIA: socket e36a8828: *** DANGER *** unable to remove socket power
ds: ds_release(socket 0)
ds: ds_release(socket 1)
# I think this where 'acpi -t' happens
Execute Method: [\_SB_.PCI0.ISA0.EC0_.BAT1._BST] (Node e3f82b48)
 acpi_ec-0458 [28] ec_intr_read          : Read [00] from address [3a]
 acpi_ec-0508 [28] ec_intr_write         : Wrote [00] to address [3a]
 acpi_ec-0508 [28] ec_intr_write         : Wrote [02] to address [52]
 acpi_ec-0508 [28] ec_intr_write         : Wrote [11] to address [53]
 acpi_ec-0508 [28] ec_intr_write         : Wrote [0b] to address [50]
 acpi_ec-0458 [27] ec_intr_read          : Read [00] from address [50]
 acpi_ec-0458 [27] ec_intr_read          : Read [00] from address [50]
 acpi_ec-0458 [27] ec_intr_read          : Read [80] from address [51]
 acpi_ec-0458 [27] ec_intr_read          : Read [80] from address [51]
 acpi_ec-0458 [27] ec_intr_read          : Read [1c] from address [74]
 acpi_ec-0458 [27] ec_intr_read          : Read [84] from address [64]
 acpi_ec-0458 [27] ec_intr_read          : Read [30] from address [65]
 acpi_ec-0458 [27] ec_intr_read          : Read [ff] from address [60]
 acpi_ec-0458 [27] ec_intr_read          : Read [66] from address [61]
 acpi_ec-0458 [27] ec_intr_read          : Read [00] from address [62]
 acpi_ec-0458 [27] ec_intr_read          : Read [00] from address [63]
 acpi_ec-0458 [27] ec_intr_read          : Read [00] from address [66]
 acpi_ec-0458 [27] ec_intr_read          : Read [00] from address [67]
 acpi_ec-0458 [27] ec_intr_read          : Read [00] from address [54]
 acpi_ec-0458 [27] ec_intr_read          : Read [86] from address [39]
 acpi_ec-0458 [27] ec_intr_read          : Read [86] from address [39]
 acpi_ec-0458 [27] ec_intr_read          : Read [86] from address [39]
Execute Method: [\_SB_.PCI0.ISA0.EC0_.BAT1._BIF] (Node e3f82b88)
 acpi_ec-0458 [27] ec_intr_read          : Read [86] from address [39]
 acpi_ec-0458 [28] ec_intr_read          : Read [00] from address [3a]
 acpi_ec-0508 [28] ec_intr_write         : Wrote [00] to address [3a]
 acpi_ec-0508 [28] ec_intr_write         : Wrote [02] to address [52]
 acpi_ec-0508 [28] ec_intr_write         : Wrote [11] to address [53]
 acpi_ec-0508 [28] ec_intr_write         : Wrote [0b] to address [50]
 acpi_ec-0458 [27] ec_intr_read          : Read [00] from address [50]
 acpi_ec-0458 [27] ec_intr_read          : Read [00] from address [50]
 acpi_ec-0458 [27] ec_intr_read          : Read [80] from address [51]
 acpi_ec-0458 [27] ec_intr_read          : Read [80] from address [51]
 acpi_ec-0458 [27] ec_intr_read          : Read [1c] from address [74]
 acpi_ec-0458 [27] ec_intr_read          : Read [00] from address [54]
 acpi_ec-0458 [27] ec_intr_read          : Read [20] from address [58]
 acpi_ec-0458 [27] ec_intr_read          : Read [76] from address [59]
 acpi_ec-0458 [27] ec_intr_read          : Read [00] from address [5a]
 acpi_ec-0458 [27] ec_intr_read          : Read [00] from address [5b]
 acpi_ec-0458 [27] ec_intr_read          : Read [ff] from address [5c]
 acpi_ec-0458 [27] ec_intr_read          : Read [66] from address [5d]
 acpi_ec-0458 [27] ec_intr_read          : Read [00] from address [5e]
 acpi_ec-0458 [27] ec_intr_read          : Read [00] from address [5f]
Execute Method: [\_SB_.PCI0.ISA0.EC0_.BAT0._BST] (Node e3f82f08)
 acpi_ec-0458 [28] ec_intr_read          : Read [00] from address [3a]
 acpi_ec-0508 [28] ec_intr_write         : Wrote [00] to address [3a]
 acpi_ec-0508 [28] ec_intr_write         : Wrote [02] to address [52]
 acpi_ec-0508 [28] ec_intr_write         : Wrote [10] to address [53]
 acpi_ec-0508 [28] ec_intr_write         : Wrote [0b] to address [50]
 acpi_ec-0458 [27] ec_intr_read          : Read [00] from address [50]
 acpi_ec-0458 [27] ec_intr_read          : Read [00] from address [50]
 acpi_ec-0458 [27] ec_intr_read          : Read [80] from address [51]
 acpi_ec-0458 [27] ec_intr_read          : Read [80] from address [51]
 acpi_ec-0458 [27] ec_intr_read          : Read [1c] from address [74]
 acpi_ec-0458 [27] ec_intr_read          : Read [c0] from address [64]
 acpi_ec-0458 [27] ec_intr_read          : Read [30] from address [65]
 acpi_ec-0458 [27] ec_intr_read          : Read [80] from address [60]
 acpi_ec-0458 [27] ec_intr_read          : Read [89] from address [61]
 acpi_ec-0458 [27] ec_intr_read          : Read [00] from address [62]
 acpi_ec-0458 [27] ec_intr_read          : Read [00] from address [63]
 acpi_ec-0458 [27] ec_intr_read          : Read [00] from address [66]
 acpi_ec-0458 [27] ec_intr_read          : Read [00] from address [67]
 acpi_ec-0458 [27] ec_intr_read          : Read [00] from address [54]
 acpi_ec-0458 [27] ec_intr_read          : Read [86] from address [38]
 acpi_ec-0458 [27] ec_intr_read          : Read [86] from address [38]
 acpi_ec-0458 [27] ec_intr_read          : Read [86] from address [38]
Execute Method: [\_SB_.PCI0.ISA0.EC0_.BAT0._BIF] (Node e3f82f48)
 acpi_ec-0458 [27] ec_intr_read          : Read [86] from address [38]
 acpi_ec-0458 [28] ec_intr_read          : Read [00] from address [3a]
 acpi_ec-0508 [28] ec_intr_write         : Wrote [00] to address [3a]
 acpi_ec-0508 [28] ec_intr_write         : Wrote [02] to address [52]
 acpi_ec-0508 [28] ec_intr_write         : Wrote [10] to address [53]
 acpi_ec-0508 [28] ec_intr_write         : Wrote [0b] to address [50]
 acpi_ec-0458 [27] ec_intr_read          : Read [00] from address [50]
 acpi_ec-0458 [27] ec_intr_read          : Read [00] from address [50]
 acpi_ec-0458 [27] ec_intr_read          : Read [80] from address [51]
 acpi_ec-0458 [27] ec_intr_read          : Read [80] from address [51]
 acpi_ec-0458 [27] ec_intr_read          : Read [1c] from address [74]
 acpi_ec-0458 [27] ec_intr_read          : Read [00] from address [54]
 acpi_ec-0458 [27] ec_intr_read          : Read [00] from address [58]
 acpi_ec-0458 [27] ec_intr_read          : Read [87] from address [59]
 acpi_ec-0458 [27] ec_intr_read          : Read [00] from address [5a]
 acpi_ec-0458 [27] ec_intr_read          : Read [00] from address [5b]
 acpi_ec-0458 [27] ec_intr_read          : Read [80] from address [5c]
 acpi_ec-0458 [27] ec_intr_read          : Read [89] from address [5d]
 acpi_ec-0458 [27] ec_intr_read          : Read [00] from address [5e]
 acpi_ec-0458 [27] ec_intr_read          : Read [00] from address [5f]
Execute Method: [\_TZ_.THM0._TMP] (Node e3f8bf88)
 acpi_ec-0458 [29] ec_intr_read          : Read [00] from address [3a]
 acpi_ec-0508 [29] ec_intr_write         : Wrote [00] to address [3a]
 acpi_ec-0508 [29] ec_intr_write         : Wrote [02] to address [52]
 acpi_ec-0508 [29] ec_intr_write         : Wrote [04] to address [53]
 acpi_ec-0508 [29] ec_intr_write         : Wrote [0b] to address [50]
 acpi_ec-0458 [28] ec_intr_read          : Read [00] from address [50]
 acpi_ec-0458 [28] ec_intr_read          : Read [00] from address [50]
 acpi_ec-0458 [28] ec_intr_read          : Read [80] from address [51]
 acpi_ec-0458 [28] ec_intr_read          : Read [80] from address [51]
 acpi_ec-0458 [28] ec_intr_read          : Read [6c] from address [54]
 acpi_ec-0458 [28] ec_intr_read          : Read [0c] from address [55]
 acpi_ec-0458 [28] ec_intr_read          : Read [4e] from address [58]
 acpi_ec-0458 [28] ec_intr_read          : Read [0c] from address [59]
 acpi_ec-0458 [28] ec_intr_read          : Read [f4] from address [60]
 acpi_ec-0458 [28] ec_intr_read          : Read [0b] from address [61]
 acpi_ec-0458 [28] ec_intr_read          : Read [08] from address [62]
 acpi_ec-0458 [28] ec_intr_read          : Read [0c] from address [63]

