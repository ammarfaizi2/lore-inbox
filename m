Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263078AbVFXDzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263078AbVFXDzQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 23:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263074AbVFXDzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 23:55:16 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:62178
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S263064AbVFXDy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 23:54:58 -0400
Date: Thu, 23 Jun 2005 20:54:47 -0700 (PDT)
Message-Id: <20050623.205447.66178303.davem@davemloft.net>
To: christoph@lameter.com
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org, shai@scalex86.org,
       akpm@osdl.org, netdev@vger.kernel.org, herbert@gondor.apana.org.au
Subject: Re: [PATCH] dst_entry structure use,lastuse and refcnt abstraction
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.62.0506232047450.29103@graphe.net>
References: <Pine.LNX.4.62.0506232037430.28814@graphe.net>
	<20050623.204702.26274560.davem@davemloft.net>
	<Pine.LNX.4.62.0506232047450.29103@graphe.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Lameter <christoph@lameter.com>
Date: Thu, 23 Jun 2005 20:49:17 -0700 (PDT)

> No I told you that we need to disassemble the atomic dec_and_test 
> in order to be able to split the counters.

Ok.  You're going to have to come up with something better
than a %3 AIM benchmark increase with 5000 threads to justify
those invasive NUMA changes, and thus this infrastructure for
it.

In order to convince me on this NUMA dst stuff, you need to put away
the benchmark microscope and instead use a "macroscrope" to analyze
the side effects of these changes on a higher level.

Really, what are the effects on other things?  For example, what
does this do to routing performance?  Does the packets per second
go down, if so by how much?

What happens if you bind network interfaces, and the processes that
use them, to cpus.  Why would that be too intrusive to setup for the
administrator of such large NUMA machines?

What about loads that have low route locality, and thus touch many
different dst entries, not necessarily contending for a single one
amongst several nodes?  Does performance go up or down for such a
case?

I'm picking those examples, because I am rather certain your patches
will hurt performance in those cases.  The data structure size
expansion and extra memory allocations alone for the per-node dst
stuff should be good about doing that.

> > > Yes and it was recently changed. Typical use is linux-xxx@vger.kernel.org
> > 
> > netdev@oss.sgi.com is what used to be the place for networking
> > stuff, it's not netdev@vger.kernel.org
> 
> s/not/now/ right?

Right. :)
