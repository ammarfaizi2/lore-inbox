Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWAVIaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWAVIaH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 03:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWAVIaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 03:30:06 -0500
Received: from fluido.speedxs.nl ([83.98.238.192]:45067 "EHLO fluido.as")
	by vger.kernel.org with ESMTP id S1751262AbWAVIaF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 03:30:05 -0500
Date: Sun, 22 Jan 2006 09:30:03 +0100
From: "Carlo E. Prelz" <fluido@fluido.as>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: ATI RS480-based motherboard: stuck while booting with kernel >= 2.6.15 rc1
Message-ID: <20060122083003.GB1315@epio.fluido.as>
References: <20060120123202.GA1138@epio.fluido.as> <20060121010932.5d731f90.akpm@osdl.org> <20060121125741.GA13470@epio.fluido.as> <20060121125822.570b0d99.akpm@osdl.org> <20060122074034.GA1315@epio.fluido.as> <20060121235546.68f50bd5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060121235546.68f50bd5.akpm@osdl.org>
X-operating-system: Linux epio 2.6.14
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Subject: Re: ATI RS480-based motherboard: stuck while booting with kernel >= 2.6.15 rc1
	Date: sab 21 gen 06 11:55:46 -0800

Quoting Andrew Morton (akpm@osdl.org):

> > and 1002:4373 is the USB2 (EHCI) controller. I attach the output of
> > lspci -vx. Even with 2.6.14.6, I have problems with USB. It did not
> > work at all, then I downloaded the latest bios, and now, right after
> > boot, usb works OK.
> 
> OK, so it sounds like quirk_usb_disable_ehci() caused your machine to hang
> with the old BIOS.  That's fairly bad behaviour from the kernel, even
> though the BIOS presumably had some problems.

It did not hang. When inserting USB disks, I got messages like:

ehci_hcd 0000:00:13.2: Unlink after no-IRQ?  Controller is probably using the wrong IRQ.
usb 1-1: device not accepting address 2, error -110

and the usb-storage module was not loaded. But the kernel went on
working. After upgrading the BIOS, with the same kernel, the USB disk
was recognized. But I now notice that the log file, with both old and
new BIOS, contains these lines:

ehci_hcd 0000:00:13.2: BIOS handoff failed (160, 01010001)
ehci_hcd 0000:00:13.2: continuing after BIOS bug...
ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:13.2: irq 18, io mem 0xfe02b000
ehci_hcd 0000:00:13.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004

(only, the IRQ number changed from 10 to 18 after changing BIOS)

> Can you please gather some more details on this and prepare a new report? 
> The full demsg output, machine description, etc.  It might be best to do
> this via a new bugzilla.kernel.org record so we know where to find
> it.

I will try that. I saw on apic.c that APIC error 40 should mean
'received illegal vector,' but I have no clue about how to interpret
this. 

I will now play a bit with BIOS USB parameters.

Carlo

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido@fluido.as             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)
