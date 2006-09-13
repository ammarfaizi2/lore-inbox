Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWIMTk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWIMTk7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 15:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWIMTk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 15:40:59 -0400
Received: from waste.org ([66.93.16.53]:33455 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751157AbWIMTk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 15:40:58 -0400
Date: Wed, 13 Sep 2006 14:39:17 -0500
From: Matt Mackall <mpm@selenic.com>
To: David Howells <dhowells@redhat.com>
Cc: Aubrey <aubreylee@gmail.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel@vger.kernel.org, davidm@snapgear.com, gerg@snapgear.com
Subject: Re: kernel BUGs when removing largish files with the SLOB allocator
Message-ID: <20060913193917.GH6412@waste.org>
References: <6d6a94c50609032356t47950e40lbf77f15136e67bc5@mail.gmail.com> <17162.1157365295@warthog.cambridge.redhat.com> <6d6a94c50609042052n4c1803eey4f4412f6153c4a2b@mail.gmail.com> <3551.1157448903@warthog.cambridge.redhat.com> <6d6a94c50609051935m607f976j942263dd1ac9c4fb@mail.gmail.com> <44FE4222.3080106@yahoo.com.au> <6d6a94c50609120107w1942a8d8j368dd57a271d0250@mail.gmail.com> <15193.1158088232@warthog.cambridge.redhat.com> <6495.1158094606@warthog.cambridge.redhat.com> <31224.1158098385@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31224.1158098385@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another issue that occurred to me last night is that the size of
objects allocated with SLOB's slab-like API are implicit and not
calculable from the object. kmalloc'ed objects, in contrast, have a
header that contains the object size.

So ksize(kmalloc(...)) works, but not ksize(kmem_cache_alloc(...)). I
don't know if anything in the kernel is using the latter aside from
kobjsize.

-- 
Mathematics is the supreme nostalgia of our time.
