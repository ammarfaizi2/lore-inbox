Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262125AbVCIXhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbVCIXhH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbVCIXfC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:35:02 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:2214 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261199AbVCIXco (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 18:32:44 -0500
Date: Wed, 9 Mar 2005 15:32:28 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andi Kleen <ak@muc.de>
cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Page Fault Scalability patch V19 [4/4]: Drop use of page_table_lock
 in do_anonymous_page
In-Reply-To: <20050309232141.GD63395@muc.de>
Message-ID: <Pine.LNX.4.58.0503091526000.30604@schroedinger.engr.sgi.com>
References: <20050309201324.29721.28956.sendpatchset@schroedinger.engr.sgi.com>
 <20050309201344.29721.26698.sendpatchset@schroedinger.engr.sgi.com>
 <m13bv4whrl.fsf@muc.de> <Pine.LNX.4.58.0503091500040.30604@schroedinger.engr.sgi.com>
 <20050309231440.GB63395@muc.de> <Pine.LNX.4.58.0503091515440.30604@schroedinger.engr.sgi.com>
 <20050309232141.GD63395@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2005, Andi Kleen wrote:

> > Changing the type for the countedrs is possible by only changing the
> > definition of MM_COUNTER_T in include/sched.h. I would prefer to wait
> > until atomic64_t is available on all 64 bit platforms before making that
> > part of this patch.
>
> Well, they will not move until someone uses it (especially parisc
> and sh64 which always are quite out of sync in mainline). ppc64
> usually moves quickly.

Hmm. I could add that with

#ifdef ATOMIC64_INIT

atomic64

#else

atomic_t

#endif

> But adding arbitary limits like this even temporarily is imho
> a bad idea.

Hmmm yes this could actually develop to be an issue for us. Columbia has
20 Terabytes of memory (some rumors have it that it get up to 500TB but
maybe that was just a journalist). But Columbia has only 1TB per 512
CPU cluster addressable directly. So even the biggest box in existence
right now will be fine with V19.

But V20 will definitely support atomic64.

