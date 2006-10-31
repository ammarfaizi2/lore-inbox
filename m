Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423018AbWJaMdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423018AbWJaMdM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 07:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423037AbWJaMdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 07:33:12 -0500
Received: from smtp01.dc2.safesecureweb.com ([65.36.177.68]:33222 "EHLO
	smtp01.dc2.safesecureweb.com") by vger.kernel.org with ESMTP
	id S1423018AbWJaMdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 07:33:11 -0500
Message-ID: <02f201c6fce8$a660ece0$0732700a@djlaptop>
From: "Richard B. Johnson" <jmodem@AbominableFirebug.com>
To: "Jun Sun" <jsun@junsun.net>, <linux-kernel@vger.kernel.org>
References: <20061031072203.GA10744@srv.junsun.net>
Subject: Re: reserve memory in low physical address - possible?
Date: Tue, 31 Oct 2006 07:32:37 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Jun Sun" <jsun@junsun.net>
To: <linux-kernel@vger.kernel.org>
Sent: Tuesday, October 31, 2006 2:22 AM
Subject: reserve memory in low physical address - possible?


>
> This question is specific to i386 architecture.  While I am fairly
> comfortable with Linux kernel, I am not familiar with i386 arch.
>
> My objective is to reserve, or hide from kernel, some memory space in low
> physical address range starting from 0.  The memory amount is in the order
> of 100MB to 200MB.  The total memory is assumed to be around 512MB.
>
> Is this possible?
>
> I understand it is possible to reserve some memory at the end by
> specifying "mem=xxxM" option in kernel command line.  I looked into
> "memmap=xxxM" option but it appears not helpful for what I want.
>

For special purpose (DMA to user-space, etc.), it has become commonplace to 
reserve some high memory.
Then, in your driver, you can find the end of kernel memory as 
(num_physpages * PAGE_SIZE).

You will not be able to reserve any address space starting at 0 anyway, but 
your driver or even
user-space code can memory-map it.

> While searching on the web I also found things like DMA zone and loaders
> etc that all seem to assume the existence low-addressed physical
> memory.  True?
>

Some early (ISA) boards couldn't access address-space beyoond 16 megabytes, 
hense the "low" memory
for DMA.

> I can certainly workaround the loader issue.  I can also re-code the 
> real-mode
> part of kernel code to migrate to higher addresses.  The DMA zone might be
> a thorny one.  Any clues?  Are modern PCs still subject to
> the 16MB DMA zone restriction?
>

Anything that plugs into a PCI bus will __not__ have a low address 
restriction.

> Am I too far off from what I want to do?
>
> Thanks.
>
> Jun
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


