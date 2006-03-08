Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbWCHATj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWCHATj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 19:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbWCHATj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 19:19:39 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:30857
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964807AbWCHATi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 19:19:38 -0500
Date: Tue, 07 Mar 2006 16:18:08 -0800 (PST)
Message-Id: <20060307.161808.60227862.davem@davemloft.net>
To: mlleinin@hpcn.ca.sandia.gov
Cc: shemminger@osdl.org, xma@us.ibm.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       mst@mellanox.co.il
Subject: Re: [openib-general] Re: TSO and IPoIB performance degradation
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1141776697.6119.938.camel@localhost>
References: <1141767891.6119.903.camel@localhost>
	<20060307134907.733d3d27@localhost.localdomain>
	<1141776697.6119.938.camel@localhost>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Leininger <mlleinin@hpcn.ca.sandia.gov>
Date: Tue, 07 Mar 2006 16:11:37 -0800

>   I used the standard setting for tcp_rmem and tcp_wmem.   Here are a
> few other runs that change those variables.  I was able to improve
> performance by ~30MB/s to 403 MB/s, but this is still a ways from the
> 474 MB/s before the TSO patches.

How limited are the IPoIB devices, TX descriptor wise?

One side effect of the TSO changes is that one extra descriptor
will be used for outgoing packets.  This is because we have to
put the headers as well as the user data, into page based
buffers now.

Perhaps you can experiment with increasing the transmit descriptor
table size, if that's possible.
