Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268719AbUIXMrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268719AbUIXMrK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 08:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268717AbUIXMrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 08:47:09 -0400
Received: from smtp2.netcabo.pt ([212.113.174.29]:63024 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S268720AbUIXMpV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 08:45:21 -0400
Message-ID: <1076.195.245.190.93.1096029825.squirrel@195.245.190.93>
Date: Fri, 24 Sep 2004 13:43:45 +0100 (WEST)
Subject: OHCI_QUIRK_INITRESET (was: 2.6.9-rc2-mm2 ohci_hcd doesn't work)
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: linux-kernel@vger.kernel.org
Cc: "David Brownell" <david-b@pacbell.net>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>,
       "Bjorn Helgaas" <bjorn.helgaas@hp.com>,
       "David Brownell" <dbrownell@users.sourceforge.net>,
       "Roman Weissgaerber" <weissg@vienna.at>,
       linux-usb-devel@lists.sourceforge.net, "Ingo Molnar" <mingo@elte.hu>,
       "K.R. Foley" <kr@cybsft.com>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20040924134345_52014"
X-Priority: 3 (Normal)
Importance: Normal
References: <20040908082050.GA680@elte.hu>                        
    <1094683020.1362.219.camel@krustophenia.net>                        
    <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu>       
                     <414F8CFB.3030901@cybsft.com>      
    <20040921071854.GA7604@elte.hu>                        
    <20040921074426.GA10477@elte.hu>    <20040922103340.GA9683@elte.hu>    
                        <20040923122838.GA9252@elte.hu>                    
        <24137.195.245.190.93.1095946528.squirrel@195.245.190.93>          
                  <20040923134000.GA15455@elte.hu>                  
    <35929.195.245.190.93.1095956611.squirrel@195.245.190.93>              
     <48836.195.245.190.94.1095962870.squirrel@195.245.190.94>
In-Reply-To: <48836.195.245.190.94.1095962870.squirrel@195.245.190.94>
X-OriginalArrivalTime: 24 Sep 2004 12:44:57.0398 (UTC) FILETIME=[4C386560:01C4A234]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20040924134345_52014
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi,

My laptop is a Compaq Presario 2516EA, loaded with Mandrake 10.0 Official,
which has been working fine until 2.6.9-rc2. Incidentally with -mm1 and
-mm2 the USB subsystem start failing miserably, due to errors while
(re)starting the ohci_hcd stuff.

By lurking on some recent threads on lkml, and following some other
suggestions about this very problem, I've tried every combination on the
boot prompt: pci=routeirq, acpi=off, softirq-preempt=0, harirq-preempt=0.

This laptop also has the USB legacy BIOS mode switch. Tried that too.

All combinations resulted in the same failure, without exception. Here
comes the relevant dmesg lines, regarding the ohci_hcd failure (note: USB
verbose debug messages are turned on):

[...]
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ACPI: PCI Interrupt Link [LNK8] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: USB HC TakeOver from BIOS/SMM
requesting new irq thread for IRQ10...
ohci_hcd 0000:00:02.0: irq 10, pci mem 0xd4000000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.0: resetting from state 'reset', control = 0x0
ohci_hcd 0000:00:02.0: init err (00002edf 0000)
ohci_hcd 0000:00:02.0: can't start
ohci_hcd 0000:00:02.0: stop reset controller (state 0x00)
ohci_hcd 0000:00:02.0: OHCI controller state
ohci_hcd 0000:00:02.0: OHCI 1.0, with legacy support registers
ohci_hcd 0000:00:02.0: control 0x0c0 HCFS=suspend CBSR=0
ohci_hcd 0000:00:02.0: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:02.0: intrstatus 0x00000000
ohci_hcd 0000:00:02.0: intrenable 0x00000000
ohci_hcd 0000:00:02.0: hcca frame #0000
ohci_hcd 0000:00:02.0: roothub.a 03000003 POTPGT=3 NDP=3
ohci_hcd 0000:00:02.0: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:02.0: roothub.status 00000000
ohci_hcd 0000:00:02.0: roothub.portstatus [0] 0x00000000
ohci_hcd 0000:00:02.0: roothub.portstatus [1] 0x00000000
ohci_hcd 0000:00:02.0: roothub.portstatus [2] 0x00000000
ohci_hcd 0000:00:02.0: init error -75
ohci_hcd 0000:00:02.0: remove, state 0
ohci_hcd 0000:00:02.0: roothub graceful disconnect
usb_disconnect nodev
ohci_hcd 0000:00:02.0: stop reset controller (state 0x00)
ohci_hcd 0000:00:02.0: OHCI controller state
ohci_hcd 0000:00:02.0: OHCI 1.0, with legacy support registers
ohci_hcd 0000:00:02.0: control 0x000 HCFS=reset CBSR=0
ohci_hcd 0000:00:02.0: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:02.0: intrstatus 0x00000000
ohci_hcd 0000:00:02.0: intrenable 0x00000000
ohci_hcd 0000:00:02.0: roothub.a 03000003 POTPGT=3 NDP=3
ohci_hcd 0000:00:02.0: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:02.0: roothub.status 00000000
ohci_hcd 0000:00:02.0: roothub.portstatus [0] 0x00000000
ohci_hcd 0000:00:02.0: roothub.portstatus [1] 0x00000000
ohci_hcd 0000:00:02.0: roothub.portstatus [2] 0x00000000
ohci_hcd 0000:00:02.0: USB bus 1 deregistered
ohci_hcd: probe of 0000:00:02.0 failed with error -75
ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:0f.0[A] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:00:0f.0: OHCI Host Controller
ohci_hcd 0000:00:0f.0: USB HC TakeOver from BIOS/SMM
ohci_hcd 0000:00:0f.0: irq 10, pci mem 0xd4009000
ohci_hcd 0000:00:0f.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:0f.0: resetting from state 'reset', control = 0x0
ohci_hcd 0000:00:0f.0: init err (00002edf 0000)
ohci_hcd 0000:00:0f.0: can't start
ohci_hcd 0000:00:0f.0: stop reset controller (state 0x00)
ohci_hcd 0000:00:0f.0: OHCI controller state
ohci_hcd 0000:00:0f.0: OHCI 1.0, with legacy support registers
ohci_hcd 0000:00:0f.0: control 0x0c0 HCFS=suspend CBSR=0
ohci_hcd 0000:00:0f.0: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:0f.0: intrstatus 0x00000000
ohci_hcd 0000:00:0f.0: intrenable 0x00000000
ohci_hcd 0000:00:0f.0: hcca frame #0000
ohci_hcd 0000:00:0f.0: roothub.a 03000003 POTPGT=3 NDP=3
ohci_hcd 0000:00:0f.0: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:0f.0: roothub.status 00000000
ohci_hcd 0000:00:0f.0: roothub.portstatus [0] 0x00000000
ohci_hcd 0000:00:0f.0: roothub.portstatus [1] 0x00000000
ohci_hcd 0000:00:0f.0: roothub.portstatus [2] 0x00000000
ohci_hcd 0000:00:0f.0: init error -75
ohci_hcd 0000:00:0f.0: remove, state 0
ohci_hcd 0000:00:0f.0: roothub graceful disconnect
usb_disconnect nodev
ohci_hcd 0000:00:0f.0: stop reset controller (state 0x00)
ohci_hcd 0000:00:0f.0: OHCI controller state
ohci_hcd 0000:00:0f.0: OHCI 1.0, with legacy support registers
ohci_hcd 0000:00:0f.0: control 0x000 HCFS=reset CBSR=0
ohci_hcd 0000:00:0f.0: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:0f.0: intrstatus 0x00000000
ohci_hcd 0000:00:0f.0: intrenable 0x00000000
ohci_hcd 0000:00:0f.0: roothub.a 03000003 POTPGT=3 NDP=3
ohci_hcd 0000:00:0f.0: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:0f.0: roothub.status 00000000
ohci_hcd 0000:00:0f.0: roothub.portstatus [0] 0x00000000
ohci_hcd 0000:00:0f.0: roothub.portstatus [1] 0x00000000
ohci_hcd 0000:00:0f.0: roothub.portstatus [2] 0x00000000
ohci_hcd 0000:00:0f.0: USB bus 1 deregistered
ohci_hcd: probe of 0000:00:0f.0 failed with error -75
[...]


Then, in a silent suggestion from David Brownell, I hacked ohci_hcd.c,
forcing the OHCI_QUIRK_INITRESET flag behaviour, build a new kernel and
modules and voila', all USB is back to functionality.

Here goes the complete dmesg output after the new kernel boot, where
everything seems to work as it should (note: I'm using Ingo Molnar's
voluntary-preempt-2.6.9-rc2-mm3-S6 patch):

[...]
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ACPI: PCI Interrupt Link [LNK8] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: USB HC TakeOver from BIOS/SMM
requesting new irq thread for IRQ10...
ohci_hcd 0000:00:02.0: irq 10, pci mem 0xd4000000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.0: resetting from state 'reset', control = 0x0
ohci_hcd 0000:00:02.0: OHCI_QUIRK_INITRESET forced!
ohci_hcd 0000:00:02.0: OHCI controller state
ohci_hcd 0000:00:02.0: OHCI 1.0, with legacy support registers
ohci_hcd 0000:00:02.0: control 0x083 HCFS=operational CBSR=3
ohci_hcd 0000:00:02.0: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:02.0: intrstatus 0x00000004 SF
ohci_hcd 0000:00:02.0: intrenable 0x8000000a MIE RD WDH
ohci_hcd 0000:00:02.0: hcca frame #0007
ohci_hcd 0000:00:02.0: roothub.a 03000203 POTPGT=3 NPS NDP=3
ohci_hcd 0000:00:02.0: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:02.0: roothub.status 00008000 DRWE
ohci_hcd 0000:00:02.0: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:02.0: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:00:02.0: roothub.portstatus [2] 0x00000100 PPS
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: default language 0x0409
usb usb1: Product: OHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.9-rc2-mm3-S6.1 ohci_hcd
usb usb1: SerialNumber: 0000:00:02.0
usb usb1: hotplug
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: global over-current protection
hub 1-0:1.0: power on to power good time: 6ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
ohci_hcd 0000:00:02.0: created debug files
ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:0f.0[A] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:00:0f.0: OHCI Host Controller
ohci_hcd 0000:00:0f.0: USB HC TakeOver from BIOS/SMM
ohci_hcd 0000:00:0f.0: irq 10, pci mem 0xd4009000
ohci_hcd 0000:00:0f.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:0f.0: resetting from state 'reset', control = 0x0
ohci_hcd 0000:00:02.0: suspend root hub
ohci_hcd 0000:00:0f.0: OHCI_QUIRK_INITRESET forced!
ohci_hcd 0000:00:0f.0: OHCI controller state
ohci_hcd 0000:00:0f.0: OHCI 1.0, with legacy support registers
ohci_hcd 0000:00:0f.0: control 0x083 HCFS=operational CBSR=3
ohci_hcd 0000:00:0f.0: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:0f.0: intrstatus 0x00000004 SF
ohci_hcd 0000:00:0f.0: intrenable 0x8000000a MIE RD WDH
ohci_hcd 0000:00:0f.0: hcca frame #0007
ohci_hcd 0000:00:0f.0: roothub.a 03000203 POTPGT=3 NPS NDP=3
ohci_hcd 0000:00:0f.0: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:0f.0: roothub.status 00008000 DRWE
ohci_hcd 0000:00:0f.0: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:0f.0: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:00:0f.0: roothub.portstatus [2] 0x00000100 PPS
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: default language 0x0409
usb usb2: Product: OHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.9-rc2-mm3-S6.1 ohci_hcd
usb usb2: SerialNumber: 0000:00:0f.0
usb usb2: hotplug
usb usb2: adding 2-0:1.0 (config #1, interface 0)
usb 2-0:1.0: hotplug
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: no power switching (usb 1.0)
hub 2-0:1.0: global over-current protection
hub 2-0:1.0: power on to power good time: 6ms
hub 2-0:1.0: local power source is good
hub 2-0:1.0: no over-current condition exists
ohci_hcd 0000:00:0f.0: created debug files
ohci_hcd 0000:00:0f.0: suspend root hub
[...]


OK. And yes, I know this is a very dirty hack (see attached patch), that
most probably only serves for me and this specific hardware configuration.
I didn't found any other way to set this ohci->flag |=
OHCI_QUIRK_INITRESET; other than forcing it being hardcoded. Sorry.

So I'll ask if this flag may be set as an ohci_hcd module parameter or else?

Please forgive my lack of knowledge in this matter. Probably is just
lazziness :)

Cheers and thanks anyway.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org


------=_20040924134345_52014
Content-Type: text/plain; name="ohci_hcd-quirk-initreset-force.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
      filename="ohci_hcd-quirk-initreset-force.patch"

diff -duPNr linux.0/drivers/usb/host/ohci-hcd.c linux.1/drivers/usb/host/ohci-hcd.c
--- linux.0/drivers/usb/host/ohci-hcd.c	2004-09-24 11:07:00.982690336 +0100
+++ linux.1/drivers/usb/host/ohci-hcd.c	2004-09-24 11:19:06.232435616 +0100
@@ -564,11 +564,12 @@
 	 * (SiS, OPTi ...), so reset again instead.  SiS doesn't need
 	 * this if we write fmInterval after we're OPERATIONAL.
 	 */
-	if (ohci->flags & OHCI_QUIRK_INITRESET) {
+	 ohci_dbg(ohci, "OHCI_QUIRK_INITRESET forced!\n");
+/*	if (ohci->flags & OHCI_QUIRK_INITRESET) { */
 		writel (ohci->hc_control, &ohci->regs->control);
 		// flush those writes
 		(void) ohci_readl (&ohci->regs->control);
-	}
+/*	} */
 	writel (ohci->fminterval, &ohci->regs->fminterval);
 
 	/* Tell the controller where the control and bulk lists are
------=_20040924134345_52014--


