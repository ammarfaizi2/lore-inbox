Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277176AbRKAA5Y>; Wed, 31 Oct 2001 19:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277148AbRKAA5O>; Wed, 31 Oct 2001 19:57:14 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20742 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277135AbRKAA5B>; Wed, 31 Oct 2001 19:57:01 -0500
Subject: Re: [PATCH] cache colour task_structs
To: manfred@colorfullife.com (Manfred Spraul)
Date: Thu, 1 Nov 2001 01:04:20 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BE050AD.C6D7CE4B@colorfullife.com> from "Manfred Spraul" at Oct 31, 2001 08:27:41 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15z6HM-0005gW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The attached patch moves the task structure into a slab, with normal
> cache colouring.
> It's tested with i386 SMP.(i.e. it boots and runs X)

Keeping the stack and task struct together is smarter. You fix the one
problem but not the other horror.

When you are bored one day run apache with 120 servers on a typical real
world load. Keep snapshotting the kernel %esp and look at the cache
colouring.  

We need to perturb esp colour too. It might be the right way to do this
is slab based kernel stacks, it might be that your code is cheaper than
the cost of getting current the really hard way and we should just add
random numbers to the initial esp of a task ?

