Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWHFUdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWHFUdT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 16:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWHFUdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 16:33:19 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:37838 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750705AbWHFUdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 16:33:18 -0400
Subject: Re: [PATCH] Proposed update to the kernel kmap/kunmap API
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060806124827.7f0e1993.akpm@osdl.org>
References: <1154876516.3683.201.camel@mulgrave.il.steeleye.com>
	 <20060806124827.7f0e1993.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 06 Aug 2006 15:33:04 -0500
Message-Id: <1154896384.3683.238.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-08-06 at 12:48 -0700, Andrew Morton wrote:
> kmap() is a nasty thing.  It has theoretical deadlock problems (which used
> to be real ones back in the 2.4 days) and the present implementation uses a
> kernel-wide lock.
> 
> We've been gradually and sporadically working to make kmap() go away, so
> please let's not do anything which encourages its use.
> 
> kmap_atomic() is much preferred.  Can this initiative be recast around
> kmap_atomic()?

Well the API change intercepts both kmap/kunmap and
kmap_atomic/kunmap_atomic; it's designed to be agnostic to the _atomic
bit (I just wrote kmap/kunmap in the Subject line because I was saving
letters).  Since it's intended as a flushing API, it has no context
issues, so the parisc implementation is the similar for both (the only
difference being the return value).

However, while kmap exists, it also has to be intercepted for this
approach to work...

James


