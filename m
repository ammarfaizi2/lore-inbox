Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbWDGNhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWDGNhO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 09:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbWDGNhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 09:37:13 -0400
Received: from mx02.cybersurf.com ([209.197.145.105]:46755 "EHLO
	mx02.cybersurf.com") by vger.kernel.org with ESMTP id S964792AbWDGNhL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 09:37:11 -0400
Subject: Re: [PATCH] net: Broadcast ARP packets on link local addresses
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Anand Kumria <wildfire@progsoc.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <pan.2006.04.07.07.20.44.797909@progsoc.org>
References: <17453.47752.914390.692779@dl2.hq2.avtrex.com>
	 <pan.2006.04.07.07.20.44.797909@progsoc.org>
Content-Type: text/plain
Organization: unknown
Date: Fri, 07 Apr 2006 09:37:06 -0400
Message-Id: <1144417027.5082.41.camel@jzny2>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-04 at 17:20 +1000, Anand Kumria wrote:
> On Fri, 31 Mar 2006 15:26:00 -0800, David Daney wrote:
> 
> > From: David Daney
> > 
> > Greetings,
> > 
> > When an internet host joins a network where there is no DHCP server,
> > it may auto-allocate an IP address by the method described in RFC
> > 3927.  There are several user space daemons available that implement
> > most of the protocol (zcip, busybox, ...).  The kernel's APR driver
> > should function in the normal manner except that it is required to
> > broadcast all ARP packets that it originates in the link local address
> > space (169.254.0.0/16).  RFC 3927 section 2.5 explains the requirement.
> > 
> > The current ARP code is non-compliant because it does not broadcast
> > some ARP packets as required by RFC 3927.
> 
> I haven't seem anyone comment on this, 

Theres a lot of comments - check the archives of netdev on the thread
as well as a newer thread under "Broadcast ARP packets on link local
addresses (Version2)"

> but it would be useful to see this
> integrated.

IMO not the way it is defined right now in that patch. 
As suggested in the thread, best way is for the kernel to check
if it is link local and do the advert in broadcast instead of unicast.

> 
> Something else I've noticed while I've been implementing my zeroconf
> daemon is that the kernel returns link-scoped primary addresses first to
> 'ifconfig'.  Unfortunately quite a lot of user-space programs parse its
> output and interpret the address it presents as the primary for the
> specified interface.
> 

Not sure i followed.

> Is that a case of user-space breakage that the kernel team would
> ordinarily worry about?

I think user space setting the attribute of the address to be link local
would be a sufficient hint to the kernel to broadcast the arps.

cheers,
jamal


