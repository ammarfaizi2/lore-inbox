Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262284AbTCYMEl>; Tue, 25 Mar 2003 07:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262291AbTCYMEl>; Tue, 25 Mar 2003 07:04:41 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:9396 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262284AbTCYMEk>; Tue, 25 Mar 2003 07:04:40 -0500
Date: Tue, 25 Mar 2003 13:15:27 +0100
From: Andi Kleen <ak@muc.de>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: cacheline size detection code in 2.5.66
Message-ID: <20030325121527.GA29965@averell>
References: <20030325071532.GA19217@averell> <20030325143310.A3487@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030325143310.A3487@jurassic.park.msu.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 12:33:10PM +0100, Ivan Kokshaysky wrote:
> > The x86-64 port extract it like this in setup.c:
> > 	if (c->x86_capability[0] & (1<<19)) 
> >        		c->x86_clflush_size = ((misc >> 8) & 0xff) * 8;
> > 	}. 
> > I changed its pci code to use that directly now. i386 likely
> > should too. When no CLFLUSH is supported you can safely assume 32byte
> > cachelines.
> 
> Apparently it's fine for K8, but what about Athlons? They have
> bit 19 == 0 and 64-byte cache lines.

Ok.

Athlon likely reports its cacheline size too in 8000_0005 / ECX (I think,
not checked), but it doesn't have the CLFLUSH bit, you're right. 


> BTW, the "AMD Processor Recognition Application Note" calls bit 19
> "Multiprocessing Capable". ;-)

Hmm, yes it's broken. 19 is CFLUSH in the 8000_0001 extended CPUID word,
but not in index 0000_0001. Copied wrong from cpufeature.h.

Probably it should reinitialize x86_capability[0] from 80000001 when
available, but need to double check the list.

Broken in i386 too.

-Andi
