Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136815AbREIScF>; Wed, 9 May 2001 14:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136819AbREISb4>; Wed, 9 May 2001 14:31:56 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:59287 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S136815AbREISbk>; Wed, 9 May 2001 14:31:40 -0400
Date: Wed, 9 May 2001 14:30:20 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: David Brownell <david-b@pacbell.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Pete Zaitcev <zaitcev@redhat.com>, johannes@erdfelt.com,
        rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: pci_pool_free from IRQ
Message-ID: <20010509143020.A22522@devserv.devel.redhat.com>
In-Reply-To: <200105082108.f48L8X1154536@saturn.cs.uml.edu> <E14xFD5-0000hh-00@the-village.bc.nu> <15096.27479.707679.544048@pizda.ninka.net> <050701c0d80f$8f876ca0$6800000a@brownell.org> <15096.38109.228916.621891@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15096.38109.228916.621891@pizda.ninka.net>; from davem@redhat.com on Tue, May 08, 2001 at 05:52:45PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: "David S. Miller" <davem@redhat.com>
> Date: Tue, 8 May 2001 17:52:45 -0700 (PDT)

> Ummm... What Alan's saying is:
> 
> 1) Whatever driver is trying to shut down from IRQ context
>    is broken must be fixed.  pci_pool is fine.
> 
> 2) The Documentation/ files which suggest that such device
>    removal from IRQs is "OK" must be fixed because it is not
>    "OK" to handle device removal from IRQ context.
> 
> So Pete's change is not needed.  A fix for the documentation and
> broken drivers is needed instead.

David, I do not follow your logic here, sorry.

I wrote that a path exists from a function that is legal in
interrupt context (pci_pool_free) into a function that is
not legal in interrupt context (pci_free_consistent).
The change breaks that connection. Note that pci_pool_free
is called when driver operates normally.

When you write "fix documentation and broken drivers", you talk
about a fix for a part that processes PCI remove. This is entirely
fine by me. But I was talking about a regular interrupt procession
in driver. A fix in pci remove does not fix regular processing.

-- Pete
