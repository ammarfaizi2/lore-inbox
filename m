Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265139AbUF1T0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265139AbUF1T0P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 15:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265140AbUF1T0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 15:26:15 -0400
Received: from mail.enyo.de ([212.9.189.167]:35594 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S265139AbUF1T0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 15:26:13 -0400
To: Willy Tarreau <willy@w.ods.org>
Cc: Miquel van Smoorenburg <miquels@cistron.nl>, linux-kernel@vger.kernel.org
Subject: Re: TCP-RST Vulnerability - Doubt
References: <40DC9B00@webster.usu.edu>
	<20040625150532.1a6d6e60.davem@redhat.com>
	<cbp62t$a38$1@news.cistron.nl>
	<20040628183709.GL29808@alpha.home.local>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Mon, 28 Jun 2004 21:26:07 +0200
In-Reply-To: <20040628183709.GL29808@alpha.home.local> (Willy Tarreau's
 message of "Mon, 28 Jun 2004 20:37:09 +0200")
Message-ID: <87vfhbjxgw.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Willy Tarreau:

> On Mon, Jun 28, 2004 at 01:22:37PM +0000, Miquel van Smoorenburg wrote:
>> 
>> MD5 protection on BGP sessions isn't very common yet.
>
> The Cisco routers we deployed 3.5 years ago were already configured with MD5
> enabled on BGP, this was on IOS 12.0 at this time. And I guess that Cisco
> still has a good share amongst the BGP setups.

Software deployed /= configured & enabled.

One of the main problems with the TCP MD5 option is that it requires a
password which has to be negotiated by the peers.  This adds a
non-trivial management burdern.

> MD5 is not that much expensive. I even wonder if all those new routers
> with VPN hardware acceleration, MD5 could not be computed in hardware
> at nearly no cost.

If the packet is still handled by a real CPU (which is very likely the
case given the complexity of the protocols involved), it will still
overload.

> But the real problem is that the provider should do the
> anti-spoofing himself and not accept BGP packets from the wrong NIC
> ! And it's relatively easy to show them where they're bad.

In this case, the anti-spoofing has to happen at the other side, to
protect you.  There is an anomaly in Cisco ACLs you could exploit to
implement this without too much management overhead, *but* filtering
on core routers still problematic.

However, experience tells us that there is little incentive for others
to invest some work to protect you, and that it doesn't happen in
general. 8-(
