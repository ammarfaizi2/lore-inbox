Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267699AbTBRGVO>; Tue, 18 Feb 2003 01:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267701AbTBRGVO>; Tue, 18 Feb 2003 01:21:14 -0500
Received: from ns.suse.de ([213.95.15.193]:3852 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267699AbTBRGVN>;
	Tue, 18 Feb 2003 01:21:13 -0500
Date: Tue, 18 Feb 2003 07:31:11 +0100
From: Andi Kleen <ak@suse.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.5.61: x86_64 num_online_cpus() buglet?
Message-ID: <20030218063111.GA14073@wotan.suse.de>
References: <200302171751.SAA19069@kim.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302171751.SAA19069@kim.it.uu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2003 at 06:51:12PM +0100, Mikael Pettersson wrote:
> Andi,
> 
> Kernel 2.5.61's include/asm-x86_64/smp.h contains:
> 
> extern unsigned long cpu_online_map;
> ...
> extern inline unsigned int num_online_cpus(void)
> { 
> 	return hweight32(cpu_online_map);
> } 
> 
> and similarly for cpu_callout_map.
> 
> hweight32() truncates a 64-bit operand to 32-bits, so either
> - the maps should be int rather than long, or
> - x86_64 needs to define and use a new hweight64(), or
> - CONFIG_NR_CPUS must not exceed 32 on x86_64.
> 
> Comments?

You're right - it should use hweight64. Thanks for the headup.
I'll fix it.

Currently the x86-64 port is limited to 8 CPUs because the APIC
drivers don't support cluster mode (yet) and can only talk to 8 
local apics, so it isn't that harmful.

-Andi
