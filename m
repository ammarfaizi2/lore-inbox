Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261908AbTCYLWW>; Tue, 25 Mar 2003 06:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261937AbTCYLWV>; Tue, 25 Mar 2003 06:22:21 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:2822 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S261908AbTCYLWV>; Tue, 25 Mar 2003 06:22:21 -0500
Date: Tue, 25 Mar 2003 14:33:10 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cacheline size detection code in 2.5.66
Message-ID: <20030325143310.A3487@jurassic.park.msu.ru>
References: <20030325071532.GA19217@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030325071532.GA19217@averell>; from ak@muc.de on Tue, Mar 25, 2003 at 08:15:32AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 08:15:32AM +0100, Andi Kleen wrote:
> This will be wrong on Pentium M for example which has a 32byte cache
> line but x86 model 9. But it's actually not needed, because all the 
> new CPUs report their cacheline size as part of CPUID for CLFLUSH.

We check x86 family, not model. According to Intel docs Pentium M
has family code 6.

> The x86-64 port extract it like this in setup.c:
> 	if (c->x86_capability[0] & (1<<19)) 
>        		c->x86_clflush_size = ((misc >> 8) & 0xff) * 8;
> 	}. 
> I changed its pci code to use that directly now. i386 likely
> should too. When no CLFLUSH is supported you can safely assume 32byte
> cachelines.

Apparently it's fine for K8, but what about Athlons? They have
bit 19 == 0 and 64-byte cache lines.
BTW, the "AMD Processor Recognition Application Note" calls bit 19
"Multiprocessing Capable". ;-)

Ivan.
