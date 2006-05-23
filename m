Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbWEWTyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWEWTyt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 15:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWEWTyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 15:54:49 -0400
Received: from rune.pobox.com ([208.210.124.79]:29575 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S1751209AbWEWTyt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 15:54:49 -0400
Date: Tue, 23 May 2006 14:54:45 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: cpu hotplug sleeping from invalid context
Message-ID: <20060523195445.GB11414@localdomain>
References: <20060522183534.GA8920@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060522183534.GA8920@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> (2.6.17rc4-git9)
> 
> echo 0 > /sys/devices/system/cpu/cpu1/online
> echo 1 > /sys/devices/system/cpu/cpu1/online
> 
> on my dual-core notebook gets me this:
> 
> CPU 1 is now offline
> SMP alternatives: switching to UP code
> SMP alternatives: switching to SMP code
> Booting processor 1/1 eip 3000
> CPU 1 irqstacks, hard=c0799000 soft=c0779000
> Initializing CPU#1
> BUG: sleeping function called from invalid context at mm/page_alloc.c:945
> in_atomic():0, irqs_disabled():1
>  <c04500ce> __alloc_pages+0x32/0x2a8
>  <c0425577> printk+0x1f/0xaf
>  <c060674d> schedule+0xa21/0xa8a
>  <c04503a6> get_zeroed_page+0x31/0x3d
>  <c040a117> cpu_init+0x10a/0x323
>  <c04176f5> start_secondary+0xc/0x3ef
>  <c0417afa> cpu_exit_clear+0x22/0x43

I think it's caused by arch/i386/kernel/cpu/common.c::cpu_init() doing
get_zeroed_page(GFP_KERNEL).

