Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266819AbSKOSae>; Fri, 15 Nov 2002 13:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266822AbSKOSae>; Fri, 15 Nov 2002 13:30:34 -0500
Received: from holomorphy.com ([66.224.33.161]:38864 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266819AbSKOSad>;
	Fri, 15 Nov 2002 13:30:33 -0500
Date: Fri, 15 Nov 2002 10:33:49 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swsuspend and CONFIG_DISCONTIGMEM=y
Message-ID: <20021115183349.GX23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
References: <20021115081044.GI18180@conectiva.com.br> <20021115084915.GS23425@holomorphy.com> <20021115094827.GT23425@holomorphy.com> <20021115120233.GC25902@atrey.karlin.mff.cuni.cz> <20021115120920.GV23425@holomorphy.com> <20021115180924.GA8763@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021115180924.GA8763@elf.ucw.cz>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> I'm not entirely sure either. Mostly I suspect that the deep arch
>> issues will be the tough ones, but things like this I can handle. =)

On Fri, Nov 15, 2002 at 07:09:25PM +0100, Pavel Machek wrote:
> Well, I'd really hate to do 64GB support for swsusp for i386. It would
> mean wider pointers in on-disk format and probably would not be
> exactly nice.
> 								Pavel

i386 is actually a poor cpu for numerical workloads due to the
design of its FPU, so the interest will likely be low there, but...

It looks like the struct pbe is storing a physical address in an
unsigned long; using page frame numbers instead of raw physical
addresses should at least catch 36-bit i386 and a substantial fraction
of PPC highmem (40-bit, so not all) with very little effort. A good
chunk of the VM's arch support address calculation API (if not all)
has been converted to pfn-based calculations already, so we're already
in very good shape, aside from a one-shot format change.


Bill
