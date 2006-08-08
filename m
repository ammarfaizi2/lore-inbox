Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbWHHFOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWHHFOg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 01:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWHHFOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 01:14:36 -0400
Received: from cantor2.suse.de ([195.135.220.15]:38278 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751239AbWHHFOf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 01:14:35 -0400
From: Andi Kleen <ak@suse.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] x86_64: Make NR_IRQS configurable in Kconfig
Date: Tue, 8 Aug 2006 07:14:21 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <m1irl4ftya.fsf@ebiederm.dsl.xmission.com> <20060807194159.f7c741b5.akpm@osdl.org> <17624.7310.856480.704542@cargo.ozlabs.ibm.com>
In-Reply-To: <17624.7310.856480.704542@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608080714.21151.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 August 2006 07:09, Paul Mackerras wrote:
> Andrew Morton writes:

[adding linux-arch; talking about doing extensible per cpu areas
by prereserving virtual space and then later fill it up as needed]

> > > Drawback would be some more TLB misses.
> > 
> > yup.  On some (important) architectures - I'm not sure which architectures
> > do the bigpage-for-kernel trick.
> 
> I looked at optimizing the per-cpu data accessors on PowerPC and only
> ever saw fractions of a percent change in overall performance, which
> says to me that we don't actually use per-cpu data all that much.  So
> unless you make per-cpu data really really slow, I doubt that we'll
> see any significant performance difference.

The main problem is that we would need a "vmalloc reserve first; allocate pages
later" interface. On x86 it would be easy by just splitting up vmalloc/vmap a bit
again. Does anybody else see problems with implementing that on any
other architecture? 

This wouldn't be truly demand paged, just pages initialized on allocation.

-Andi

