Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030235AbWGYXF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbWGYXF2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 19:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbWGYXF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 19:05:28 -0400
Received: from sccrmhc14.comcast.net ([204.127.200.84]:38339 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1030235AbWGYXF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 19:05:27 -0400
Subject: Re: [discuss] Re: VIA x86-64 bootlogs needed
From: Nicholas Miell <nmiell@comcast.net>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
In-Reply-To: <200607260018.04851.ak@suse.de>
References: <200607251824.30504.ak@suse.de>
	 <1153848759.2661.5.camel@entropy>  <200607260018.04851.ak@suse.de>
Content-Type: text/plain
Date: Tue, 25 Jul 2006 16:05:14 -0700
Message-Id: <1153868714.2661.18.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-26 at 00:18 +0200, Andi Kleen wrote:
>  > MSI Master2-FAR with VIA K8T800, kernel-2.6.17-1.2157_FC5
> 
> Thanks.
> 
> > With any luck, this APIC rework will fix this board's habit of
> > spontaneously turning off interrupts at the IOAPIC level without the
> > kernel's knowledge.
> 
> Unlikely unfortunately. How does it look like when they get turned off?
> 

I stop getting any interrupts from the device in question (either the
on-board UHCI controllers or the on-board SATA controller) -- i.e. mouse
movement gets jerky because uhci-hcd is operating purely by polling or I
start getting libata timeouts in my logs.

I have an abomination of a systemtap script which calls
unmask_IO_APIC_irq directly which instantly "fixes" it when things go
wrong.

I also have another stap script which records stack traces when
mask_IO_APIC_irq and unmask_IO_APIC_irq called in order to check if the
IRQs are actually getting turned off without the kernel's knowledge, but
when I run that in the background, the problem doesn't ever manifest
itself. 

-- 
Nicholas Miell <nmiell@comcast.net>

