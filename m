Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316662AbSFJFWn>; Mon, 10 Jun 2002 01:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316664AbSFJFWm>; Mon, 10 Jun 2002 01:22:42 -0400
Received: from daimi.au.dk ([130.225.16.1]:20597 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S316662AbSFJFWl>;
	Mon, 10 Jun 2002 01:22:41 -0400
Message-ID: <3D04379B.1DE4CF8C@daimi.au.dk>
Date: Mon, 10 Jun 2002 07:22:35 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dawson Engler <engler@csl.Stanford.EDU>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] 54 missing null pointer checks in 2.4.17
In-Reply-To: <200206100355.UAA17040@csl.Stanford.EDU>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dawson Engler wrote:
> 
> Enclosed are 54 potential errors where code gets a pointer from a
> possibly-failing routine (kmalloc, etc) and dereferences it without
> checking.  Many follow the simple pattern of alloc-memset:
> 
>         dev->priv = kmalloc(sizeof(struct awc_private),GFP_KERNEL );
>         memset(dev->priv,0,sizeof(struct awc_private));
> 
> If these kind of errors are useful, let me know --- there are *many*
> others that I didn't inspect.

They surely look useful. Catching errors this way is better than having
to experience every one on a production system before they are found.
There are some false positives, but compared to the actual number of
bugs found, that is not a problem.

> [BUG] (synonums aren't working)
> /u2/engler/mc/oses/linux/2.4.17/drivers/net/eexpress.c:1088:eexp_hw_probe:
> ERROR:NULL:1083:1088:Using ptr "lp" illegally! set by 'kmalloc':1083
> [COUNTER=kmalloc:1083] [fit=1] [fit_fn=5] [fn_ex=0] [fn_counter=1]
> [ex=1399] [counter=26] [z = 5.50002098543802] [fn-z = -4.35889894354067]
>                 }
> 
>                 buswidth = !((setupval & 0x400) >> 10);
>         }
> 
> Start --->
>         dev->priv = lp = kmalloc(sizeof(struct net_local), GFP_KERNEL);
>         if (!dev->priv)
>                 return -ENOMEM;
> 
>         memset(dev->priv, 0, sizeof(struct net_local));
> Error --->
>         spin_lock_init(&lp->lock);

This one isn't a bug. The pointer to allocated memory is stored in two
variables. Only one of them is verified against NULL, that is enough.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
