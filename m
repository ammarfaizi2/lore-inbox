Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbVKJVGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbVKJVGR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 16:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbVKJVGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 16:06:17 -0500
Received: from hera.kernel.org ([140.211.167.34]:50856 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932125AbVKJVGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 16:06:16 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Ethernet bridge leaking memory
Date: Thu, 10 Nov 2005 13:06:13 -0800
Organization: OSDL
Message-ID: <20051110130613.2bb0c9be@dxpl.pdx.osdl.net>
References: <200511102113.28334.kostja@siefen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1131656773 29189 10.8.0.74 (10 Nov 2005 21:06:13 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Thu, 10 Nov 2005 21:06:13 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 1.9.15 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2005 21:13:27 +0100
Kostja Siefen <kostja@siefen.de> wrote:

> Hi,
> 
> I have a strange problem with ethernet bridging in 2.6.13 which leads to heavy 
> slab allocation until memory is completely filled up.
> 
> My setup:
> 
> HP nx7000 Laptop running Kernel 2.6.13
> - RTL 8139 network interface on board (module 8139too)
> - PC Card Wired LAN Network Interface (module pcnet_cs)
> 
> After modprobing bridge and calling
> 
> brctl addbr br0
> brctl addif br0 eth0 (RTL 8139)
> brctl addif br0 eth2 (PC Card Wired LAN)
> 
> the bridge is up and running and works like a charm. Sending some traffic (1 
> MB/s is enough) through that bridge leads to massive kernel memory 
> allocation. slabtop reports, that "skbuff_head_cache" and "size-2048" eat up 
> all the memory (256 MB). This looks like a memory leak to me.
> 
> Even unloading the network modules does not free any memory, a reboot is 
> required.
> 
> Any ideas? 
> 


Could you try identifying which flow or driver is leaking?

	eth0 ---> eth2
	eth0 ---> br0
	eth2 ---> br0
	eth2 ---> eth0
	br0  ---> eth0
	br0  ---> eth2

Also try without bridge, it may just be a driver leak



-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
