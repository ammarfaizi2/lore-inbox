Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbVLLIuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbVLLIuX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 03:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbVLLIuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 03:50:23 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:17025 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1751125AbVLLIuW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 03:50:22 -0500
Message-ID: <439D39A8.1020806@cosmosbay.com>
Date: Mon, 12 Dec 2005 09:49:44 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, Simon Derr <Simon.Derr@bull.net>,
       Andi Kleen <ak@suse.de>, Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH] Cpuset: rcu optimization of page alloc hook
References: <20051211233130.18000.2748.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20051211233130.18000.2748.sendpatchset@jackhammer.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Mon, 12 Dec 2005 09:49:45 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson a écrit :

> +
> +static kmem_cache_t *cpuset_cache;
> +

Hi Paul

Please do use __read_mostly for new kmem_cache :

static kmem_cache_t *cpuset_cache __read_mostly;

If not, the pointer can sit in the midle of a highly modified cache line, and 
multiple CPUS will have memory cache misses to access the cpuset_cache, while 
slab code/data layout itself is very NUMA/SMP friendly.

Eric
