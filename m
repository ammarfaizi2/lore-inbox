Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318365AbSHUQXm>; Wed, 21 Aug 2002 12:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318369AbSHUQXm>; Wed, 21 Aug 2002 12:23:42 -0400
Received: from dsl-213-023-038-062.arcor-ip.net ([213.23.38.62]:52369 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318365AbSHUQXk>;
	Wed, 21 Aug 2002 12:23:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "tushar korde" <tushar_k5@rediffmail.com>, linux-kernel@vger.kernel.org
Subject: Re:
Date: Wed, 21 Aug 2002 18:30:01 +0200
X-Mailer: KMail [version 1.3.2]
References: <20020608213527.28801.qmail@webmail6.rediffmail.com>
In-Reply-To: <20020608213527.28801.qmail@webmail6.rediffmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17hYMt-0001Cq-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 June 2002 23:35, tushar  korde wrote:
> hi folks,
>  	as kmalloc allocates memory in power of 2 ( starting from 32 )
> instead of the size requested. there are following problems :
> 
>   1) we are allocating at least 32 bytes in all cases ( most of 
> the times it is not
> required ).
> 
>   2) if we allocate large memory, internal fregmentation also 
> increases.
> 
>   3) allocating more memory then the request often leads to 
> programming errors
> esp. when we store some data and read it back or try to get size 
> of data stored
>   ( though it can be handled but we have to take special care of 
> it at every point ).
> 
> the solution to above problems may be that we dont allocate 
> objects from the 13
> general purpose caches, instead we make a new cache keep its 
> address either in
> cache_sizes or declare it global. now as the kmalloc is invoked 
> check the memory size
> requested if predefined sizes are not suitable then make a new 
> object of the size
> requested ( now here the definition of c_offset flag of cache 
> descriptor may be
> violated ) and allot it to our new cache and return it .
> 
>  	i know that there may be subtle problems in it's 
> implementation.
> i need your suggestions. is it worth to make efforts in this 
> field.

You probably want kmem_cache_alloc, see slab.c.  Kmalloc is just an
interface to kmem_cache_alloc.

-- 
Daniel
