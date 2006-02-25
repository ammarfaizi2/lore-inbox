Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbWBYWPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWBYWPw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 17:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbWBYWPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 17:15:52 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:47269 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750797AbWBYWPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 17:15:52 -0500
Subject: Re: slab: Remove SLAB_NO_REAP option
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Alok Kataria <alok.kataria@calsoftinc.com>,
       manfred@colorfullife.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0602240817110.20760@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.63.0602231502380.7798@localhost.localdomain>
	 <20060223020957.478d4cc1.akpm@osdl.org>
	 <Pine.LNX.4.58.0602231331530.15716@sbz-30.cs.Helsinki.FI>
	 <Pine.LNX.4.64.0602230917540.1796@schroedinger.engr.sgi.com>
	 <1140719812.11455.1.camel@localhost>
	 <Pine.LNX.4.64.0602231044210.13228@schroedinger.engr.sgi.com>
	 <84144f020602232336l480f6a4el9f7f708f9c3a61e1@mail.gmail.com>
	 <Pine.LNX.4.64.0602240817110.20760@schroedinger.engr.sgi.com>
Date: Sun, 26 Feb 2006 00:15:50 +0200
Message-Id: <1140905750.11182.7.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2006, Pekka Enberg wrote:
> > I don't think its worth it. It doesn't make much sense to create a
> > separate object cache if you're not using it, we're better off
> > converting those to kmalloc(). cache_cache is there to make
> > bootstrapping easier, it is very unlikely that you ever have more than
> > one page allocated for that cache which is why scanning the freelist
> > _at all_ is silly. I think SLAB_NO_REAP should go away but we also
> > must ensure we don't introduce a performance regression while doing
> > that.

On Fri, 2006-02-24 at 08:19 -0800, Christoph Lameter wrote:
> Got some way to get rid of cache_cache? Or remove it after boot?

Well, yeah. We can bootsrap a generic cache that can hold sizeof(struct
kmem_cache) first and use that.

				Pekka

