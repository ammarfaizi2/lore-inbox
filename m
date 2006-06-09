Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbWFIE3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWFIE3Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 00:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965151AbWFIE3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 00:29:25 -0400
Received: from ns2.suse.de ([195.135.220.15]:43411 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964863AbWFIE3Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 00:29:25 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH 01/14] Per zone counter functionality
Date: Fri, 9 Jun 2006 06:28:57 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-mm@kvack.org, Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com> <20060608230244.25121.76440.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060608230244.25121.76440.sendpatchset@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606090628.57497.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +/*
> + * For an unknown interrupt state
> + */
> +void mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
> +				int delta)
> +{
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	__mod_zone_page_state(zone, item, delta);
> +	local_irq_restore(flags);

It would be nicer to use some variant of local_t - then you could do that
without turning off interrupts (which some CPUs like P4 don't like)

There currently is not 1 byte local_t but it could be added.

Mind you it would only make sense when most of the calls are not already
with interrupts disabled.

-Andi
