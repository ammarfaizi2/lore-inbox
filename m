Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316675AbSFJF5G>; Mon, 10 Jun 2002 01:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316677AbSFJF5F>; Mon, 10 Jun 2002 01:57:05 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:30612 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S316675AbSFJF5E>;
	Mon, 10 Jun 2002 01:57:04 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200206100556.WAA17248@csl.Stanford.EDU>
Subject: Re: [CHECKER] 54 missing null pointer checks in 2.4.17
To: kasperd@daimi.au.dk (Kasper Dupont)
Date: Sun, 9 Jun 2002 22:56:56 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org (Linux-Kernel)
In-Reply-To: <3D04379B.1DE4CF8C@daimi.au.dk> from "Kasper Dupont" at Jun 10, 2002 07:22:35 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > [BUG] (synonums aren't working)
> > /u2/engler/mc/oses/linux/2.4.17/drivers/net/eexpress.c:1088:eexp_hw_probe:
> > ERROR:NULL:1083:1088:Using ptr "lp" illegally! set by 'kmalloc':1083
> > [COUNTER=kmalloc:1083] [fit=1] [fit_fn=5] [fn_ex=0] [fn_counter=1]
> > [ex=1399] [counter=26] [z = 5.50002098543802] [fn-z = -4.35889894354067]
> >                 }
> > 
> >                 buswidth = !((setupval & 0x400) >> 10);
> >         }
> > 
> > Start --->
> >         dev->priv = lp = kmalloc(sizeof(struct net_local), GFP_KERNEL);
> >         if (!dev->priv)
> >                 return -ENOMEM;
> > 
> >         memset(dev->priv, 0, sizeof(struct net_local));
> > Error --->
> >         spin_lock_init(&lp->lock);
> 
> This one isn't a bug. The pointer to allocated memory is stored in two
> variables. Only one of them is verified against NULL, that is enough.


Yuck.  Sorry about that --- I mislabeled the message.  It's a BUG,
but in our system rather than in 2.4.17.  Bug finding still tends
to be unfortunately symetrical...
