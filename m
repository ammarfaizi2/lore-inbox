Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751484AbWHRVZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbWHRVZM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 17:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWHRVZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 17:25:12 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:48835
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751450AbWHRVZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 17:25:10 -0400
Date: Fri, 18 Aug 2006 14:25:13 -0700 (PDT)
Message-Id: <20060818.142513.29571851.davem@davemloft.net>
To: linas@austin.ibm.com
Cc: benh@kernel.crashing.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       Jens.Osterkamp@de.ibm.com, jklewis@us.ibm.com, arnd@arndb.de
Subject: Re: [PATCH 2/4]: powerpc/cell spidernet low watermark patch.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060818192356.GD26889@austin.ibm.com>
References: <20060811170813.GJ10638@austin.ibm.com>
	<1155771820.11312.116.camel@localhost.localdomain>
	<20060818192356.GD26889@austin.ibm.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: linas@austin.ibm.com (Linas Vepstas)
Date: Fri, 18 Aug 2006 14:23:56 -0500

> On Thu, Aug 17, 2006 at 01:43:40AM +0200, Benjamin Herrenschmidt wrote:
> > 
> > Sounds good (without actually looking at the code though :), that was a
> > long required improvement to that driver. Also, we should probably look
> > into using NAPI polling for tx completion queue as well, no ?
> 
> Just for a lark, I tried using NAPI polling, while disabling all TX
> interrupts. Performance was a disaster: 8Mbits/sec, fom which I conclude
> that the tcp ack packets do not flow back fast enough to allw reliance
> on NAPI polling for transmit.

The idea is to use NAPI polling with TX interrupts disabled.

We're not saying to use the RX interrupt as the trigger for
RX and TX work.  Rather, either of RX or TX interrupt will
schedule the NAPI poll.
