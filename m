Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030359AbVKCPy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030359AbVKCPy1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 10:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030361AbVKCPy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 10:54:27 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:13646 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP
	id S1030359AbVKCPyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 10:54:25 -0500
Date: Thu, 3 Nov 2005 17:53:44 +0200
From: Gleb Natapov <gleb@minantech.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
Message-ID: <20051103155343.GG22185@minantech.com>
References: <Pine.LNX.4.61.0511031447080.23441@goblin.wat.veritas.com> <20051103151421.GD31134@mellanox.co.il> <Pine.LNX.4.61.0511031526410.23783@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511031526410.23783@goblin.wat.veritas.com>
X-OriginalArrivalTime: 03 Nov 2005 15:54:24.0514 (UTC) FILETIME=[DCD96620:01C5E08E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 03:37:44PM +0000, Hugh Dickins wrote:
> > > I don't much want to add another path into copy_pte_range, actually
> > > copying pages.  If the process really wants DMA into such areas,
> > > then it should contain the code for the child to COW them itself?
> > 
> > How do you do that, say, for a stack page, or global data section?
> 
> And why do you need to?
> 
> You seem to be saying, actually DONTCOPY isn't enough of a solution,
> we need something else instead.
> 
DONTCOPY is a good solution for the problem it solves, but there are
other problems :). One of them is what should we do if only part of the
page is used for DMA and other part contains information needed by the
forked child? We can copy such pages on fork or declare such state to be
user error. I can live with both.

--
			Gleb.
