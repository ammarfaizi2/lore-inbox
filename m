Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278672AbRKAKtr>; Thu, 1 Nov 2001 05:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278664AbRKAKth>; Thu, 1 Nov 2001 05:49:37 -0500
Received: from colorfullife.com ([216.156.138.34]:43012 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S278672AbRKAKtR>;
	Thu, 1 Nov 2001 05:49:17 -0500
Message-ID: <3BE128B3.F93D8A6A@colorfullife.com>
Date: Thu, 01 Nov 2001 11:49:23 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.14-pre3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cache colour task_structs
In-Reply-To: <E15z6HM-0005gW-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > The attached patch moves the task structure into a slab, with normal
> > cache colouring.
> > It's tested with i386 SMP.(i.e. it boots and runs X)
> 
> Keeping the stack and task struct together is smarter. You fix the one
> problem but not the other horror.
>
If we keep both together we are limited to 8 kB for stack, task
structure and slack for colouring - I'm not sure if that won't cause
stack overruns. We are already down to 6.3 kB stack.

> We need to perturb esp colour too. It might be the right way to do this
> is slab based kernel stacks, it might be that your code is cheaper than
> the cost of getting current the really hard way and we should just add
> random numbers to the initial esp of a task ?
>
Adding a random amount would be a one line change to copy_thread.

--
	Manfred
