Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264705AbTA1AOX>; Mon, 27 Jan 2003 19:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264711AbTA1AOX>; Mon, 27 Jan 2003 19:14:23 -0500
Received: from holomorphy.com ([66.224.33.161]:30887 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264705AbTA1AOX>;
	Mon, 27 Jan 2003 19:14:23 -0500
Date: Mon, 27 Jan 2003 16:22:18 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <fletch@aracnet.com>
Cc: Andrew Morton <akpm@digeo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernbench-16 on 2.5.59 vs 2.5.59-mm6
Message-ID: <20030128002218.GE780@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <fletch@aracnet.com>,
	Andrew Morton <akpm@digeo.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <375110000.1043689012@titus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <375110000.1043689012@titus>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2003 at 09:36:52AM -0800, Martin J. Bligh wrote:
> 132 clear_page_tables
> 131 pgd_ctor
> -413 pgd_alloc

The pagetable preconstruction cache hit is spread across
clear_page_tables() and pgd_ctor() with the pgd_ctor patches.
This is the equivalent of the explicit zeroing in pgd_alloc().

Your result appears to imply the overhead has been reduced by 36%,
which is useful evidence for the PAE case. Before this the pgd_alloc()
overhead had only been observed on non-PAE systems.

Now, YTF hadn't I seen this before if all it took to bring it out was
a kernel compile? Perhaps diffprof (I prefer the multiplicative flavor
but nm that) of some flavor was lacking.


-- wli
