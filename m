Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265935AbTIJWyT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 18:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265937AbTIJWyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 18:54:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:35459 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265935AbTIJWyR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 18:54:17 -0400
Date: Wed, 10 Sep 2003 15:36:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: jbarnes@sgi.com (Jesse Barnes)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] you have how many nodes??
Message-Id: <20030910153601.36219ed8.akpm@osdl.org>
In-Reply-To: <20030910223430.GA18244@sgi.com>
References: <20030910213602.GC17266@sgi.com>
	<20030910151254.52f53e62.akpm@osdl.org>
	<20030910223430.GA18244@sgi.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jbarnes@sgi.com (Jesse Barnes) wrote:
>
> On Wed, Sep 10, 2003 at 03:12:54PM -0700, Andrew Morton wrote:
> > I think.  We could just say "dang numaq needs five bits", so:
> > 
> > 
> > 	#if BITS_PER_LONG == 32
> > 	#define ZONE_SHIFT 5
> > 	#else
> > 	#define ZONE_SHIFT 10
> > 	#endif
> 
> That's fine with me, do you want me to rediff and send a new patch?
> 

Well your patch as it stands would appear to break NUMAQ builds, due to
NUMAQ setting MAX_NUMNODES directly in the arch code.  ia64 is using
another layer of macroification via NR_NODES instead.

MAX_NUMNODES, NR_NODES and MAX_NR_NODES appear to be a bit of a mess, and
they should all be replaced with shift distances anyway.

Could you please get together with Martin Bligh, come up with something
which works on NUMAQ and your 128 CPU PDA and also cast an eye across the
other architectures (sparc64, sh, ...)?  It all needs a bit of thought and
a spring clean.

Thanks.

