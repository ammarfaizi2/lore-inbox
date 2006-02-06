Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbWBFW3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbWBFW3Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 17:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbWBFW3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 17:29:16 -0500
Received: from gold.veritas.com ([143.127.12.110]:7751 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932399AbWBFW3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 17:29:15 -0500
Date: Mon, 6 Feb 2006 22:29:59 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Roland Dreier <rolandd@cisco.com>
cc: Kai Makisara <Kai.Makisara@kolumbus.fi>, Willem Riede <osst@riede.org>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [git patch review 2/2] IB: Don't doublefree pages from scatterlist
In-Reply-To: <1139070837112-3fe13a3288c20f5c@cisco.com>
Message-ID: <Pine.LNX.4.61.0602062221200.3844@goblin.wat.veritas.com>
References: <1139070837112-3fe13a3288c20f5c@cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 06 Feb 2006 22:29:14.0907 (UTC) FILETIME=[C2AABEB0:01C62B6C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Feb 2006, Roland Dreier wrote:

> On some architectures, mapping the scatterlist may coalesce entries:
> if that coalesced list is then used for freeing the pages afterwards,
> there's a danger that pages may be doubly freed (and others leaked).
> 
> Fix Infiniband's __ib_umem_release by freeing from a separate array
> beyond the scatterlist: IB_UMEM_MAX_PAGE_CHUNK lowered to fit one page.

It's now looking like this change won't be needed after all: Andi has
just posted a patch in the "ipr" thread which should stop x86_64 from
interfering with the scatterlist *page,offset,length fields, so what
IB and others were doing should then work safely (current thinking is
that x86_64 is the only architecture which coalesced in that way).

Hugh
