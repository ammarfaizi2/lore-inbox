Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262804AbVCMERR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262804AbVCMERR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 23:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262791AbVCMEM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 23:12:29 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:46754 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262665AbVCMD4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 22:56:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Xln16/YfqpvOX+gRjSmJxKtIcPAU92VJ9WdY/VtlBXzAGBzQoM72Kp+/qf9Y8TwFmgLHJWP8+TW6C4yQp8zqRZoAz2+Hi+EBcezMb8u/VrAdn9GbegFU5Jreq1KH47UB0Tsg95stkp/a5RngNUCfy2GZP01FX6maMDaBu1tp4S8=
Message-ID: <17d798805031219562e44f911@mail.gmail.com>
Date: Sat, 12 Mar 2005 22:56:09 -0500
From: Allison <fireflyblue@gmail.com>
Reply-To: Allison <fireflyblue@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6 : physical memory address and pid
In-Reply-To: <20050313012323.GE3163@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <17d798805031217055a3e9cc6@mail.gmail.com>
	 <20050313012323.GE3163@waste.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the answer! 

Another related question :

I need to gather all application pages by reading the page tables. 
The hard part is, I need to do this from a PCI device using DMA.  As I
understand it,  when a DMA is being performed, the pages are pinned in
memory . Since the PCI device has grabbed the bus, the processor is
not able to access memory to perform page replacement right ?
So, this is a form of mutual exclusion.

However, if I have to fetch the page struct, the process address space
of the process owning the page (I am ignoring shared pages to make
things simpler) and the page itself, will a scatter gather DMA make
sure that  the processor cannot modify any of these data structures
till the DMA is complete ? I am using Linux 2.6 and the i386
architecture.

thanks,
Allison





On Sat, 12 Mar 2005 17:23:23 -0800, Matt Mackall <mpm@selenic.com> wrote:
> On Sat, Mar 12, 2005 at 08:05:11PM -0500, firefly blue wrote:
> > Hi,
> >
> > With the 2.6 Linux kernel, I want to find, from the physical page
> > frame, the virtual address of the page loaded in the frame and the
> > process id of the process owning it.
> 
> Follow struct page->mapping to struct address_space. A page can be
> mapped into any number of processes and multiple times per process so
> you'll need to walk the data structures there.
> 
> --
> Mathematics is the supreme nostalgia of our time.
>
