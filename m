Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbVFMVZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbVFMVZu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 17:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbVFMVZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 17:25:41 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:60301
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261410AbVFMVYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 17:24:39 -0400
Date: Mon, 13 Jun 2005 14:24:18 -0700 (PDT)
Message-Id: <20050613.142418.08323454.davem@davemloft.net>
To: ak@muc.de
Cc: gnuwind@gmail.com, casavan@sgi.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Is kernel 2.6.11 adjust tcp_max_syn_backlog incorrectly?
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <m11x79dwcb.fsf@muc.de>
References: <75052be7050606070691c302d@mail.gmail.com>
	<75052be705060607106a6c0882@mail.gmail.com>
	<m11x79dwcb.fsf@muc.de>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@muc.de>
Date: Sat, 11 Jun 2005 12:25:08 +0200

> Yes, there were some changes here when it was converted to a common
> function for all hash tables (alloc_large_system_hash - the function
> with the argument list from hell).  Anyways, here's a quick fix.
> 
> DaveM for your consideration.
> 
> Adjust TCP mem order check to new alloc_large_system_hash
> 
> Signed-off-by: Andi Kleen <ak@suse.de>

I just reread those NUMA changes, and they changed the heuristics
for sizing things at the same time as moving over to the
alloc_large_system_hash() change.

The change was to move from (21 - PAGE_SHIFT) and (23 - PAGE_SHIFT)
to (25 - PAGE_SHIFT) and (27 - PAGE_SHIFT) respectively.

This is the part of the NUMA TCP changes that made the sysctl setting
behavior differ.

Andi's patch is the least intrusive fix for 2.6.12, so I will
apply it.  But longer term these heuristics need to be revisited
as a whole.
