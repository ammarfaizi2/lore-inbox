Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965001AbVLFSfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbVLFSfd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 13:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932617AbVLFSfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 13:35:33 -0500
Received: from ns1.suse.de ([195.135.220.2]:57497 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932605AbVLFSfc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 13:35:32 -0500
Date: Tue, 6 Dec 2005 19:35:24 +0100
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [RFC 1/3] Framework for accurate node based statistics
Message-ID: <20051206183524.GU11190@wotan.suse.de>
References: <20051206182843.19188.82045.sendpatchset@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051206182843.19188.82045.sendpatchset@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +static inline void mod_node_page_state(int node, enum node_stat_item item, int delta)
> +{
> +	vm_stat_diff[get_cpu()][node][item] += delta;
> +	put_cpu();

Instead of get/put_cpu I would use a local_t. This would give much better code
on i386/x86-64.  I have some plans to port over all the MM statistics counters
over to local_t, still stuck, but for new code it should be definitely done.

-Andi
