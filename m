Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbUDCIlH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 03:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbUDCIlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 03:41:07 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:37898 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261638AbUDCIlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 03:41:05 -0500
Date: Sat, 3 Apr 2004 09:40:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, hugh@veritas.com, vrajesh@umich.edu,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040403094058.A13091@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
	hugh@veritas.com, vrajesh@umich.edu, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <Pine.LNX.4.44.0404020145490.2423-100000@localhost.localdomain> <20040402011627.GK18585@dualathlon.random> <20040401173649.22f734cd.akpm@osdl.org> <20040402020022.GN18585@dualathlon.random> <20040402104334.A871@infradead.org> <20040402164634.GF21341@dualathlon.random> <20040402195927.A6659@infradead.org> <20040402192941.GP21341@dualathlon.random> <20040402205410.A7194@infradead.org> <20040402203514.GR21341@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040402203514.GR21341@dualathlon.random>; from andrea@suse.de on Fri, Apr 02, 2004 at 10:35:14PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2004 at 10:35:14PM +0200, Andrea Arcangeli wrote:
> how can that be the second one? (I deduced it was the first one because
> it cannot be the second one and the offset didn't look at the very end
> of the function). This is the second one:
> 
> 		if (!PageCompound(p))
> 			bad_page(__FUNCTION__, p);
> 
> but bad_page shows p->flags == 0x00080008 and 1<<PG_compound ==
> 0x80000.
> 
> So PG_compound is definitely set for "p" and it can't be the second one
> triggering.
> 
> Can you double check? Maybe we should double check the asm. Something
> sounds fundamentally wrong in the asm, sounds like a miscompilation,
> which compiler are you using?

Because I didn't trust my ppc assembly reading that much I put in a printk
and it's actually the third bad_page(), sorry.

