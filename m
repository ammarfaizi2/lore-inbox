Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbUAOOMw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 09:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263607AbUAOOMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 09:12:52 -0500
Received: from chello080109223065.lancity.graz.surfer.at ([80.109.223.65]:34795
	"EHLO lexx.delysid.org") by vger.kernel.org with ESMTP
	id S262040AbUAOOMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 09:12:50 -0500
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: [2.4.23&&2.6.1 ohci] USB HC TakeOver failed!
From: Mario Lang <mlang@delysid.org>
Date: Thu, 15 Jan 2004 15:12:56 +0100
Message-ID: <87llo95mhj.fsf@lexx.delysid.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I just got my new JVC MP-XP7250 which has USB 2.0.
The old version (XP7210) had only USB 1.1, and the usb-ohci
driver of 2.4.x and 2.5.x worked fine on that hardware.
But on the XP7250, I can't seem to get USB 1.1
devices working.  ehci-hcd loads fine without
any troubles, and if I connect a USB 2.0 FlashDisk
for instance, it is recognized and works.
But if I load ohci-hcd (2.6.1), I do get the following:

ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:0f.0: OHCI Host Controller
ohci_hcd 0000:00:0f.0: USB HC TakeOver failed!
ohci_hcd 0000:00:0f.0: can't reset
drivers/usb/core/hcd-pci.c: init 0000:00:0f.0 fail, -1
ohci_hcd: probe of 0000:00:0f.0 failed with error -1
ohci_hcd 0000:00:0f.1: OHCI Host Controller
ohci_hcd 0000:00:0f.1: USB HC TakeOver failed!
ohci_hcd 0000:00:0f.1: can't reset
drivers/usb/core/hcd-pci.c: init 0000:00:0f.1 fail, -1
ohci_hcd: probe of 0000:00:0f.1 failed with error -1

lspci |grep 00:0f
00:0f.0 USB Controller: NEC Corporation USB (rev 43)
00:0f.1 USB Controller: NEC Corporation USB (rev 43)
00:0f.2 USB Controller: NEC Corporation: Unknown device 00e0 (rev 04)

ehci-hcd seems to attach to 00:0f.2, and ohci-hcd
tries to grab 00:0f.0 and 00:0f.1, but fails on both.

This is fairly problematic for me, since I absolutely
do need a USB 1.1 only serial adaptor to be
able to use the machine at all (Braille display)....  So any
help would really be appreciated.  I'd be willing to test patches too!

Searching for this bug on google reveals that
in the past years, several patches were written for the
HC TakeOver problem.  Is this a common breakage?

P.S.: I believe about the same problem was recently reported
to linux-usb-users (same laptop, same HC TakeOver message).  The poster
didn't get a reply to his enquiry though :-(.

-- 
Thanks,
  Mario
