Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbTLPPxb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 10:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbTLPPxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 10:53:31 -0500
Received: from mmjgroup.com ([192.34.35.33]:64704 "EHLO mmjgroup.com")
	by vger.kernel.org with ESMTP id S261892AbTLPPxa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 10:53:30 -0500
Date: Tue, 16 Dec 2003 08:53:24 -0700
From: LaMont Jones <lamont@mmjgroup.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Randolph Chung <randolph@tausq.org>, linux-kernel@vger.kernel.org,
       parisc-linux@lists.parisc-linux.org
Subject: Re: [parisc-linux] Re: Question about cache flushing and fork
Message-ID: <20031216155324.GB25535@mmjgroup.com>
Mail-Followup-To: LaMont Jones <lamont@mmjgroup.com>,
	"David S. Miller" <davem@redhat.com>,
	Randolph Chung <randolph@tausq.org>, linux-kernel@vger.kernel.org,
	parisc-linux@lists.parisc-linux.org
References: <20031216044033.GT533@tausq.org> <20031215204835.0993a51a.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031215204835.0993a51a.davem@redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 15, 2003 at 08:48:35PM -0800, David S. Miller wrote:
> On Mon, 15 Dec 2003 20:40:33 -0800
> Randolph Chung <randolph@tausq.org> wrote:
> > Can someone please explain why it is necessary to flush the cache 
> > during fork()? (i.e. call to flush_cache_mm() in dup_mmap)
> Writable pages that will be shared between the child and
> parent are marked read-only and COW, some cpu caches store
> protection information in the cache lines in order to avoid
> TLB lookups etc. so the caches must be flushed since the
> page protection information is changing.

On PARISC, the cache line contains the following elements:
	1) data (obviously)
	2) physical page
	3) dirty/clean/public/private/etc state

A cache access hits or misses depending on whether or not the physical page from
the TLB matches the physical page stored in the cache line.

If flushing is required during fork on PARISC, then there are cache consistency
issues elsewhere, something is horribly broken in the design (and it should be
falling all over anyway).

lamont
