Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbVGLC4C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbVGLC4C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 22:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbVGLC4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 22:56:02 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:27898 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261899AbVGLCz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 22:55:59 -0400
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: How to find if BIOS has already enabled the device
Date: Mon, 11 Jul 2005 22:55:07 -0400
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200507112255.08080.kernel-stuff@comcast.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sad, 2005-05-28 at 14:57, Parag Warudkar wrote:
> > This current problem of Hang-On-Boot if USB drive is attached does not 
happen 
> > with Windows - so it is some sort of additional (unnecessary?) thing which 
> > Linux does and the BIOS doesn't like.  (Like re-enabling the controller 
even 
> > if BIOS has already enabled it or some such.)

> > Alan Cox wrote:
> Provide dmesg output and we might be able to guess. The first obvious
> candidate would be the BIOS refusing to do a handover if it booted from
> USB disk.

Hi Alan

Sorry for digging this out so late - (Quick recap - My machine hangs for 
couple minutes on boot if USB storage disk is attached - hang occurs in 
pci_enable_device).

I have filed a bug to track this one - 
http://bugme.osdl.org/show_bug.cgi?id=4711

Further analysis points towards  wrong/differing IRQ assigments being the 
cause of this hang. I observed that when the machine hangs, the IRQ 
assignment looks like -

18:        379   IO-APIC-level  eth0   
 19:          3   IO-APIC-level  ohci1394   
 20:       1439   IO-APIC-level  ohci_hcd, NVidia nForce3 Modem   
 21:          0   IO-APIC-level  ohci_hcd, NVidia nForce3   
 22:      12884   IO-APIC-level  ehci_hcd   

And when it does NOT hang it looks like -
16:          3   IO-APIC-level  ohci1394   
 18:      49277   IO-APIC-level  nvidia   
 19:       1753   IO-APIC-level  eth0   
 20:       6253   IO-APIC-level  ohci_hcd   
 21:        646   IO-APIC-level  ohci_hcd, NVidia nForce3   
 22:       2225   IO-APIC-level  ehci_hcd, NVidia nForce3 Modem   

Seems to me like the OHCI controller doesn't like to be assigned IRQ 19. Is 
this difference in IRQ assignment normal or is it a bug somewhere? 

Parag
