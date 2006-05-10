Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbWEJHJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWEJHJs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 03:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWEJHJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 03:09:48 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:32896 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751408AbWEJHJr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 03:09:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=GDAN0p7m+l6vIsOPmstyipTJYCkBkNlNb4RbQfaDu75N5cBRW1wSuO8IUb622QzeRx2nTKZWivrBO+0Ou4kAwIzi6gDFRo41g1LAdr67mmlxYWFn3vAg9puR8MnXGNlClOTyNOi9JeDiyOjKy5O9AKkBCzp6VZ5G/TkI+aEry/0=
Message-ID: <84144f020605100009i74824233ie6feaf6fd2d9055f@mail.gmail.com>
Date: Wed, 10 May 2006 10:09:46 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Mike Kravetz" <kravetz@us.ibm.com>
Subject: Re: [PATCH] alloc_memory_early() routines
Cc: "Andrew Morton" <akpm@osdl.org>, "Dave Hansen" <haveblue@us.ibm.com>,
       "Christoph Lameter" <clameter@sgi.com>,
       "Andy Whitcroft" <apw@shadowen.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060509210722.GD3168@w-mikek2.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060509053512.GA20073@monkey.ibm.com>
	 <20060508224952.0b43d0fd.akpm@osdl.org>
	 <20060509210722.GD3168@w-mikek2.ibm.com>
X-Google-Sender-Auth: fdaa3bbeb096424a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 5/10/06, Mike Kravetz <kravetz@us.ibm.com> wrote:
> diff -Naupr linux-2.6.17-rc3-mm1/mm/slab.c linux-2.6.17-rc3-mm1.work3/mm/slab.c
> --- linux-2.6.17-rc3-mm1/mm/slab.c      2006-05-03 22:19:16.000000000 +0000
> +++ linux-2.6.17-rc3-mm1.work3/mm/slab.c        2006-05-09 21:38:23.000000000 +0000

[snip]

> +void * __init alloc_memory_early_node(size_t size, gfp_t flags, int node)
> +{
> +       if (g_cpucache_up == FULL)
> +               return kmalloc_node(size, flags, node);
> +       else
> +               return alloc_bootmem_node(NODE_DATA(node), size);
> +}

I'd prefer you put this in mm/bootmem.c and added a

int slab_is_available(void)
{
       return g_cpucache_up == FULL;
}

to mm/slab.c instead.

                                               Pekka
