Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265591AbTFNAov (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 20:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265592AbTFNAov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 20:44:51 -0400
Received: from dp.samba.org ([66.70.73.150]:51844 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265591AbTFNAou (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 20:44:50 -0400
Date: Sat, 14 Jun 2003 10:55:34 +1000
From: Anton Blanchard <anton@samba.org>
To: "David S. Miller" <davem@redhat.com>
Cc: scott.feldman@intel.com, haveblue@us.ibm.com, hdierks@us.ibm.com,
       dwg@au1.ibm.com, linux-kernel@vger.kernel.org, milliner@us.ibm.com,
       ricardoz@us.ibm.com, twichell@us.ibm.com, netdev@oss.sgi.com
Subject: Re: e1000 performance hack for ppc64 (Power4)
Message-ID: <20030614005534.GF32097@krispykreme>
References: <C6F5CF431189FA4CBAEC9E7DD5441E010107D93A@orsmsx402.jf.intel.com> <20030613.165250.41635765.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030613.165250.41635765.davem@redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> So Anton, when the PCI controller gets a set of sub-cacheline word
> reads from the device, it reads the value from memory once for every
> one of those words?  ROFL, if so...  I can't believe they wouldn't
> put caches on the PCI controller for this, at least a one-behind that
> snoops the bus :(

There is a cache in the host bridge and the PCI-PCI bridge. I dont
think we go back to memory for sub cacheline reads.

What I think is happening is that we arent tripping the prefetch logic.
We should take a latency hit for only the first cacheline at which point
the host bridge decides to start prefetching for us. If not then we take
take the latency hit on each transaction.

Anton
