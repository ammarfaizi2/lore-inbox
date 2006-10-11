Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030779AbWJKDgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030779AbWJKDgW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 23:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030777AbWJKDgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 23:36:22 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:57542
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030776AbWJKDgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 23:36:21 -0400
Date: Tue, 10 Oct 2006 20:36:24 -0700 (PDT)
Message-Id: <20061010.203624.91207079.davem@davemloft.net>
To: rdreier@cisco.com
Cc: mst@mellanox.co.il, shemminger@osdl.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, openib-general@openib.org, rolandd@cisco.com
Subject: Re: Dropping NETIF_F_SG since no checksum feature.
From: David Miller <davem@davemloft.net>
In-Reply-To: <adar6xfbk6d.fsf@cisco.com>
References: <adavemrbtcx.fsf@cisco.com>
	<20061011002656.GB30093@mellanox.co.il>
	<adar6xfbk6d.fsf@cisco.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 10 Oct 2006 20:33:46 -0700

>     Michael> My guess was, an extra pass over data is likely to be
>     Michael> expensive - dirtying the cache if nothing else. But I do
>     Michael> plan to measure that, and see.
> 
> I don't get it -- where's the extra pass?  If you can't compute the
> checksum on the NIC then you have to compute sometime it on the CPU
> before passing the data to the NIC.

Also, if you don't do checksumming on the card we MUST copy
the data (be it from a user buffer, or from a filesystem page
cache page) into a private buffer since if the data changes
the checksum would become invalid, as I mentioned in another
email earlier.

Therefore, since we have to copy anyways, it always is better
to checksum in parallel with the copy.

So the whole idea of SG without hw-checksum support is without
much merit at all.
