Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932616AbVLFRxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932616AbVLFRxL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 12:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932615AbVLFRxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 12:53:11 -0500
Received: from ns2.suse.de ([195.135.220.15]:7313 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932605AbVLFRxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 12:53:10 -0500
Date: Tue, 6 Dec 2005 18:52:56 +0100
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, Christoph Hellwig <hch@infradead.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, ak@suse.de,
       torvalds@osdl.org
Subject: Re: [PATCH 1/2] Zone reclaim V2
Message-ID: <20051206175256.GO11190@wotan.suse.de>
References: <20051206172444.18786.30131.sendpatchset@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051206172444.18786.30131.sendpatchset@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 09:24:44AM -0800, Christoph Lameter wrote:
> Zone reclaim allows the reclaiming of pages from a zone if the number of free
> pages falls below the watermark even if other zones still have enough pages
> available. Zone reclaim is of particular importance for NUMA machines. It can
> be more beneficial to reclaim a page than taking the performance penalties
> that come with allocating a page on a remote zone.
> 
> The patch replaces Martin Hick's zone reclaim function (which was never
> working properly).
> 
> An arch can control zone_reclaim by setting zone_reclaim_mode during bootup
> if it is discovered that the kernel is running on an NUMA configuration.

Looks much better. Thanks. But how about auto controlling the variable in generic
code based on node_distance() (at least for the non node hotplug case)


> +/*
> + * Zone reclaim mode
> + *
> + * If non-zero call zone_reclaim when the number of free pages falls below
> + * the watermarks.
> + */
> +int zone_reclaim_mode;

I would mark it __read_mostly to avoid potential false sharing.

-Andi
