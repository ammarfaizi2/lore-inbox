Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWISHIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWISHIw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 03:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWISHIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 03:08:52 -0400
Received: from ironport-c10.fh-zwickau.de ([141.32.72.200]:2985 "EHLO
	ironport-c10.fh-zwickau.de") by vger.kernel.org with ESMTP
	id S1751195AbWISHIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 03:08:51 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAAEEzD0WLawEBDQ
X-IronPort-AV: i="4.09,184,1157320800"; 
   d="scan'208"; a="3227810:sNHT32418128"
Date: Tue, 19 Sep 2006 09:08:48 +0200
From: Joerg Roedel <joro-lkml@zlug.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH] EtherIP tunnel driver (RFC 3378)
Message-ID: <20060919070848.GA11567@zlug.org>
References: <20060911204129.GA28929@zlug.org> <20060918205252.GA6830@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060918205252.GA6830@xi.wantstofly.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2006 at 10:52:52PM +0200, Lennert Buytenhek wrote:

> Check out the thread "[PATCH][RFC] etherip: Ethernet-in-IPv4 tunneling"
> that was on netdev in January of 2005 -- a number of arguments against
> etherip (and for tunneling ethernet in GRE) were raised back then.

I read this thread some weeks ago.  I think there are reasons to have
both variants in the kernel. Since both versions are implemented in
different operatins systems and devices, having both will Linux make
interoperable with all of them.  In fact, the only implementers for
EtherIP I found were various BSD derivates. I actually implemented this
driver upon request of a BSD user who wanted interoperability of the
NetBSD EtherIP implementation with Linux.

> 
> One of the most significant ones, IMHO:
> 
> > Another argument against etherip would be that OpenBSD apparently
> > mis-implemented etherip by putting the etherip version nibble in the
> > second nibble of the etherip header instead of the first, which would
> > probably prevent the linux and OpenBSD versions from interoperating,
> > negating the advantage of using etherip in the first place.

I think this is not really a mistake in the OpenBSD implementation. In
my opinion, the RFC is unclear at this point. I focused on
interoperability in my implementation and did it the same way as OpenBSD
(as NetBSD does also, AFAIK FreeBSD has also an EtherIP implementation,
 but I don't tested it). This is the reason why my driver does not check
the value of the incoming EtherIP header too.

Regards,
	Joerg Roedel
