Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753859AbWKGAwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753859AbWKGAwG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 19:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753823AbWKGAwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 19:52:05 -0500
Received: from ambassador.mathewson.co.uk ([82.70.12.54]:11697 "EHLO
	envoy.mathewson.co.uk") by vger.kernel.org with ESMTP
	id S1753864AbWKGAwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 19:52:03 -0500
Message-ID: <454FD8B2.5070702@mathewson.co.uk>
Date: Tue, 07 Nov 2006 00:52:02 +0000
From: Joseph Mathewson <joe@mathewson.co.uk>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Strange PCI behaviour on Via K8M800CE chipset Shuttle & sata fails
 with noapic
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I have a Shuttle SK21G with a Via K8M800CE chipset which has very 
strange PCI behaviour on the 2.6.18.1 kernel (stock and Fedora 6).  I 
have tried both x86_64 and i386 architectures.

There is one PCI slot in which I ultimately want to use a D-Link 580TX 
4-port ethernet card (Intel bridge + 4 x sundance driver controllers).  
However, even with a simple one-port ethernet card (natsemi driver) 
similar behaviour is seen, so I am loathe to blame the card.  
Interestingly, the onboard (presumably also PCI) via-rhine card works fine.

The problem is that seemingly randomly, the card in the PCI slot will 
either:

1) Work fine (doesn't happen very often unfortunately, when it does will 
happen for a few boots in a row).  Appears in lspci and /proc/interrupts 
and sends packets.
2) Appear in lspci but not appear in /proc/interrupts.  Loading the 
driver will result in no card found.  No interface.

Weirdly, sometimes unloading the NIC module and reloading it causes the 
card to be seen.  Sometimes not.  The behaviour with the 4-port card is 
more subtle because of the PCI-PCI bridge aspect, I suspect.  With this 
behaviour is one of:

1) Works fine.
2) Bridge appears in lspci.  None of the bridged network cards appear. 
(This is most common of the 3).
3) Bridge appears in lspci.  Too many network cards appear!  One doesn't 
really exist and can't be ifconfig'ed.

My highly technical diagnosis is that Linux is very unhappy about PCI on 
this box.  As a result I have tried:

pci=routeirq
acpi=off
nolapic
noapic

options.  The first three don't work.  Unfortunately I don't know 
whether the last one would work, because when enabled (or even APIC 
disabled in BIOS), the sata_via driver hangs.  The boot disk is sata so 
I can't get any further...  I don't know if this is a separate or 
related problem.

Have the latest BIOS etc etc.  Apologies for the length, it's just very 
weird and difficult to explain because of the randomness.

Joe.
