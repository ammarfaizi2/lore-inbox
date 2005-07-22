Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVGVUIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVGVUIQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 16:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbVGVUIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 16:08:16 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:4299
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261366AbVGVUIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 16:08:13 -0400
Date: Fri, 22 Jul 2005 13:08:16 -0700 (PDT)
Message-Id: <20050722.130816.91445335.davem@davemloft.net>
To: smfltc@us.ibm.com
Cc: linux-kernel@vger.kernel.org, samba-technical@lists.samba.org,
       netdev@vger.kernel.org
Subject: Re: slow tcp acks on loopback device
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1122062219.29258.12.camel@stevef95.austin.ibm.com>
References: <1122062219.29258.12.camel@stevef95.austin.ibm.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve French <smfltc@us.ibm.com>
Date: 22 Jul 2005 14:56:59 -0500

> Noticing that the loopback device (at least on RHEL4) has an unfortunate
> mtu size 16384 (which is about 50 bytes too small for SMB read
> responses), I did try increasing the MTU slightly.  Changing that to
> 18000 did avoid the fragmentation and the 40ms delay - but what puzzled
> me was why setting TCP_NODELAY after the socket was created did not
> eliminate the delay on the ack and if there is a way to avoid the huge
> tcp ack delay by either doing something else to force client acking
> immediately or to do something on the client side of the stack to get
> the server to send the whole 16K+ frame - it looks like the tcp windows
> is 32K if the value in the tcp acks in the network trace is to be
> trusted.

TCP_NODELAY does not control ACK generation, instead it modifies
the Nagle algorithm behavior when sending data packets.

Please take networking discussions to netdev@vger.kernel.org which
is where the networking developers are.
