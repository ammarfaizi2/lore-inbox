Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268553AbUH3RCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268553AbUH3RCR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 13:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268565AbUH3RCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 13:02:17 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:19675 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S268553AbUH3RCM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 13:02:12 -0400
Date: Mon, 30 Aug 2004 19:02:11 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Lameter <clameter@sgi.com>, paulus@samba.org, ak@muc.de,
       davem@davemloft.net, ak@suse.de, wli@holomorphy.com, davem@redhat.com,
       raybry@sgi.com, benh@kernel.crashing.org, manfred@colorfullife.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       vrajesh@umich.edu, hugh@veritas.com
Subject: Re: page fault scalability patch final : i386 tested, x86_64 support added
Message-ID: <20040830170211.GB7718@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Christoph Lameter <clameter@sgi.com>, paulus@samba.org, ak@muc.de,
	davem@davemloft.net, ak@suse.de, wli@holomorphy.com,
	davem@redhat.com, raybry@sgi.com, benh@kernel.crashing.org,
	manfred@colorfullife.com, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org, vrajesh@umich.edu, hugh@veritas.com
References: <20040827173641.5cfb79f6.akpm@osdl.org> <20040828010253.GA50329@muc.de> <20040827183940.33b38bc2.akpm@osdl.org> <16687.59671.869708.795999@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0408272021070.16607@schroedinger.engr.sgi.com> <20040827204241.25da512b.akpm@osdl.org> <Pine.LNX.4.58.0408272121300.16949@schroedinger.engr.sgi.com> <20040827223954.7d021aac.akpm@osdl.org> <Pine.LNX.4.58.0408272256030.17485@schroedinger.engr.sgi.com> <20040827230637.6b3eb2ac.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040827230637.6b3eb2ac.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 11:06:37PM -0700, Andrew Morton wrote:
> Christoph Lameter <clameter@sgi.com> wrote:
> >
> > > As I said - for both these applications we need a new type which is
> >  > atomic64_t on 64-bit and atomic_t on 32-bit.
> > 
> >  That is simply a new definition in include/asm-*/atomic.h
> > 
> >  so
> > 
> >  #define atomic_long atomic64_t
> > 
> >  on 64 bit
> > 
> >  and
> > 
> >  #define atomic_long atomic_t
> > 
> >  on 32bit?
> 
> No, a whole host of wrappers are needed - atomic_long_inc/dec/set/read,
> etc.  For page->_count we'll also need the fancier functions such as
> atomic_long_add_return().

hmm, please correct me, but last time I checked
atomic_add_return() wasn't even available for i386
for example ...

best,
Herbert

> As I said: let's address this later on.  It's probably not an issue for RSS
> until 4-level pagetables come along.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
