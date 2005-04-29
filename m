Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262803AbVD2PmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262803AbVD2PmV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 11:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbVD2PmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 11:42:21 -0400
Received: from pat.uio.no ([129.240.130.16]:9373 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262801AbVD2PmQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 11:42:16 -0400
Subject: Re: [RFC] unify semaphore implementations
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050429141437.GA24617@kvack.org>
References: <20050428182926.GC16545@kvack.org>
	 <17009.33633.378204.859486@cargo.ozlabs.ibm.com>
	 <20050429141437.GA24617@kvack.org>
Content-Type: text/plain
Date: Fri, 29 Apr 2005 11:42:00 -0400
Message-Id: <1114789320.10086.81.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.493, required 12,
	autolearn=disabled, AWL 1.46, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fr den 29.04.2005 Klokka 10:14 (-0400) skreiv Benjamin LaHaise:
> On Fri, Apr 29, 2005 at 10:44:17AM +1000, Paul Mackerras wrote:
> > You have made semaphores bigger and slower on the architectures that
> > have load-linked/store-conditional instructions, which is at least
> > ppc, ppc64, sparc64 and alpha.  Did you take the trouble to understand
> > the ppc semaphore implementation?
> 
> The ppc implementation does have some good ideas that are worth using.  
> It's hard to know which of the 23 versions were worth using, but I'm 
> getting a picture where at least 2 variants are need.  The atomic ops 
> variant should use the single counter as ppc does (why did nobody port 
> that to x86?).  A spinlock version is needed at least by parisc.

The PPC implementation would be hard to port to x86, since it relies on
the load-linked/store-conditional stuff to provide a fast primitive for
atomic_dec_if_positive().
The only way I found to implement that on x86 was to use cmpxchg. On my
machine, therefore, a spinlock-based semaphore implementation turns out
to be at least as fast for the "fast" path (and is naturally much more
efficient for the slow path).

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

