Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752104AbWCJAKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104AbWCJAKT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752106AbWCJAKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:10:18 -0500
Received: from [194.90.237.34] ([194.90.237.34]:17721 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S1752104AbWCJAKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:10:17 -0500
Date: Fri, 10 Mar 2006 02:10:31 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: "David S. Miller" <davem@davemloft.net>
Cc: rdreier@cisco.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org, shemminger@osdl.org
Subject: Re: TSO and IPoIB performance degradation
Message-ID: <20060310001031.GA19040@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <adaacc1raz9.fsf@cisco.com> <20060307.172336.107863253.davem@davemloft.net> <20060308125311.GE17618@mellanox.co.il> <20060309.154819.104282952.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060309.154819.104282952.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 10 Mar 2006 00:12:39.0578 (UTC) FILETIME=[57BEA7A0:01C643D7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David S. Miller <davem@davemloft.net>:
>    Description
>       To improve efficiency (both computer and network) a data receiver
>       may refrain from sending an ACK for each incoming segment,
>       according to [RFC1122].  However, an ACK should not be delayed an
>       inordinate amount of time.  Specifically, ACKs SHOULD be sent for
>       every second full-sized segment that arrives.  If a second full-
>       sized segment does not arrive within a given timeout (of no more
>       than 0.5 seconds), an ACK should be transmitted, according to
>       [RFC1122].  A TCP receiver which does not generate an ACK for
>       every second full-sized segment exhibits a "Stretch ACK
>       Violation".

Thanks very much for the info!

So the longest we can delay, according to this spec, is until we have two full
sized segments.

But with the change we are discussing, could an ack now be sent even sooner than
we have at least two full sized segments?  Or does __tcp_ack_snd_check delay
until we have at least two full sized segments? David, could you explain please?

-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies
