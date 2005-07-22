Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbVGVP4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVGVP4U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 11:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVGVP4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 11:56:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:63909 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261302AbVGVP4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 11:56:17 -0400
Subject: Re: why is jiffies 128 in jffs2_find_gc_block() in gc.c of jffs2
From: David Woodhouse <dwmw2@infradead.org>
To: krishna <krishna.c@globaledgesoft.com>
Cc: linux-mtd@lists.infradead.org, Josh Boyer <jdub@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <42E079B8.9070703@globaledgesoft.com>
References: <42E079B8.9070703@globaledgesoft.com>
Content-Type: text/plain
Date: Fri, 22 Jul 2005 11:55:42 -0400
Message-Id: <1122047742.12630.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-22 at 10:14 +0530, krishna wrote:
> I am not clear why the hardcoded values are 50, 110 and 126
> and why is jiffies moded with 128, why not any other value.

It's just a way to achieve 'randomness' which doesn't actually consume
entropy and which is quick to obtain. It only needs to be relatively
evenly distributed.

We use it for selecting the next eraseblock to be garbage-collected.
50/128 of the time we pick a block from the eraseable_list, 60/128 of
the time we pick a block from the very_dirty_list, 16/128 of the time we
pick a block from the dirty_list, and the remaining 2/128 of the time we
pick a block from the clean_list for garbage collection.

The precise numbers don't have a huge amount of science behind them;
they are mostly guesses about what would achieve evenly-distributed wear
levelling over time without garbage-collecting clean blocks more often
than is necessary.

If you want to conduct tests with various workloads in order to refine
the fairly primitive algorithm described above, that could be useful.

-- 
dwmw2

