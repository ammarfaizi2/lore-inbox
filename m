Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262360AbVBLAYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbVBLAYl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 19:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbVBLAYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 19:24:41 -0500
Received: from waste.org ([216.27.176.166]:12489 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262360AbVBLAYf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 19:24:35 -0500
Date: Fri, 11 Feb 2005 16:24:02 -0800
From: Matt Mackall <mpm@selenic.com>
To: Fruhwirth Clemens <clemens@endorphin.org>
Cc: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       linux-kernel@vger.kernel.org, michal@logix.cz, davem@davemloft.net,
       adam@yggdrasil.com
Subject: Re: [PATCH 01/04] Adding cipher mode context information to crypto_tfm
Message-ID: <20050212002402.GD2474@waste.org>
References: <Xine.LNX.4.44.0502091859540.6222-100000@thoron.boston.redhat.com> <1107997358.7645.24.camel@ghanima> <20050209171943.05e9816e.akpm@osdl.org> <1108028923.14335.44.camel@ghanima> <20050210023344.390fb358.akpm@osdl.org> <1108034244.14335.59.camel@ghanima>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108034244.14335.59.camel@ghanima>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2005 at 12:17:24PM +0100, Fruhwirth Clemens wrote:
> On Thu, 2005-02-10 at 02:33 -0800, Andrew Morton wrote:
> > Fruhwirth Clemens <clemens@endorphin.org> wrote:
> > >
> > > On Wed, 2005-02-09 at 17:19 -0800, Andrew Morton wrote:
> > > > Fruhwirth Clemens <clemens@endorphin.org> wrote:
> > > > Adding a few more fixmap slots wouldn't hurt anyone.  But if you want an
> > > > arbitrarily large number of them then no, we cannot do that.
> > > 
> > > What magnitude is "few more"? 2, 10, 100?
> > 
> > Not 100.  10 would seem excessive.
> 
> Out of curiosity: Where does this limitation even come from? What
> prevents kmap_atomic from adding slots dynamically?

There's a single page of PTEs for mapping high memory and the atomic
slots are a small subset of that. They're fixed in number for
complexity reasons - we don't want to have an allocator here:

/*
 * kmap_atomic/kunmap_atomic is significantly faster than kmap/kunmap because
 * no global lock is needed and because the kmap code must perform a global TLB
 * invalidation when the kmap pool wraps.
 *

-- 
Mathematics is the supreme nostalgia of our time.
