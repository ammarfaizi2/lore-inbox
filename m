Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277162AbRJHWCf>; Mon, 8 Oct 2001 18:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277165AbRJHWCZ>; Mon, 8 Oct 2001 18:02:25 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:49938 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277162AbRJHWCN>; Mon, 8 Oct 2001 18:02:13 -0400
Subject: Re: A note on APIC bus latency
To: jlundell@pobox.com (Jonathan Lundell)
Date: Mon, 8 Oct 2001 23:08:13 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <p0510030bb7e7ca4c5533@[207.213.214.37]> from "Jonathan Lundell" at Oct 08, 2001 02:51:19 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qiZJ-00023i-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A message exchange (IO-APIC sends an interrupt message; CPU sends 
> back an EOI message) requires from 35 to 48 APIC bus clocks, or 2-3 
> microseconds. That gets to be pretty significant compared to packet 
> times, especially at Gbit speeds, but even at 100 MHz, and is the 
> time required to burst a thousand bytes or more at faster PCI rates.
> 
> It's also likely to be significant for inter-processor interrupts, 
> though I don't know what the implications are here.

The big implication so far has been some extremely horrible to debug 
irq handling bugs where drivers such as the i810 audio assumed that the
disable of an irq on the pci device was immediate once then pci write
and a pci read to force posting completed. 

There are impacts on things like TLB shootdowns where the latency impacts
an SMP crosscall. I'm not sure how bad the impact is on the bigger numa
boxes as I notice Martin uses multiple sends for that

Alan
