Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264488AbUFEB5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264488AbUFEB5N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 21:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266131AbUFEB5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 21:57:13 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:908 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264488AbUFEB5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 21:57:10 -0400
Message-ID: <40C12865.9050803@colorfullife.com>
Date: Sat, 05 Jun 2004 03:56:53 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use numa policy API for boot time policy
References: <20040605034356.1037d299.ak@suse.de>
In-Reply-To: <20040605034356.1037d299.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>Suggested by Manfred Spraul.
>
>__get_free_pages had a hack to do node interleaving allocation at boot time.
>This patch sets an interleave process policy using the NUMA API for init
>and the idle threads instead. Before entering the user space init the policy
>is reset to default again. Result is the same.
>
>Advantage is less code and removing of a check from a fast path.
>
>Removes more code than it adds.
>
>I verified that the memory distribution after boot is roughly the same.
>
>  
>
Does it work for order != 0 allocations? It's important that the big 
hash tables do not end up all in node 0. AFAICS alloc_pages_current() 
calls interleave_nodes() only for order==0 allocs.

--
    Manfred

