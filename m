Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289088AbSAVAVR>; Mon, 21 Jan 2002 19:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289094AbSAVAVH>; Mon, 21 Jan 2002 19:21:07 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:6599 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S289088AbSAVAUw>; Mon, 21 Jan 2002 19:20:52 -0500
Date: Mon, 21 Jan 2002 19:20:52 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: pci_alloc_consistent from interrupt == BAD
Message-ID: <20020121192052.A8752@devserv.devel.redhat.com>
In-Reply-To: <3C4875DB.9080402@embeddededge.com> <mailman.1011386221.24072.linux-kernel2news@redhat.com> <200201212352.g0LNq5802844@devserv.devel.redhat.com> <20020121.160853.10161323.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020121.160853.10161323.davem@redhat.com>; from davem@redhat.com on Mon, Jan 21, 2002 at 04:08:53PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Mon, 21 Jan 2002 16:08:53 -0800 (PST)
> From: "David S. Miller" <davem@redhat.com>
> 
>    From: Pete Zaitcev <zaitcev@redhat.com>
>    Date: Mon, 21 Jan 2002 18:52:05 -0500
> 
>    > It [GFP_HIGH] is a trivial fix whereas backing
>    > out this ability to call pci_alloc_consistent from interrupts is not
>    > a trivial change at all.
>    
>    David, would you make a statement about pci_free_consistent.
>    I find it annoying that it cannot be called from an interrupt.
>    
> It is not an unreasonable requirement.  Wasn't there some problem with
> the pci pool stuff if it free'd up a chunk in an interrupt?

Yes, the pci_pool_free is one of the reasons why I ask.
I understand that the fundamental difference is that
allocation can fail (given right GFP flag), so this is what
we do in an interrupt (and we drop a packet in the driver).
But frees cannot fail, so if that tries to slip then we are stuck.

-- Pete
