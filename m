Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263701AbUD0D0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263701AbUD0D0R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 23:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263709AbUD0D0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 23:26:17 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:2653 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263701AbUD0D0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 23:26:16 -0400
Message-ID: <408DD2D5.1040306@yahoo.com.au>
Date: Tue, 27 Apr 2004 13:26:13 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: ext3 inode cache eats system, news at 11
References: <20040426171856.22514.qmail@lwn.net> <20040426181235.2b5b62c8.akpm@osdl.org>
In-Reply-To: <20040426181235.2b5b62c8.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6-rc2/2.6.6-rc2-mm2/broken-out/slab-order-0-for-vfs-caches.patch
> 
> is not a completely happy solution, but it should fix things up.

Another thing you could be doing is not zeroing swapper->nr
if the shrinker function doesn't do anything, in order to try
to maintain pressure on the dcache. This would be similar to
your deferred list idea.

But I guess that using 0 order allocations for these GFP_NOFS
caches means you would be losing far less dcache pressure in
this way, so it might not make much difference.
