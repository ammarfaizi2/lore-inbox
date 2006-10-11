Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030778AbWJKDmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030778AbWJKDmX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 23:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030777AbWJKDmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 23:42:23 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:38759 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S1030769AbWJKDmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 23:42:22 -0400
To: David Miller <davem@davemloft.net>
Cc: mst@mellanox.co.il, shemminger@osdl.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, openib-general@openib.org, rolandd@cisco.com
Subject: Re: Dropping NETIF_F_SG since no checksum feature.
X-Message-Flag: Warning: May contain useful information
References: <adavemrbtcx.fsf@cisco.com>
	<20061011002656.GB30093@mellanox.co.il> <adar6xfbk6d.fsf@cisco.com>
	<20061010.203624.91207079.davem@davemloft.net>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 10 Oct 2006 20:42:20 -0700
In-Reply-To: <20061010.203624.91207079.davem@davemloft.net> (David Miller's message of "Tue, 10 Oct 2006 20:36:24 -0700 (PDT)")
Message-ID: <adak637bjs3.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 11 Oct 2006 03:42:21.0645 (UTC) FILETIME=[420DF7D0:01C6ECE7]
Authentication-Results: sj-dkim-2.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    David> Also, if you don't do checksumming on the card we MUST copy
    David> the data (be it from a user buffer, or from a filesystem
    David> page cache page) into a private buffer since if the data
    David> changes the checksum would become invalid, as I mentioned
    David> in another email earlier.

Yes, I get that now -- I replied to Michael's email before I read yours.

    David> Therefore, since we have to copy anyways, it always is
    David> better to checksum in parallel with the copy.

Yes.

    David> So the whole idea of SG without hw-checksum support is
    David> without much merit at all.

Well, on IB it is possible to implement a netdevice (IPoIB connected
mode, I assume that's what Michael is working on) with a large MTU
(64KB is a number thrown around, but really there's not any limit) but
no HW checksum capability.  Doing that in a practical way means we
need to allow non-linear skbs to be passed in.

On the other hand I'm not sure how useful such a netdevice would be --
will non-sendfile() paths generate big packets even if the MTU is 64KB?

Maybe GSO gives us all the real advantages of this anyway?

 - R.
