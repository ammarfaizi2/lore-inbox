Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751440AbWAEXqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbWAEXqh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWAEXqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:46:37 -0500
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:65254 "EHLO
	clueserver.org") by vger.kernel.org with ESMTP id S1751440AbWAEXqg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:46:36 -0500
Date: Thu, 5 Jan 2006 15:46:35 -0800 (PST)
From: alan <alan@clueserver.org>
X-X-Sender: alan@www.fnordora.org
To: linux-kernel@vger.kernel.org
Subject: Problem with pci_fixups in drivers/pci/probe.c
Message-ID: <Pine.LNX.4.44.0601051533430.27220-100000@www.fnordora.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an HP zv5200z laptop running a x86_64 kernel.

In order to get cardbus devices to work, I had to patch the kernel to get 
the cardbus to actually see those devices.  (We will call this patch 
"cardbus.patch".)

I went to patch the current FC5T1 kernel and found that the patch no 
longer applied.  On further investigation I found that the patch had been 
added to the kernel, but some helpful soul had added a subroutine that 
made it absolutely worthless to anyone on x86 architecture.

in drivers/pci/probe.c at line 408 there is the following code:

        /* Attempts to fix that up are really dangerous unless
           we're going to re-assign all bus numbers. */
        if (!pcibios_assign_all_busses())
                return;

The problem with this is that for x86 and x86_64 this function is defined 
as 0.

include/asm-x86_64/pci.h:18:#define pcibios_assign_all_busses() 0
include/asm-i386/pci.h:14:extern unsigned int pcibios_assign_all_busses(void);
include/asm-i386/pci.h:16:#define pcibios_assign_all_busses()   0
include/asm-ia64/pci.h:18:#define pcibios_assign_all_busses()     0

This "fix" makes the patch absolutely useless to me.

Is there a way to get this to only run the fixup where needed or to make 
this patch less problematic or just remove the test entirely?

My cardbus devices will thank you.

-- 
"George W. Bush -- Bringing back the Sixties one Nixon at a time."

