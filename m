Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267406AbUHDUQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267406AbUHDUQo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 16:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267407AbUHDUQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 16:16:44 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:26504 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267406AbUHDUQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 16:16:41 -0400
Date: Wed, 04 Aug 2004 13:13:56 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Roland Dreier <roland@topspin.com>
cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>, eric@cisu.net,
       kernel@kolivas.org, barryn@pobox.com, swsnyder@insightbb.com,
       linux-kernel@vger.kernel.org
Subject: Re: HIGHMEM4G config for 1GB RAM on desktop?
Message-ID: <214180000.1091650436@flay>
In-Reply-To: <527jseis2g.fsf@topspin.com>
References: <200408021602.34320.swsnyder@insightbb.com><410FA145.70701@kolivas.org> <20040804060625.GE10340@suse.de><200408040614.30820.eric@cisu.net> <20040804130707.GN10340@suse.de><20040804120633.4dca57b3.akpm@osdl.org> <210450000.1091647829@flay> <527jseis2g.fsf@topspin.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     Martin> I had a patch for a config option, ported forward by
>     Martin> someone at IBM (I forget who, possibly Dave) from Andrea's
>     Martin> original. I think we finally decided (in consultation with
>     Martin> Andrea) we could drop the complicated stuff he had in the
>     Martin> asm code, so it's pretty simple ... something like this:
> 
> Am I just being dense, or is this patch solving a different problem
> from "do I really have to turn on HIGHMEM4G just to get the last 128MB
> of my 1GB of RAM?"
> 
> It seems to me that none of the PAGE_OFFSET values offered (the patch
> in allows PAGE_OFFSET to be set to 0xe0000000, 0xc0000000, 0x80000000
> or 0x40000000, in addition to the 4G/4G value of 0x02000000) are
> exactly what someone with 1 GB of RAM wants.  They'd be forced to go
> down to a 2G/2G split which cheats userspace of quite a bit of address
> space (admittedly with only 1 GB of RAM, a process bigger than 2 GB is
> a bit of a stretch).  In any case a 2.75G/1.25G split as suggested
> earlier works fine with 1 GB of RAM.

In practice, I suspect 2/2 will do exactly what you want ... and what 
99.9% of people want actually ;-) We could add more options, but be sure
to mark anything that's not 1GB aligned as not suitable for PAE (as the
0.5 split was).
 
> Also I notice that Con's patch modifies vmlinux.ld.S to update the
> kernel base address, while this patch doesn't.  Is that intentional or
> is does the patch depend on some other patches that use the defines in
> page.h somehow as controlled by the following change?
> 
> +AFLAGS_vmlinux.lds.o += -include $(TOPDIR)/include/asm-i386/page.h

Dunno ... we should test it really ... it's been a while. IIRC, vmlinux.ld.S
was hardcoded, so I don't see how it'd work without those mods.

M.
