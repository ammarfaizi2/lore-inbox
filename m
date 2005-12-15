Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161125AbVLOFbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161125AbVLOFbv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 00:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161123AbVLOFbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 00:31:51 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:48598
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161120AbVLOFbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 00:31:50 -0500
Date: Wed, 14 Dec 2005 21:23:09 -0800 (PST)
Message-Id: <20051214.212309.127095596.davem@davemloft.net>
To: mpm@selenic.com
Cc: sri@us.ibm.com, ak@suse.de, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 0/3] TCP/IP Critical socket communication mechanism
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051215050250.GT8637@waste.org>
References: <20051215033937.GC11856@waste.org>
	<20051214.203023.129054759.davem@davemloft.net>
	<20051215050250.GT8637@waste.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Mackall <mpm@selenic.com>
Date: Wed, 14 Dec 2005 21:02:50 -0800

> There needs to be two rules:
> 
> iff global memory critical flag is set
> - allocate from the global critical receive pool on receive
> - return packet to global pool if not destined for a socket with an
>   attached send mempool

This shuts off a router and/or firewall just because iSCSI or NFS peed
in it's pants.  Not really acceptable.

> I think this will provide the desired behavior

It's not desirable.

What if iSCSI is protected by IPSEC, and the key management daemon has
to process a security assosciation expiration and negotiate a new one
in order for iSCSI to further communicate with it's peer when this
memory shortage occurs?  It needs to send packets back and forth with
the remove key management daemon in order to do this, but since you
cut it off with this critical receive pool, the negotiation will never
succeed.

This stuff won't work.  It's not a generic solution and that's
why it has more holes than swiss cheese. :-)
