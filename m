Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbVJJNEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbVJJNEz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 09:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbVJJNEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 09:04:55 -0400
Received: from [218.22.21.1] ([218.22.21.1]:56499 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1750768AbVJJNEy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 09:04:54 -0400
Date: Mon, 10 Oct 2005 21:07:05 +0800
From: WU Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: riel@redhat.com
Subject: [RFC] use radix_tree for non-resident page tracking
Message-ID: <20051010130705.GA5026@mail.ustc.edu.cn>
Mail-Followup-To: WU Fengguang <wfg@mail.ustc.edu.cn>,
	linux-kernel@vger.kernel.org, riel@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rik,
The CLOCK-Pro page replacement is quite appealing, and I'd like to
contribute an idea: How about store bookkeeping info of dropped pages
in-place in radix_tree?

The slots in radix_tree_node can be used for bookkeeping data when
the corresponding pages are dropped. When all pages in a radix_tree_node
have been dropped, it is registered in an array/list for delayed
reclaim.

It would be fast and simple:
- no cache-line pollution
- no extra lock (with Nick Piggin's great RCU improvement)
- ready to use lookup code

The memory footprint should be roughly the same, though with a whole
word of space for each page ;)

It can not cover the swap space, which should be handled differently
anyway, I guess.

Regards,
Wu Fengguang
