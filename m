Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292891AbSCISqf>; Sat, 9 Mar 2002 13:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292894AbSCISq0>; Sat, 9 Mar 2002 13:46:26 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:7088 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S292891AbSCISqK>;
	Sat, 9 Mar 2002 13:46:10 -0500
Date: Sat, 9 Mar 2002 19:45:15 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: Maksim Krasnyanskiy <maxk@qualcomm.com>
Cc: Robert Love <rml@tech9.net>, Frode Isaksen <fisaksen@bewan.com>,
        mitch@sfgoth.com, linux-kernel@vger.kernel.org,
        marcelo Tosatti <marcelo@conectiva.com.br>, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] ATM locking fix. [Re: [PATCH] spinlock not locked when unlocking in atm_dev_register]
Message-ID: <20020309194515.B6626@fafner.intra.cogenit.fr>
In-Reply-To: <5.1.0.14.2.20020307141124.084dbde8@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.1.0.14.2.20020307141124.084dbde8@mail1.qualcomm.com>; from maxk@qualcomm.com on Thu, Mar 07, 2002 at 02:11:37PM -0800
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Maksim Krasnyanskiy <maxk@qualcomm.com> :
> --- linux/net/atm/resources.c.orig	Thu Mar  7 13:56:00 2002
> +++ linux/net/atm/resources.c	Thu Mar  7 13:56:40 2002
[...]
>   		if (atm_proc_dev_register(dev) < 0) {
>   			printk(KERN_ERR "atm_dev_register: "
>   			    "atm_proc_dev_register failed for dev %s\n",type);
> -			spin_unlock (&atm_dev_lock);		
>   			free_atm_dev(dev);   <====== (A)
> -			return NULL;
> +			goto done;
>   		}
>   #endif
> -	spin_unlock (&atm_dev_lock);
> +
> +done:
> +	spin_unlock(&atm_dev_lock); 
>   	return dev;                          <====== (B)
>   }

- dev = NULL is to be inserted between (A) and (B) or the caller won't 
  notice the failure
- atm_proc_dev_register issues kmalloc(...,GFP_KERNEL) and atm_dev_lock 
  is hold

-- 
Ueimor
