Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271407AbTHMGWg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 02:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271408AbTHMGWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 02:22:36 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:42756 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271407AbTHMGWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 02:22:35 -0400
Date: Wed, 13 Aug 2003 07:22:33 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Roland McGrath <roland@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] read_trylock for i386
Message-ID: <20030813072233.B25803@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Roland McGrath <roland@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200308130614.h7D6EHv07972@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200308130614.h7D6EHv07972@magilla.sf.frob.com>; from roland@redhat.com on Tue, Aug 12, 2003 at 11:14:17PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 12, 2003 at 11:14:17PM -0700, Roland McGrath wrote:
> The following header patches add the read_trylock macro, implementing it
> fully for i386 and leaving other architectures with an always-fail fallback.
> Other architectures include/asm-foo/spinlock.h files should define
> _raw_read_trylock appropriately and define HAVE_ARCH_RAW_READ_TRYLOCK.  But
> until they do, machine-independent code can use read_trylock for optimization
> purposes (i.e. where it falls back to using read_lock) and architectures that
> haven't implemented it will just not be getting the optimization.  

I strongy dislike the always-fail case.  Just let the other arches fail
until the arch maintainers update them.

