Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261634AbRESCfN>; Fri, 18 May 2001 22:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261637AbRESCfD>; Fri, 18 May 2001 22:35:03 -0400
Received: from femail15.sdc1.sfba.home.com ([24.0.95.142]:29352 "EHLO
	femail15.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S261634AbRESCeu>; Fri, 18 May 2001 22:34:50 -0400
Date: Fri, 18 May 2001 22:34:36 -0400
From: Tom Vier <tmv5@home.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
Message-ID: <20010518223436.A563@zero>
In-Reply-To: <20010518214617.A701@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010518214617.A701@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Fri, May 18, 2001 at 09:46:17PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

maybe this third window stuff in cia_enable_broken_tbia() is why i can't
seem to get the third window to open up. from my reading of the 21174 docs,
my code should work. since T2_BASE is at 0x40000000 for 1gig, i'd think
T3_BASE should be at 0x80000000. am i missing something?

	hose->sg_pci = iommu_arena_new(hose, 0xc0000000, 0x08000000, 32768);
	*(vip)CIA_IOC_PCI_W3_BASE = 0xc0000000 | 1;
	*(vip)CIA_IOC_PCI_W3_MASK = (0x08000000 - 1) & 0xfff00000;
	*(vip)CIA_IOC_PCI_T3_BASE = 0x80000000 >> 2;


On Fri, May 18, 2001 at 09:46:17PM +0400, Ivan Kokshaysky wrote:
> -	*(vip)CIA_IOC_PCI_W3_BASE = CIA_BROKEN_TBI_TRY2_BASE | 3;
> -	*(vip)CIA_IOC_PCI_W3_MASK = (PAGE_SIZE - 1) & 0xfff00000;
> +	*(vip)CIA_IOC_PCI_W3_BASE = CIA_BROKEN_TBIA_BASE | 3;
> +	*(vip)CIA_IOC_PCI_W3_MASK = (CIA_BROKEN_TBIA_SIZE*1024 - 1)
> +				    & 0xfff00000;
>  	*(vip)CIA_IOC_PCI_T3_BASE = virt_to_phys(ppte) >> 2;
>  }


-- 
Tom Vier <tmv5@home.com>
DSA Key id 0x27371A2C
