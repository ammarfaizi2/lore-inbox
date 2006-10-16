Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWJPOEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWJPOEh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 10:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWJPOEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 10:04:37 -0400
Received: from mail.suse.de ([195.135.220.2]:37264 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750795AbWJPOEh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 10:04:37 -0400
To: "bibo,mao" <bibo.mao@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IA32 move PG0 page table within kernel data segment
References: <4529E2BE.1060506@intel.com>
From: Andi Kleen <ak@suse.de>
Date: 16 Oct 2006 16:04:25 +0200
In-Reply-To: <4529E2BE.1060506@intel.com>
Message-ID: <p73k630cq6u.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"bibo,mao" <bibo.mao@intel.com> writes:

> Hi,
>   On i386 kernel image can compile and run at any physical address,kernel
> will dynamically establish initial page table at PG0. Currently PG0 address
> is adjacent to _end, that is to say PG0 page table is out of kernel data segment.
>  Some bootloader put initrd image next kernel data segment so that initial
> page table will overwrite initrd imagte. This patch modify this and put PG0
> table at BSS segment and free this space later.
>   This patch limited kernel image size within 64M, it is possible to modify
> ld script to remove this limit, but I am not familiar with ld script.
> 
>  Any comments is welcome.

Looks like a fragile hack. x86-64 has a imho cleaner generic solution
in e820_find_area(). I would suggest to port that over.

-Andi
