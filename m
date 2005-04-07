Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262465AbVDGOXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbVDGOXz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 10:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbVDGOXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 10:23:55 -0400
Received: from soundwarez.org ([217.160.171.123]:28806 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S262465AbVDGOXv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 10:23:51 -0400
Date: Thu, 7 Apr 2005 16:23:49 +0200
From: Kay Sievers <kay.sievers@vrfy.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Ian Campbell <ijc@hellion.org.uk>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>, greg@kroah.com,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
Message-ID: <20050407142349.GA26743@vrfy.org>
References: <1112859412.18360.31.camel@frecb000711.frec.bull.fr> <1112860419.28858.76.camel@uganda> <1112861638.28858.92.camel@uganda> <1112865153.3086.134.camel@icampbell-debian> <1112867556.28858.135.camel@uganda> <1112870517.3279.42.camel@localhost.localdomain> <1112873074.28858.167.camel@uganda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112873074.28858.167.camel@uganda>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 03:24:34PM +0400, Evgeniy Polyakov wrote:
> On Thu, 2005-04-07 at 12:41 +0200, Kay Sievers wrote:
> > On Thu, 2005-04-07 at 13:52 +0400, Evgeniy Polyakov wrote:
> > > On Thu, 2005-04-07 at 10:12 +0100, Ian Campbell wrote:
> > > > On Thu, 2005-04-07 at 12:13 +0400, Evgeniy Polyakov wrote:
> > > > > The main idea was to simplify userspace control and notification
> > > > > system - so people did not waste it's time learning how skb's are
> > > > > allocated
> > > > > and processed, how socket layer is designed and what all those
> > > > > netlink_* and NLMSG* mean if they do not need it.
> > > > 
> > > > Isn't connector built on top of netlink? If so, is there any reason for
> > > > it to be a new subsystem rather than an extension the the netlink API?
> > > 
> > > Connector is not netlink API extension in any way.
> > > It uses netlink as transport layer, one can change
> > > cn_netlink_send()/cn_input() 
> > > into something like bidirectional ioctl and use it.
> > > 
> > > Only one cn_netlink_send() function can be "described" as API
> > > extension, 
> > > although even it is not entirely true.
> > 
> > I see much overlap here too. Wouldn't it be nice to see the transport
> > part of the connector code to be implemented as a generic netlink
> > multicast? We already have uni- and broadcast for netlink.
> 
> Netlink broadcast is multicast actually,
> if listener exists, then message will be sent to him, 
> if no - skb will be just freed.
> 
> > Isn't the whole purpose of the connector to hook in notifications that
> > act only if someone is listening? That is a perfect multicast case. :)
> 
> Connector can be used to send data from userspace to kernelspace,
> so it allows sending controlling messages without ioctl() compatibility 
> mess and so on.
> 
> One may use cn_netlink_send() to send notification without being
> registered 
> in connector, if it's second parameter is 0, then appropriate 
> connector listener will be searched for.

Sure, but seems I need to ask again: What is the exact reason not to implement
the muticast message multiplexing/subscription part of the connector as a
generic part of netlink? That would be nice to have and useful for other
subsystems too as an option to the current broadcast.

> It is different from netlink messages, 
> netlink is a transport layer for connector.

That's still possible and the kernel usually doesn't care about unimplemented
alternatives. :)

Thanks,
Kay
