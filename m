Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVFCFv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVFCFv2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 01:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVFCFv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 01:51:28 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:41193
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261300AbVFCFvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 01:51:25 -0400
Date: Thu, 02 Jun 2005 22:51:10 -0700 (PDT)
Message-Id: <20050602.225110.03979632.davem@davemloft.net>
To: mbligh@mbligh.org
Cc: nickpiggin@yahoo.com.au, jschopp@austin.ibm.com, mel@csn.ul.ie,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Avoiding external fragmentation with a placement policy
 Version 12
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <358040000.1117777372@[10.10.2.4]>
References: <357240000.1117776882@[10.10.2.4]>
	<20050602.223712.41634750.davem@davemloft.net>
	<358040000.1117777372@[10.10.2.4]>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Martin J. Bligh" <mbligh@mbligh.org>
Date: Thu, 02 Jun 2005 22:42:52 -0700

> but it's vastly different order of magnitude than touching disk.
> Can we not do a "sniff alloc" first (ie if this is easy, give it
> to me, else just fail and return w/o reclaim), then fall back to
> smaller allocs?

That's what AF_UNIX does.

But with other protocols, we can't jiggle the loopback
MTU just because higher allocs no longer are easily
obtainable.

Really, the networking should not try to grab anything
more than SKB_MAX_ORDER unless the device's MTU is
larger than PAGE_SIZE << SKB_MAX_ORDER, which loopback's
"16K - fudge" is not.
