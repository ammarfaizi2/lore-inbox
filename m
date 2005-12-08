Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbVLHVxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbVLHVxK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 16:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbVLHVxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 16:53:10 -0500
Received: from [194.90.237.34] ([194.90.237.34]:5712 "EHLO mtlex01.yok.mtl.com")
	by vger.kernel.org with ESMTP id S1751215AbVLHVxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 16:53:09 -0500
Date: Thu, 8 Dec 2005 23:56:00 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Hugh Dickins <hugh@veritas.com>
Cc: Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: set_page_dirty vs set_page_dirty_lock
Message-ID: <20051208215600.GE13886@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <Pine.LNX.4.61.0512081908530.11737@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0512081908530.11737@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hugh Dickins <hugh@veritas.com>:
> Many would be pleased if we could manage without set_page_dirty_lock.

It seems that I can do

	if (TestSetPageLocked(page))
		schedule_work()

and in this way, avoid the schedule_work overhead for the common case
where the page isnt locked.
Right?

If that works, I can mostly do things directly,
although I'm still stuck with the problem of an app performing
a fork + write into the same page while I'm doing DMA there.

I am currently solving this by doing a second get_user_pages after
DMA is done and comparing the page lists, but this, of course,
needs a task context ...

-- 
MST
