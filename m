Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbVBATS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbVBATS3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 14:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVBATS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 14:18:29 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:13781 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261534AbVBATSN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 14:18:13 -0500
Date: Tue, 1 Feb 2005 11:18:06 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Mel Gorman <mel@csn.ul.ie>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Helping prezoring with reduced fragmentation allocation
In-Reply-To: <20050201171641.CC15EE5E8@skynet.csn.ul.ie>
Message-ID: <Pine.LNX.4.58.0502011110560.3436@schroedinger.engr.sgi.com>
References: <20050201171641.CC15EE5E8@skynet.csn.ul.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Feb 2005, Mel Gorman wrote:

> This is a patch that makes a step towards tieing the modified allocator
> for reducing fragmentation with the prezeroing of pages that is based
> on a discussion with Christoph. When a block has to be split to satisfy a
> zero-page, both buddies are zero'd, one is allocated and the other is placed
> on the free-list for the USERZERO pool. Care is taken to make sure the pools
> are not accidently fragmented.

Thanks for integrating the page zero stuff. If you are zeroing pages
before their are fragmented then we may not need scrubd anymore. On the
other hand, larger than necessary zeroing may be performaned in the hot
code paths which may result in sporadically longer delays during
allocation (well but then the page_allocator can generate these delays for
a number of reasons).

> I would expect that a scrubber daemon would go through the KERNNORCLM pool,
> remove pages, scrub them and move them to USERZERO. It is important that pages
> not be moved from the USERRCLM or KERNRCLM pools as it'll cause fragmentation
> problems over time.

Would it not be better to zero the global 2^MAX_ORDER pages by the scrub
daemon and have a global zeroed page list? That way you may avoid zeroing
when splitting pages?


