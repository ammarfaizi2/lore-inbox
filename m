Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752165AbWCJHXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165AbWCJHXE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 02:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752164AbWCJHXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 02:23:03 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:6320
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751328AbWCJHXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 02:23:01 -0500
Date: Thu, 09 Mar 2006 23:23:01 -0800 (PST)
Message-Id: <20060309.232301.77550306.davem@davemloft.net>
To: rick.jones2@hp.com
Cc: netdev@vger.kernel.org, mst@mellanox.co.il, rdreier@cisco.com,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: TSO and IPoIB performance degradation
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <4410C671.2050300@hp.com>
References: <20060308125311.GE17618@mellanox.co.il>
	<20060309.154819.104282952.davem@davemloft.net>
	<4410C671.2050300@hp.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rick Jones <rick.jones2@hp.com>
Date: Thu, 09 Mar 2006 16:21:05 -0800

> well, there are stacks which do "stretch acks" (after a fashion) that 
> make sure when they see packet loss to "do the right thing" wrt sending 
> enough acks to allow cwnds to open again in a timely fashion.

Once a loss happens, it's too late to stop doing the stretch ACKs, the
damage is done already.  It is going to take you at least one
extra RTT to recover from the loss compared to if you were not doing
stretch ACKs.

You have to keep giving consistent well spaced ACKs back to the
receiver in order to recover from loss optimally.

The ACK every 2 full sized frames behavior of TCP is absolutely
essential.
