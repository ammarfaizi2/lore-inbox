Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbVI2XLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbVI2XLq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 19:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbVI2XLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 19:11:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17546 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751359AbVI2XLp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 19:11:45 -0400
Date: Thu, 29 Sep 2005 16:11:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: rohit.seth@intel.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Martin Hicks <mort@sgi.com>
Subject: Re: [PATCH] earlier allocation of order 0 pages from pcp in
 __alloc_pages
Message-Id: <20050929161118.27f9f1eb.akpm@osdl.org>
In-Reply-To: <719460000.1128034108@[10.10.2.4]>
References: <20050929150155.A15646@unix-os.sc.intel.com>
	<719460000.1128034108@[10.10.2.4]>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@mbligh.org> wrote:
>
> It looks like we're now dropping into direct reclaim as the first thing
> in __alloc_pages before even trying to kick off kswapd. When the hell
> did that start? Or is that only meant to trigger if we're already below
> the low watermark level?

That's all the numa goop which Martin Hicks added.  It's all disabled if
z->reclaim_pages is zero (it is).  However we could be testing that flag a
bit earlier, I think.

And yeah, some de-spaghettification would be nice.  Certainly before adding
more logic.

Martin, should we take out the early zone reclaim logic?  It's all
unreachable at present anyway.

