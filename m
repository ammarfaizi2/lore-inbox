Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266242AbUALU7n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 15:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266240AbUALU7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 15:59:30 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:24982 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266242AbUALU7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 15:59:11 -0500
Date: Thu, 8 Jan 2004 22:42:41 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 NFS-server low to 0 performance
Message-ID: <20040108214240.GD467@openzaurus.ucw.cz>
References: <20040107174939.GK1882@matchmail.com> <Pine.LNX.4.44.0401071908320.1840-100000@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401071908320.1840-100000@poirot.grange>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > It is not just a problem of 2.6 with those specific network configurations
> > > - ftp / http / tftp transfers work fine. E.g. wget of the same file on the
> > > PXA with 2.6.0 from the PC1 with 2.4.21 over http takes about 2s. So, it
> > > is 2.6 + NFS.
> > >
> > > Is it fixed somewhere (2.6.1-rcx?), or what should I try / what further
> > > information is required?
> >
> > You will probably need to look at some tcpdump output to debug the problem...
> 
> Yep, just have done that - well, they differ... First obvious thing that I
> noticed is that 2.6 is trying to read bigger blocks (32K instead of 8K),
> but then - so far I cannot interpret what happens after the start of the

I've seen slow machine (386sx with ne1000) that could not receive 7 full-sized packets
back-to-back. You are sending 22 full packets back-to-back.
I'd expect some of them to be (almost deterministicaly) lost,
and no progress ever made.

In same scenario, TCP detects "congestion" and works mostly okay.
On ne1000 machine, TCP was still able to do 200KB/sec on
10Mbps network. Check if your slow machines are seeing all the packets you
send.
				Pavel

