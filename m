Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277514AbRKABm7>; Wed, 31 Oct 2001 20:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277568AbRKABmv>; Wed, 31 Oct 2001 20:42:51 -0500
Received: from ns.suse.de ([213.95.15.193]:52240 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S277514AbRKABmn>;
	Wed, 31 Oct 2001 20:42:43 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cache colour task_structs
In-Reply-To: <3BE050AD.C6D7CE4B@colorfullife.com.suse.lists.linux.kernel> <E15z6HM-0005gW-00@the-village.bc.nu.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 01 Nov 2001 02:43:20 +0100
In-Reply-To: Alan Cox's message of "1 Nov 2001 02:02:38 +0100"
Message-ID: <p73668vqn9j.fsf@amdsim2.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> We need to perturb esp colour too. It might be the right way to do this
> is slab based kernel stacks, it might be that your code is cheaper than
> the cost of getting current the really hard way and we should just add
> random numbers to the initial esp of a task ?

You could do that even today (without slab task_struct) by using a 
random/coloured at fork time value for esp0.  This could just be a static
colour counter that is subtracted.

Just don't forget to teach ptrace and proc WCHAN and oops printing about it; 
they currently use hardcoded stack offsets. It'll also likely break kdb.

-Andi
