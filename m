Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262414AbVDGKmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262414AbVDGKmF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 06:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbVDGKmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 06:42:04 -0400
Received: from soundwarez.org ([217.160.171.123]:63199 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S262414AbVDGKmA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 06:42:00 -0400
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
From: Kay Sievers <kay.sievers@vrfy.org>
To: johnpol@2ka.mipt.ru
Cc: Ian Campbell <ijc@hellion.org.uk>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>, greg@kroah.com,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1112867556.28858.135.camel@uganda>
References: <1112859412.18360.31.camel@frecb000711.frec.bull.fr>
	 <1112860419.28858.76.camel@uganda>  <1112861638.28858.92.camel@uganda>
	 <1112865153.3086.134.camel@icampbell-debian>
	 <1112867556.28858.135.camel@uganda>
Content-Type: text/plain
Date: Thu, 07 Apr 2005 12:41:57 +0200
Message-Id: <1112870517.3279.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 (2.2.1.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-07 at 13:52 +0400, Evgeniy Polyakov wrote:
> On Thu, 2005-04-07 at 10:12 +0100, Ian Campbell wrote:
> > On Thu, 2005-04-07 at 12:13 +0400, Evgeniy Polyakov wrote:
> > > The main idea was to simplify userspace control and notification
> > > system - so people did not waste it's time learning how skb's are
> > > allocated
> > > and processed, how socket layer is designed and what all those
> > > netlink_* and NLMSG* mean if they do not need it.
> > 
> > Isn't connector built on top of netlink? If so, is there any reason for
> > it to be a new subsystem rather than an extension the the netlink API?
> 
> Connector is not netlink API extension in any way.
> It uses netlink as transport layer, one can change
> cn_netlink_send()/cn_input() 
> into something like bidirectional ioctl and use it.
> 
> Only one cn_netlink_send() function can be "described" as API
> extension, 
> although even it is not entirely true.

I see much overlap here too. Wouldn't it be nice to see the transport
part of the connector code to be implemented as a generic netlink
multicast? We already have uni- and broadcast for netlink.

Isn't the whole purpose of the connector to hook in notifications that
act only if someone is listening? That is a perfect multicast case. :)

At the time we added kobject_uevent I was missing something like this.
The broadcast groups did not really fit, and we decided not to use them,
and unicast wasn't a option here.

Thanks,
Kay

