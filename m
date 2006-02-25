Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbWBYHeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWBYHeq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 02:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWBYHeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 02:34:46 -0500
Received: from mx.pathscale.com ([64.160.42.68]:14271 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932440AbWBYHep (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 02:34:45 -0500
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200602250543.22421.ak@suse.de>
References: <1140841250.2587.33.camel@localhost.localdomain>
	 <200602250543.22421.ak@suse.de>
Content-Type: text/plain
Date: Fri, 24 Feb 2006 23:34:53 -0800
Message-Id: <1140852894.2587.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 (2.5.90-2.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-02-25 at 05:43 +0100, Andi Kleen wrote:
> On Saturday 25 February 2006 05:20, Bryan O'Sullivan wrote:
> > On some platforms, a regular wmb() is not sufficient to guarantee that
> > PCI writes have been flushed to the bus if write combining is in effect.
> 
> On what platforms?

On x86_64 in particular, if CONFIG_UNORDERED_IO is defined.  Regular
wmb() is implemented as a compiler memory barrier then, which isn't
sufficient for PCI write combining.

> linux/system.h looks unnatural to me.

I used this for symmetry with <asm/system.h> where other barriers are
defined.  It could obviously go into io.h instead, since it's an
MMIO-related barrier, but I didn't want to separate it from other
barriers.

If you have a location you'd prefer, please let me know.

> > We also define a version of wc_wmb() with the required semantics
> > on x86_64.
> 
> Leaving i386 out in the cold?

Looks like it should be defined there, too, something like this perhaps:

#define wc_wmb() alternative("lock; addl $0,0(%%esp)", "sfence", X86_FEATURE_XMM)

Does that look right?

	<b

