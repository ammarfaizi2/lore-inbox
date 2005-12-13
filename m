Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbVLMU3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbVLMU3y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 15:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbVLMU3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 15:29:54 -0500
Received: from mf01.sitadelle.com ([212.94.174.68]:40592 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1751256AbVLMU3x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 15:29:53 -0500
Message-ID: <439F2F39.3090800@cosmosbay.com>
Date: Tue, 13 Dec 2005 21:29:45 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       Simon.Derr@bull.net, ak@suse.de, clameter@sgi.com
Subject: Re: [PATCH] Cpuset: rcu optimization of page alloc hook
References: <20051211233130.18000.2748.sendpatchset@jackhammer.engr.sgi.com>	<439D39A8.1020806@cosmosbay.com>	<20051212020211.1394bc17.pj@sgi.com>	<20051212021247.388385da.akpm@osdl.org>	<20051213075345.c39f335d.pj@sgi.com>	<439EF75D.50206@cosmosbay.com> <20051213120814.f7e1d73d.pj@sgi.com>
In-Reply-To: <20051213120814.f7e1d73d.pj@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson a écrit :
> Detail question ...
> 
> Eric wrote:
> 
>>Say you move to read mostly most of struct kmem_cache *
> 
> 
> Does the following:
> 
> 	struct kmem_cache *cpuset_cache __read_mostly;
> 
> mark just the one word pointer 'cpuset_cache' as __read_mostly,
> or does it mark the whole dang cpuset cache?
> 
> I presume it just marks the one pointer word.  Am I wrong?

Only the pointer is placed onto read mostly section.

In fact the pointer is written once at boot time, then it is only read.

kmem_cache implementation is SMP/NUMA friendly, keeping care of false sharing 
issues, and node aware memory.

But the initial pointer *should* be in a cache line shared by all cpus to get 
best performance. It's easy to achive this since the pointer is only read. 
(well... mostly... )

> 
> I ask because the subtle phrasing of your comment reads to
> my ear as if you knew it marked the entire cache.  I can't
> tell if that is due to my ears having a different language
> accent than yours, or if it is due to my getting this wrong.
> 

Sorry...

Eric
