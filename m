Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262855AbVCMHog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262855AbVCMHog (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 02:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263382AbVCMHod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 02:44:33 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:39652 "EHLO
	pd3mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S262855AbVCMHnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 02:43:32 -0500
Date: Sun, 13 Mar 2005 01:43:09 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Linux 2.6 : physical memory address and pid
In-reply-to: <3HsTW-7Mx-11@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4233EF0D.6060507@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <3HpMi-5nQ-3@gated-at.bofh.it> <3Hq5K-5CP-13@gated-at.bofh.it>
 <3HsTW-7Mx-11@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allison wrote:
> Thanks for the answer! 
> 
> Another related question :
> 
> I need to gather all application pages by reading the page tables. 
> The hard part is, I need to do this from a PCI device using DMA.  As I
> understand it,  when a DMA is being performed, the pages are pinned in
> memory . Since the PCI device has grabbed the bus, the processor is
> not able to access memory to perform page replacement right ?
> So, this is a form of mutual exclusion.

I don't think it works this way - if the system is modifying the pages 
which you're trying to do DMA reads on, you'll just read whatever data 
happens to be in memory at the time. The CPU is not "locked out" just 
because that memory is being read by a DMA transfer.

> 
> However, if I have to fetch the page struct, the process address space
> of the process owning the page (I am ignoring shared pages to make
> things simpler) and the page itself, will a scatter gather DMA make
> sure that  the processor cannot modify any of these data structures
> till the DMA is complete ? I am using Linux 2.6 and the i386
> architecture.

As above, I don't think anything ensures this. Doing DMA reads on pages 
that could potentially be being modified during the transfer isn't 
something that is typically done..
