Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264104AbTFNBYp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 21:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264105AbTFNBYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 21:24:45 -0400
Received: from pizda.ninka.net ([216.101.162.242]:19899 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264104AbTFNBYp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 21:24:45 -0400
Date: Fri, 13 Jun 2003 18:34:40 -0700 (PDT)
Message-Id: <20030613.183440.41634090.davem@redhat.com>
To: anton@samba.org
Cc: scott.feldman@intel.com, haveblue@us.ibm.com, hdierks@us.ibm.com,
       dwg@au1.ibm.com, linux-kernel@vger.kernel.org, milliner@us.ibm.com,
       ricardoz@us.ibm.com, twichell@us.ibm.com, netdev@oss.sgi.com
Subject: Re: e1000 performance hack for ppc64 (Power4)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030614005534.GF32097@krispykreme>
References: <C6F5CF431189FA4CBAEC9E7DD5441E010107D93A@orsmsx402.jf.intel.com>
	<20030613.165250.41635765.davem@redhat.com>
	<20030614005534.GF32097@krispykreme>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Anton Blanchard <anton@samba.org>
   Date: Sat, 14 Jun 2003 10:55:34 +1000

   What I think is happening is that we arent tripping the prefetch
   logic.  We should take a latency hit for only the first cacheline
   at which point the host bridge decides to start prefetching for
   us. If not then we take take the latency hit on each transaction.

It sounds like what happens is that the sub-cacheline word reads
don't trigger the prefetch, but the first PCI read multiple
transaction does.
