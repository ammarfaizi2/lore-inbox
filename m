Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292573AbSBTXTP>; Wed, 20 Feb 2002 18:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292576AbSBTXTG>; Wed, 20 Feb 2002 18:19:06 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:63207 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S292573AbSBTXSt>; Wed, 20 Feb 2002 18:18:49 -0500
Date: Wed, 20 Feb 2002 16:35:52 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        jmerkey@timpanogas.org
Subject: Re: ioremap()/PCI sickness in 2.4.18-rc2 (FIXED ALMOST)
Message-ID: <20020220163552.B1730@vger.timpanogas.org>
In-Reply-To: <20020220152011.A1252@vger.timpanogas.org> <E16dfoX-00050r-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16dfoX-00050r-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Feb 20, 2002 at 11:06:17PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2002 at 11:06:17PM +0000, Alan Cox wrote:
> > Sigh .... I am only using 2 GB on a 4GB capable processor (actually 
> > a 64 GB capable processor).  Looks like a patch is needed.  Who is 
> > maintaining vmalloc.c at present so I know who to submit a patch 
> > to?
> 
> Actually you are using a 64Gb capable processor that is only capable of 
> sanely addressing 4Gb at a time, total across both user and kernel space
> and takes a hefty hit whenever you switch which 4Gb you are peering at.
> 
> If you want to make sensible use of even 4Gb user/4Gb kernel you need to
> take a page table reload at syscall time and deal with quite messy handling
> for copy to/from user. 
> 
> [If someone from Intel disagrees please do so publically - I'd love to have
>  someone prove the limit can be dealt with 8)]


I'll get to work on it.  The 4 bit PTE extention to enable 48 bit
addresses is quite ugly, and I agree -- heavy.  There may. however, 
be no other way to make this work properly.  The SCI address space is 
explicitly addressable, so it may be possible to enable this on 
the PCI-SCI adapters **ONLY** (not ccNuma) without getting into
general user/kernel copy issues since the SCI address space is 
typically assumed in this model to be an explicit entity for most
apps.   :-)

Jeff

Jeff




> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
