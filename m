Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262610AbVF2Qvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbVF2Qvh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 12:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262622AbVF2Qvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 12:51:36 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:38789 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S262610AbVF2QvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 12:51:13 -0400
Message-ID: <42C2D0C1.4030500@ammasso.com>
Date: Wed, 29 Jun 2005 11:48:01 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.8) Gecko/20050511 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>
CC: rostedt@goodmis.org, Arjan van de Ven <arjan@infradead.org>,
       Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: kmalloc without GFP_xxx?
References: <200506291402.18064.vda@ilport.com.ua> <1120045024.3196.34.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0506290927370.22775@localhost.localdomain> <200506291714.32990.vda@ilport.com.ua>
In-Reply-To: <200506291714.32990.vda@ilport.com.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:

> This is why I always use _irqsave. Less error prone.

No, it's just bad programming.  How hard can it be to see which spinlocks are being used 
by your ISR and which ones aren't?  Only the ones that your ISR touches should have 
_irqsave.  It's really quite simple.

> This is more or less what I meant. Why think about each kmalloc and when you
> eventually did get it right: "Aha, we _sometimes_ get called from spinlocked code,
> GFP_ATOMIC then" - you still do atomic alloc even if cases when you
> were _not_ called from locked code! Thus you needed to think longer and got
> code which is worse.

So you're saying that you're the kind of programmer who makes more mistakes the longer you 
think about something?????

Using GFP_ATOMIC increases the probability that you won't be able to allocate the memory 
you need, and it also increases the probability that some other module that really needs 
GFP_ATOMIC will also be unable to allocate the memory it needs.  Please tell me, how is 
this considered good programming?

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com

One thing a Southern boy will never say is,
"I don't think duct tape will fix it."
      -- Ed Smylie, NASA engineer for Apollo 13
