Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbWBXBBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWBXBBA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 20:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWBXBA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 20:00:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27020 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932258AbWBXBA7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 20:00:59 -0500
Date: Thu, 23 Feb 2006 16:59:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: alokk@calsoftinc.com, manfred@colorfullife.com, penberg@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: Slab: Node rotor for freeing alien caches and remote per cpu
 pages.
Message-Id: <20060223165959.7b4310e4.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602231036480.13184@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0602231036480.13184@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@engr.sgi.com> wrote:
>
> +void drain_node_pages(int nodeid)
>   {
>  -	struct zone *zone;
>  -	int i;
>  +	int i, z;
>   	unsigned long flags;
>   
>   	local_irq_save(flags);
>  -	for_each_zone(zone) {
>  +	for (z = 0; z < MAX_NR_ZONES; z++) {
>  +		struct zone *zone = NODE_DATA(nodeid)->node_zones + z;
>   		struct per_cpu_pageset *pset;
>   
>  -		/* Do not drain local pagesets */
>  -		if (zone->zone_pgdat->node_id == numa_node_id())
>  -			continue;
>  -
>   		pset = zone_pcp(zone, smp_processor_id());
>   		for (i = 0; i < ARRAY_SIZE(pset->pcp); i++) {

Should it be testing populated_zone() in there?
