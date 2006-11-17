Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933635AbWKQOsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933635AbWKQOsq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 09:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933636AbWKQOsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 09:48:46 -0500
Received: from ra.tuxdriver.com ([70.61.120.52]:45581 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S933634AbWKQOsp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 09:48:45 -0500
Date: Fri, 17 Nov 2006 09:48:35 -0500
From: Neil Horman <nhorman@tuxdriver.com>
To: eli@dev.mellanox.co.il
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: UDP packets loss
Message-ID: <20061117144835.GB11786@hmsreliant.homelinux.net>
References: <60157.89.139.64.58.1163542548.squirrel@dev.mellanox.co.il> <18154.194.90.237.34.1163703097.squirrel@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18154.194.90.237.34.1163703097.squirrel@dev.mellanox.co.il>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2006 at 08:51:37PM +0200, eli@dev.mellanox.co.il wrote:
> > Hi,
> > I am running a client/server test app over IPOIB in which the client sends
> > a certain amount of data to the server. When the transmittion ends, the
> > server prints the bandwidth and how much data it received. I can see that
> > the server reports it received about 60% that the client sent. However,
> > when I look at the server's interface counters before and after the
> > transmittion, I see that it actually received all the data that the client
> > sent. This leads me to suspect that the networking layer somehow dropped
> > some of the data. One thing to not - the CPU is 100% busy at the receiver.
> > Could this be the reason (the machine I am using is 2 dual cores - 4
> > CPUs).
> 
> I still have the following argumet: the network and the network driver are
> capable of transffering data at a high rate and the networking stack is
> unable to keep the pace. If I used TCP probably TCP's flow control would
> eventually slow the whole thing to a rate such all parts can handle. But
> is there a way to overcome this situation and to avoid packets drop? If
> this would happen then TCP would work at higher rates as well?? Perhaps
> increase buffers sizes? Maybe the kernel is not designed to handle packets
> rate like IPOIB can generate?
> 
It sounds kind of like your looking for a protocol like SCTP.  SCTP is a bit
like a hybrid between TCP and UDP.  It provides for both a stream oriented
transport, and a sequential packet transport, which is like UDP, but with
sequence numbers that are visibile to the user space app, so in order delivery
can be guaranteed, and application controlled packet loss can be enabled.

Neil

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/
