Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbVDDSAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVDDSAW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 14:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbVDDR6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 13:58:10 -0400
Received: from pat.uio.no ([129.240.130.16]:12953 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261315AbVDDR4u convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 13:56:50 -0400
Subject: Re: [RFC] Add support for semaphore-like structure with support
	for asynchronous I/O
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-aio@kvack.org
In-Reply-To: <20050404162216.GA18469@kvack.org>
References: <1112219491.10771.18.camel@lade.trondhjem.org>
	 <20050330143409.04f48431.akpm@osdl.org>
	 <1112224663.18019.39.camel@lade.trondhjem.org>
	 <1112309586.27458.19.camel@lade.trondhjem.org>
	 <20050331161350.0dc7d376.akpm@osdl.org>
	 <1112318537.11284.10.camel@lade.trondhjem.org>
	 <20050401141225.GA3707@in.ibm.com> <20050404155245.GA4659@in.ibm.com>
	 <20050404162216.GA18469@kvack.org>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 Apr 2005 13:56:35 -0400
Message-Id: <1112637395.10602.95.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 8BIT
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.795, required 12,
	autolearn=disabled, AWL 1.21, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

må den 04.04.2005 Klokka 12:22 (-0400) skreiv Benjamin LaHaise:

> > Your approach looks reasonable and simple enough. It'd be useful if I
> > could visualize the caller side of things as in the NFS client stream
> > as you mention - do you plan to post that soon ? 
> > I'm tempted to think about the possibility of using your iosems
> > with retry-based AIO.
> 
> I'm not sure I see the point in adding yet another type of lock to the 
> kernel that has different infrastructure.  This will end up with much 
> more code changing to adapt to the new iosems, rather than just using a 
> new primative on the existing semaphores.

The point is to avoid having to develop and test 23 different and highly
arch-dependent (and hence non-maintainable) versions of the same code.
In particular note that many of those architectures appear to be heavily
over-optimized to directly inline assembly code as well as to use
non-standard calling conventions. They all also manage somehow to differ
w.r.t. spinlocking conventions and even w.r.t. the internal structures
and algorithms used.

IOW: the current semaphore implementations really all need to die, and
be replaced by a single generic version to which it is actually
practical to add new functionality.

Failing that, it is _much_ easier to convert the generic code that needs
to support aio to use a new locking implementation and then test that.
It is not as if conversion to aio won't involve changes to the code in
the area surrounding those locks anyway.

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

