Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265033AbSKVP5I>; Fri, 22 Nov 2002 10:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265058AbSKVP5I>; Fri, 22 Nov 2002 10:57:08 -0500
Received: from 205-158-62-95.outblaze.com ([205.158.62.95]:22190 "HELO
	ws3-5.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S265033AbSKVP5F>; Fri, 22 Nov 2002 10:57:05 -0500
Message-ID: <20021122160409.28049.qmail@email.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "dan carpenter" <error27@email.com>
To: rml@tech9.net
Cc: linux-kernel@vger.kernel.org
Date: Fri, 22 Nov 2002 11:04:09 -0500
Subject: Re: calling schedule() from interupt context
X-Originating-Ip: 64.175.39.70
X-Originating-Server: ws3-5.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Love <rml@tech9.net>

> On Fri, 2002-11-22 at 03:54, dan carpenter wrote:
> 
> (Next time trim your CC list: none of those poor guys needed this
> email..)
> 

trimmed.

> > In drivers/net/tokenring/3c359.c xl_interrupt() calls schedule().
> > The path from xl_interupt to schedule is:
> > xl_rx ==> netif_rx ==> 
> > kfree_skb ==> __kfree_skb ==> 
> > secpath_put ==> __secpath_destroy ==> 
> > xfrm_state_put ==> __xfrm_state_destroy ==> xfrm_put_type ==> 
> > module_put ==> put_cpu ==> preempt_schedule ==> schedule
> 
> Are you actually seeing this code path or is this just what your script
> is showing you?
> 

ok.  I'm an idiot.

The script only checks things at compile time not at runtime.  So you are 
right, of course, that this couldn't happen in real life because of the
preemp_count.  

Thanks for the explanation...  

regards,
dan carpenter

-- 
_______________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

One click access to the Top Search Engines
http://www.exactsearchbar.com/mailcom

