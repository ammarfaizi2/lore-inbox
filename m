Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWDDPVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWDDPVk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 11:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWDDPVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 11:21:40 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:35031 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750706AbWDDPVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 11:21:39 -0400
Date: Tue, 4 Apr 2006 08:21:33 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Nick Piggin <npiggin@suse.de>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [patch 2/3] mm: speculative get_page
In-Reply-To: <20060219020159.9923.94877.sendpatchset@linux.site>
Message-ID: <Pine.LNX.4.64.0604040820540.26807@schroedinger.engr.sgi.com>
References: <20060219020140.9923.43378.sendpatchset@linux.site>
 <20060219020159.9923.94877.sendpatchset@linux.site>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Apr 2006, Nick Piggin wrote:

> +	/*
> +	 * PageNoNewRefs is set in order to prevent new references to the
> +	 * page (eg. before it gets removed from pagecache). Wait until it
> +	 * becomes clear (and checks below will ensure we still have the
> +	 * correct one).
> +	 */
> +	while (unlikely(PageNoNewRefs(page)))
> +		cpu_relax();

That part looks suspiciously like we need some sort of lock here.
