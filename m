Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261952AbTCYLlp>; Tue, 25 Mar 2003 06:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262132AbTCYLlp>; Tue, 25 Mar 2003 06:41:45 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:10163 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S261952AbTCYLlo>; Tue, 25 Mar 2003 06:41:44 -0500
Date: Tue, 25 Mar 2003 11:52:38 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: ink@jurassic.park.msu.ru, linux-kernel@vger.kernel.org
Subject: Re: cacheline size detection code in 2.5.66
Message-ID: <20030325115227.GA28451@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andi Kleen <ak@muc.de>, ink@jurassic.park.msu.ru,
	linux-kernel@vger.kernel.org
References: <20030325071532.GA19217@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030325071532.GA19217@averell>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 08:15:32AM +0100, Andi Kleen wrote:

 > +        pci_cache_line_size = 32 >> 2;
 > +       if (c->x86 >= 6 && c->x86_vendor == X86_VENDOR_AMD)
 > +               pci_cache_line_size = 64 >> 2;  /* K7 & K8 */
 > +       else if (c->x86 > 6)
 > +               pci_cache_line_size = 128 >> 2; /* P4 */
 > 
 > This will be wrong on Pentium M for example which has a 32byte cache
 > line but x86 model 9.

The above test is comparing family, not model.  It's my understanding
that it's still a family 6 CPU, so it'll match '32'.

 > But it's actually not needed, because all the 
 > new CPUs report their cacheline size as part of CPUID for CLFLUSH.
 > When the CPU supports CLFLUSH you can just extract it from 
 > the second byte in the second word reported by CPUID 1.
 > With that just use what the CPU tells you. This should also
 > work correctly on VIA etc which afaik support CLFLUSH 
 > in the newer CPUs.

Nope. Nehemiah :-
flags		: fpu de pse tsc msr cx8 mtrr pge cmov mmx fxsr sse

Cache line size is still available from cpuid 80000006 though,
but as this is vendor and model specific, this could get messy
to decode. And then there's errata...

		Dave

