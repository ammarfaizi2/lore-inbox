Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262121AbVG0RzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbVG0RzU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 13:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbVG0RzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 13:55:20 -0400
Received: from hera.kernel.org ([209.128.68.125]:65163 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262121AbVG0RzR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 13:55:17 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: 2.6.12.3 network slowdown?
Date: Wed, 27 Jul 2005 10:55:06 -0700
Organization: OSDL
Message-ID: <20050727105506.78b82aaa@dxpl.pdx.osdl.net>
References: <1122452018.772579.63900@g49g2000cwa.googlegroups.com>
	<20050727082020.C73AC5F7CA@attila.bofh.it>
	<42E7497B.5040202@highlandsun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1122486890 1496 10.8.0.74 (27 Jul 2005 17:54:50 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 27 Jul 2005 17:54:50 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 1.9.11 (GTK+ 2.6.7; x86_64-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2005 01:44:43 -0700
Howard Chu <hyc@highlandsun.com> wrote:

> I just recently compiled the 2.6.12.3 kernel for my x86_64 machine
> (Asus A8V motherboard); was previously running a SuSE-compiled 2.6.8
> kernel (SuSE 9.2 distro). I'm now seeing extremely slow throughput on
> the onboard Yukon (Marvell) ethernet interface, but only in certain
> conditions. Going back to the 2.6.8 kernel shows no slowdown.
> 
> I have a few machines connected to a Linksys 5 port 10/100 hub. There
> is also a Linksys WRT54G wireless router on this hub. When doing a
> raw ftp transfer of a large (600MB) file (using a Windows XP client
> to do a GET) with both machines plugged into the hub, I see transfer
> rates only as high as 1MB/sec initially, which quickly degrades to
> ~200KB/sec over a span of 20-30 seconds. Going the opposite
> direction, a PUT runs at a steady 7.5MB/sec.
> 
> If I unplug the Windows client and just connect via the wireless 
> network, I see GETs run a steady 2.8MB/sec and PUTs run a steady 
> 3.2MB/sec, which is about the same as I saw with the 2.6.8 kernel, so 
> that all appears normal. (But it's still odd, that adding one hop
> like this avoids the throughput degradation.)
> 
> I don't see any collisions or any other errors on the ifconfig 
> statistics, just a very slow transmit rate. Does anyone recognize
> this symptom? Any suggestions on tunables to tweak, etc.? (Please cc:
> me directly when replying, thanks.)
> 

There a couple of possibilities, one is driver differences. SUSE ships
the SysKonnect vendor driver vs the older version in 2.6.12, and the
TCP congestion and TSO code has changed since 2.6.8.

What is the output of ethtool (ethtool -i and ethtool -k)?
Perhaps one driver has checksum offload on and the other off?
Could you get a tcpdump capture of a slow transfer?
