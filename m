Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVBVRmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVBVRmd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 12:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVBVRmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 12:42:32 -0500
Received: from fire.osdl.org ([65.172.181.4]:37336 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261202AbVBVRmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 12:42:21 -0500
Date: Tue, 22 Feb 2005 09:42:19 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: mlists@danielinux.net
Cc: "David S. Miller" <davem@davemloft.net>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, Carlo Caini <ccaini@deis.unibo.it>,
       Rosario Firrincieli <rfirrincieli@arces.unibo.it>
Subject: Re: [PATCH] TCP-Hybla proposal
Message-ID: <20050222094219.0a8efbe1@dxpl.pdx.osdl.net>
In-Reply-To: <200502221534.42948.mlists@danielinux.net>
References: <200502221534.42948.mlists@danielinux.net>
Organization: Open Source Development Lab
X-Mailer: Sylpheed-Claws 1.0.1 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2005 15:34:42 +0100
Daniele Lacamera <mlists@danielinux.net> wrote:

> Hi
> This is the official patch to implement TCP Hybla congestion avoidance.
> 
> - "In heterogeneous networks, TCP connections that incorporate a 
> terrestrial or satellite radio link are greatly disadvantaged with 
> respect to entirely wired connections, because of their longer round 
> trip times (RTTs). To cope with this problem, a new TCP proposal, the 
> TCP Hybla, is presented and discussed in the paper[1]. It stems from an 
> analytical evaluation of the congestion window dynamics in the TCP 
> standard versions (Tahoe, Reno, NewReno), which suggests the necessary 
> modifications to remove the performance dependence on RTT.[...]"[1]
> 
> [1]: Carlo Caini, Rosario Firrincieli, "TCP Hybla: a TCP enhancement for 
> heterogeneous networks", 
> International Journal of Satellite Communications and Networking
> Volume 22, Issue 5 , Pages 547 - 566. September 2004.

This looks interesting.

> Please note that this patch:
> - cleanly compiled against 2.6.11-rc4;
> 
> - reached very good results in terms of fairness and friendliness with 
> other TCP standards and proposals during tests;
> 
> - gives a throughput very close to maximum fair share when satellite 
> connections fight for bandwidth in a terrestrial bottleneck, and 
> improves their performance also in case of no congestion;
> 
> - acts exactly as newreno when minimum rtt estimated by the sender is 
> lower or equal to rtt0 (default=25 ms).
> 
> The protocol is obviously disabled by default and can be turned on by 
> switching its sysctl, as usual.

Probably the best long term solution is to make the protocol choice
be a property of the destination cache.

> As Mr.Yee-Ting Li pointed out in his last thread, the deployments of 
> these experimental protocols are too premature and they should be 
> switched OFF by default to prevent undesirable consequences to network 
> stability.
> 
> One last note: IMHO we really need a better way to select congestion 
> avoidance scheme between those available, instead of switching each one 
> on and off. I.e., we can't say how vegas and westwood perform when 
> switched on together, can we?

The protocol choices are mutually exclusive, if you walk through the code
(or do experiments), you find that that only one gets used.  As part of the
longer term plan, I would like to:
	- have one sysctl
	- choice by route and destination
	- union for fields in control block


Is there interest in setting up a semi official "-tcp" tree to hold these?
because it might not be of wide interest or stability to be ready for mainline
kernel.
