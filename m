Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161244AbWHDPet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161244AbWHDPet (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 11:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161246AbWHDPet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 11:34:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:13633 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161234AbWHDPes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 11:34:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ijNPc2rRWf31uGShiSlDD0gpnuLC6uWVQdogd5LqOyfiflrI6PLiFvgm9eVsGgQFP9m/JUFye30EYsShmIrJP2vdfJNNmoWmXr9UhOuERfnVrxeYZ6bU39w1NvZGuIFvefbR4Uk1hfwZkL7Uo7vOR3xyV2a1lJvO6YMGKcVZxDk=
Message-ID: <41b516cb0608040834o1d433f23v2f2ba1a1b05ccbc6@mail.gmail.com>
Date: Fri, 4 Aug 2006 08:34:46 -0700
From: "Chris Leech" <chris.leech@gmail.com>
To: "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>
Subject: Re: problems with e1000 and jumboframes
Cc: "Herbert Xu" <herbert@gondor.apana.org.au>, arnd@arndnet.de, olel@ans.pl,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20060804061513.GB413@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <41b516cb0608031334s6e159e99tb749240f44ae608d@mail.gmail.com>
	 <E1G8sif-0003oY-00@gondolin.me.apana.org.au>
	 <20060804061513.GB413@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/06, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> On Fri, Aug 04, 2006 at 03:59:37PM +1000, Herbert Xu (herbert@gondor.apana.org.au) wrote:
> > Interesting.  Could you guys post figures on alloc_page speed vs. kmalloc?
>
> They probalby measured kmalloc cache access, which only falls to
> alloc_pages when cache is refilled, so it will be faster for some short
> period of time, but in general (especially for such big-sized
> allocations) it is essencially the same.

I think you're right about that.  In particular, I think Jesse was
looking at the impact that changing the drivers buffer allocation
method would have on 1500 byte MTU users.  With a running network
driver you should see lots of fixed size allocations hitting the slab
cache, and occasionally causing an alloc_pages.  If you replace that
with a call to alloc_pages for every packet that ever gets received
it's a performance hit.

So how many skb allocation schemes do you code into a single driver?
Kmalloc everything, page alloc everything, combination of kmalloc and
page buffers for hardware that does header split?  That's three
versions of the drivers receive processing and skb allocation that
need to be maintained.

> > Also, getting memory slower is better than not getting them at all :)

Yep.

- Chris
