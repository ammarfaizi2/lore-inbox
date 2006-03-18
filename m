Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751440AbWCRQ1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbWCRQ1e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 11:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbWCRQ1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 11:27:34 -0500
Received: from elasmtp-mealy.atl.sa.earthlink.net ([209.86.89.69]:36332 "EHLO
	elasmtp-mealy.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1751440AbWCRQ1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 11:27:33 -0500
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
In-Reply-To: Your message of "Sat, 18 Mar 2006 23:58:49 +0800."
             <3ACA40606221794F80A5670F0AF15F84041AC269@pdsmsx403> 
X-Mailer: MH-E 7.91; nmh 1.1; GNU Emacs 21.4.1
Date: Sat, 18 Mar 2006 11:27:05 -0500
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FKeGf-00015X-Dm@approximate.corpus.cam.ac.uk>
X-ELNK-Trace: dcd19350f30646cc26f3bd1b5f75c9f474bf435c0eb9d478d165aa9320335d7163c3c80ea61068df1261ca2a90518aa9350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.41.6.91
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> just return AE_OK, because we are hacking. :-)

I found that out the hard way.  I first tried AE_BAD_PARAMETER but the
kernel paniced on boot, which I don't understand.  So then I switched to
returning AE_OK, and it booted fine.  But it hung on the *second* sleep
cycle.  So the problem got worse, or the bug is slithering around and
shows up in odd places depending what we do.

>> That's in my lilo.conf so all kernels I test use those options.  I
>> can send you the dmesgs from the suspends without the ugly hack (and
>> will send them from the upcoming suspends, with the ugly hack).

> Thanks, I'm waiting for that to understand if the hack is clean for
> killing unwanted AML methods call.

Here first are the dmesgs from suspending with a vanilla 2.6.16-rc5.  I
did only one cycle so that it didn't hang and I could edit this email
without rebooting (but later suspends produce the same method calls, I'm
90% sure):

# the sleep dmesgs
PM: Preparing system for mem sleep
Stopping tasks: =======================================================|
Execute Method: [\_SB_.LID0._PSW] (Node c1564808)
Execute Method: [\_SB_.SLPB._PSW] (Node c1564708)
Execute Method: [\_S3_] (Node c157a988)
Execute Method: [\_PTS] (Node c157ab48)
Execute Method: [\_SI_._SST] (Node c157a8c8)
uhci_hcd 0000:00:07.2: suspend_rh
uhci_hcd 0000:00:07.2: uhci_suspend
uhci_hcd 0000:00:07.2: --> PCI D0/legacy
PM: Entering mem sleep

# and here are the wakeup dmesgs

Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Back to C!
PM: Finishing wakeup.
Execute Method: [\_GPE._L0B] (Node c157a848)
PCI: Found IRQ 11 for device 0000:00:02.0
PCI: Sharing IRQ 11 with 0000:00:06.0
PCI: Sharing IRQ 11 with 0000:01:00.0
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
Execute Method: [\_SI_._SST] (Node c157a8c8)
Execute Method: [\_WAK] (Node c157aac8)
Execute Method: [\_TZ_.THM0._PSV] (Node c157be48)
Execute Method: [\_TZ_.THM0._TC1] (Node c157bdc8)
Execute Method: [\_TZ_.THM0._TC2] (Node c157bd88)
Execute Method: [\_TZ_.THM0._TSP] (Node c157bd48)
Execute Method: [\_TZ_.THM0._AC0] (Node c157bf48)
Execute Method: [\_TZ_.THM0._TMP] (Node c157bf88)
Execute Method: [\_SI_._SST] (Node c157a8c8)
Execute Method: [\_TZ_.THM2._AC0] (Node c157bb48)
Execute Method: [\_TZ_.THM2._TMP] (Node c157bb88)
Execute Method: [\_TZ_.THM6._AC0] (Node c157b908)
Execute Method: [\_TZ_.THM6._TMP] (Node c157b948)
Execute Method: [\_TZ_.THM7._AC0] (Node c157b6c8)
Execute Method: [\_TZ_.THM7._TMP] (Node c157b708)<7>uhci_hcd 0000:00:07.2: suspend_rh (auto-stop)

Execute Method: [\_SB_.LID0._PSW] (Node c1564808)
Execute Method: [\_SB_.SLPB._PSW] (Node c1564708)
# next msgs are from 'cardctl eject'
ds: ds_open(socket 0)
ds: ds_open(socket 1)
ds: ds_open(socket 2)
pccard: card ejected from slot 1
PCMCIA: socket e231c028: *** DANGER *** unable to remove socket power
ds: ds_release(socket 0)
ds: ds_release(socket 1)


# now for the dmesgs with the latest hack (returning AE_OK) for the
# first suspend cycle (which didn't hang):

Stopping tasks: ====================================================|
Execute Method: [\_SB_.LID0._PSW] (Node c1564808)
Execute Method: [\_SB_.SLPB._PSW] (Node c1564708)
Execute Method: [\_S3_] (Node c157a988)
Execute Method: [\_PTS] (Node c157ab48)
Execute Method: [\_SI_._SST] (Node c157a8c8)
uhci_hcd 0000:00:07.2: suspend_rh
uhci_hcd 0000:00:07.2: uhci_suspend
uhci_hcd 0000:00:07.2: --> PCI D0/legacy
PM: Entering mem sleep

# and the wakeup msgs

Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Back to C!
PM: Finishing wakeup.
PCI: Found IRQ 11 for device 0000:00:02.0
PCI: Sharing IRQ 11 with 0000:00:06.0
PCI: Sharing IRQ 11 with 0000:01:00.0
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
Execute Method: [\_SI_._SST] (Node c157a8c8)
Execute Method: [\_WAK] (Node c157aac8)
Execute Method: [\_TZ_.THM0._PSV] (Node c157be48)
Execute Method: [\_TZ_.THM0._TC1] (Node c157bdc8)
Execute Method: [\_TZ_.THM0._TC2] (Node c157bd88)
Execute Method: [\_TZ_.THM0._TSP] (Node c157bd48)
Execute Method: [\_TZ_.THM0._AC0] (Node c157bf48)
Execute Method: [\_SI_._SST] (Node c157a8c8)
Execute Method: [\_TZ_.THM0._TMP] (Node c157bf88)
Execute Method: [\_TZ_.THM2._AC0] (Node c157bb48)
Execute Method: [\_TZ_.THM2._TMP] (Node c157bb88)
Execute Method: [\_TZ_.PFN0._OFF] (Node c157a288)
Execute Method: [\_TZ_.PFN0._STA] (Node c157a308)
Execute Method: [\_TZ_.THM6._AC0] (Node c157b908)
Execute Method: <7>uhci_hcd 0000:00:07.2: suspend_rh (auto-stop)
[\_TZ_.THM6._TMP] (Node c157b948)
Execute Method: [\_TZ_.THM7._AC0] (Node c157b6c8)
Execute Method: [\_TZ_.THM7._TMP] (Node c157b708)
Execute Method: [\_SB_.LID0._PSW] (Node c1564808)
Execute Method: [\_SB_.SLPB._PSW] (Node c1564708)
# next msgs are from 'cardctl eject'
ds: ds_open(socket 0)
ds: ds_open(socket 1)
ds: ds_open(socket 2)
pccard: card ejected from slot 1
PCMCIA: socket e34e1828: *** DANGER *** unable to remove socket power
ds: ds_release(socket 0)
ds: ds_release(socket 1)
# I think these were after the wakeup when the fan turned on.
Execute Method: [\_SB_.PCI0.ISA0.EC0_._Q42] (Node c1572408)
Execute Method: [\_TZ_.THM2._AC0] (Node c157bb48)
Execute Method: [\_TZ_.THM2._TMP] (Node c157bb88)
Execute Method: [\_TZ_.PFN0._ON_] (Node c157a2c8)
Execute Method: [\_TZ_.PFN0._STA] (Node c157a308)
Execute Method: [\_TZ_.THM2._TMP] (Node c157bb88)
