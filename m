Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266304AbUHDQtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266304AbUHDQtZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 12:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267350AbUHDQtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 12:49:25 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:17931 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266304AbUHDQtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 12:49:24 -0400
Date: Wed, 4 Aug 2004 17:48:56 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Christoph Hellwig <hch@infradead.org>, ganesh.venkatesan@intel.com,
       jgarzik@pobox.com, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/12 2.4] e1000 - use vmalloc for data structures not shared with h/w
Message-ID: <20040804174856.B24545@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	ganesh.venkatesan@intel.com, jgarzik@pobox.com, netdev@oss.sgi.com,
	linux-kernel@vger.kernel.org
References: <20040729192519.A6235@infradead.org> <E1BqoRX-0004DH-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E1BqoRX-0004DH-00@gondolin.me.apana.org.au>; from herbert@gondor.apana.org.au on Sat, Jul 31, 2004 at 05:38:11PM +1000
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2004 at 05:38:11PM +1000, Herbert Xu wrote:
> > No, it's not.  vmalloc needs virtual space that's rather limited (e.g. 64MB
> > on PAE x86) in addition to physical memory.  Unless you do really big
> > allocations stay away from vmalloc.
> 
> How big is really big? 64K? 256K? 1M?

Well, the VM deals with big-order (aka bigger than page size) allocations
rather bad, so for allocation during any I/O I'd stick to allocation smaller
than that (and certainly no vmalloc!), for init-time allocations order 1 is
fine, maybe even order 2 or three.
