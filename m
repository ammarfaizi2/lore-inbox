Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264934AbTLKNQP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 08:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264941AbTLKNQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 08:16:14 -0500
Received: from watson.far.bakerst.org ([209.167.125.194]:24960 "EHLO
	moran.bakerst.org") by vger.kernel.org with ESMTP id S264934AbTLKNQL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 08:16:11 -0500
Subject: Re: 2.4.23 masquerading broken? key.oif = 0;
From: Neal Stephenson <neal@bakerst.org>
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0312101056320.27704@tux.rsn.bth.se>
References: <1071021069.16543.14.camel@moran.bakerst.org>
	 <Pine.LNX.4.58.0312101056320.27704@tux.rsn.bth.se>
Content-Type: text/plain
Organization: Very Little
Message-Id: <1071148569.6185.10.camel@moran.bakerst.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 11 Dec 2003 08:16:09 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately this did not work it produces the same effect. The changes
do work fine in 2.4.22-ac4, so the changes do work and make sense, don't
know why i didn't do it that way the first time.

Neal

On Wed, 2003-12-10 at 05:04, Martin Josefsson wrote:
> On Tue, 9 Dec 2003, Neal Stephenson wrote:
> 
> > iptables -t mangle -A PREROUTING --protocol tcp --destination-port 80 -j
> > MARK --set-mark 0x932
> > iptables -t nat -A POSTROUTING -o ppp0 -j MASQUERADE
> >
> > ip rule add pri 424 iif eth0 fwmark 0x932 table symp
> >
> > 	and this is what shows up in dmesg
> >
> > MASQUERADE: Route sent us somewhere else.
> >
> > 	Any suggestions appreciated,
> 
> Try adding "-i eth0" to the mangle/PREROUTING rule
> and remove "iif eth0" in the iproute rule.
> 
> I think the problem is that when the packet is routed it follows the
> iproute rule and goes to the "symp" table.
> But when ipt_MASQUERADE.c does another lookup to get the local
> source-address of the route that this packet will match we don't have the
> input-interface anymore, and thus matches another rule/route. So change
> the fwmark to include the input interface.
> 
> This is just a theory, I know too little about your routingtables to say
> anything more specific.
> 
> (The earlier behaviour was incorrect, ipt_MASQUERADE.c ignored
> policy-routing which broke things. Now it should be a lot more sane, but
> does unexpected things in some cases, like yours :)
> 
> /Martin

