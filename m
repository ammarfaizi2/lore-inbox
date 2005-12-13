Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbVLMR4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbVLMR4a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 12:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbVLMR4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 12:56:30 -0500
Received: from mf01.sitadelle.com ([212.94.174.68]:17128 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S932417AbVLMR43
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 12:56:29 -0500
Message-ID: <439F0B43.4080500@cosmosbay.com>
Date: Tue, 13 Dec 2005 18:56:19 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       Simon.Derr@bull.net, ak@suse.de
Subject: Re: [PATCH] Cpuset: rcu optimization of page alloc hook
References: <20051211233130.18000.2748.sendpatchset@jackhammer.engr.sgi.com> <439D39A8.1020806@cosmosbay.com> <20051212020211.1394bc17.pj@sgi.com> <20051212021247.388385da.akpm@osdl.org> <20051213075345.c39f335d.pj@sgi.com> <439EF75D.50206@cosmosbay.com> <Pine.LNX.4.62.0512130938130.22803@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0512130938130.22803@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter a écrit :
> On Tue, 13 Dec 2005, Eric Dumazet wrote:
> 
> 
>>Say you move to read mostly most of struct kmem_cache *, they are guaranteed
>>to stay in 'mostly read'.
> 
> 
> True but then this variable is not frequently read. So false sharing would 
> not have much of an impact.
> 

If this variable is not frequently used, why then define its own cache ?

Ie why not use kmalloc() and let kernel use a general cache ?

On a 32 CPUS machine, a kmem_create() costs a *lot* of ram.

This overhead is acceptable if and only if :

- A lot of objects can be allocated in some cases (and using a special cache 
can save ram because of power of two general caches alignement)

- A lot of objects are created/deleted per unit of time (performance is critical)

For example pipe() could use its own cache to speedup some benchmarks, but the 
general kmalloc()/kfree() was chosen instead.

Eric
