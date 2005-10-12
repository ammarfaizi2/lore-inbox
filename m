Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbVJLR3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbVJLR3p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 13:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbVJLR3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 13:29:45 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:44931 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932447AbVJLR3o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 13:29:44 -0400
Message-ID: <434D47FF.1000602@austin.ibm.com>
Date: Wed, 12 Oct 2005 12:29:35 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050909 Fedora/1.7.10-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
CC: mike kravetz <kravetz@us.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] Re: [PATCH 5/8] Fragmentation Avoidance V17: 005_fallback
References: <20051011151221.16178.67130.sendpatchset@skynet.csn.ul.ie> <20051011151246.16178.40148.sendpatchset@skynet.csn.ul.ie> <20051012164353.GA9425@w-mikek2.ibm.com> <Pine.LNX.4.58.0510121806550.9602@skynet>
In-Reply-To: <Pine.LNX.4.58.0510121806550.9602@skynet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In reality, no and it would only happen if a caller had specified both
> __GFP_USER and __GFP_KERNRCLM in the call to alloc_pages() or friends. It
> makes *no* sense for someone to do this, but if they did, an oops would be
> thrown during an interrupt. The alternative is to get rid of this last
> element and put a BUG_ON() check before the spinlock is taken.
> 
> This way, a stupid caller will damage the fragmentation strategy (which is
> bad). The alternative, the kernel will call BUG() (which is bad). The
> question is, which is worse?
> 

If in the future we hypothetically have code that damages the fragmentation 
strategy we want to find it sooner rather than never.  I'd rather some kernels 
BUG() than we have bugs which go unnoticed.
