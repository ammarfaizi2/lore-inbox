Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbVLFTIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbVLFTIz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 14:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030188AbVLFTIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 14:08:55 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:19896 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030185AbVLFTIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 14:08:54 -0500
Date: Tue, 6 Dec 2005 11:08:42 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [RFC 1/3] Framework for accurate node based statistics
In-Reply-To: <20051206183524.GU11190@wotan.suse.de>
Message-ID: <Pine.LNX.4.62.0512061105220.19475@schroedinger.engr.sgi.com>
References: <20051206182843.19188.82045.sendpatchset@schroedinger.engr.sgi.com>
 <20051206183524.GU11190@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Dec 2005, Andi Kleen wrote:

> > +static inline void mod_node_page_state(int node, enum node_stat_item item, int delta)
> > +{
> > +	vm_stat_diff[get_cpu()][node][item] += delta;
> > +	put_cpu();
> 
> Instead of get/put_cpu I would use a local_t. This would give much better code
> on i386/x86-64.  I have some plans to port over all the MM statistics counters
> over to local_t, still stuck, but for new code it should be definitely done.

Yuck. That code uses atomic operations and is not aware of atomic64_t.
