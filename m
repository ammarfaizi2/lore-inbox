Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVFCEtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVFCEtv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 00:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVFCEtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 00:49:51 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:745
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261248AbVFCEtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 00:49:45 -0400
Date: Thu, 02 Jun 2005 21:49:27 -0700 (PDT)
Message-Id: <20050602.214927.59657656.davem@davemloft.net>
To: nickpiggin@yahoo.com.au
Cc: jschopp@austin.ibm.com, mbligh@mbligh.org, mel@csn.ul.ie,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Avoiding external fragmentation with a placement policy
 Version 12
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1117770488.5084.25.camel@npiggin-nld.site>
References: <429E50B8.1060405@yahoo.com.au>
	<429F2B26.9070509@austin.ibm.com>
	<1117770488.5084.25.camel@npiggin-nld.site>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Piggin <nickpiggin@yahoo.com.au>
Date: Fri, 03 Jun 2005 13:48:08 +1000

> It would really help your cause in the short term if you can
> demonstrate improvements for say order-3 allocations (eg. use
> gige networking, TSO, jumbo frames, etc).

TSO chops up the user data into PAGE_SIZE chunks, it doesn't
make use of non-zero page orders.

AF_UNIX sockets, however, will happily use higher order
pages.  But even this is limited to SKB_MAX_ORDER which
is currently defined to 2.

So the only way to get order 3 or larger allocations with
the networking is to use jumbo frames but without TSO enabled.

Actually, even with TSO enabled, you'll get large order
allocations, but for receive packets, and these allocations
happen in software interrupt context.
