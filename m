Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbWEIUjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWEIUjx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 16:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWEIUjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 16:39:53 -0400
Received: from hera.kernel.org ([140.211.167.34]:33186 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751152AbWEIUjx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 16:39:53 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [RFC PATCH 34/35] Add the Xen virtual network device driver.
Date: Tue, 9 May 2006 13:39:25 -0700
Organization: OSDL
Message-ID: <20060509133925.13890416@localhost.localdomain>
References: <20060509084945.373541000@sous-sol.org>
	<20060509085201.446830000@sous-sol.org>
	<20060509132556.76deaa91@localhost.localdomain>
	<6a1855ab01a195ac2a28a97c5f966f67@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1147207165 1857 10.8.0.54 (9 May 2006 20:39:25 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Tue, 9 May 2006 20:39:25 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.1.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 May 2006 21:26:11 +0100
Keir Fraser <Keir.Fraser@cl.cam.ac.uk> wrote:

> 
> On 9 May 2006, at 21:25, Stephen Hemminger wrote:
> 
> >> +	memcpy(netdev->dev_addr, info->mac, ETH_ALEN);
> >> +	network_connect(netdev);
> >> +	info->irq = bind_evtchn_to_irqhandler(
> >> +		info->evtchn, netif_int, SA_SAMPLE_RANDOM,
> >> netdev->name,
> >>
> >
> > This doesn't look like a real random entropy source. packets
> > arriving from another domain are easily timed.
> 
> Where should we get our entropy from in a VM environment? Leaving the 
> pool empty can cause processes to hang.
> 

You probably need to get entropy from dom0 and real hardware sources.
Could you piggyback on some other perodic polling/message passing to
push some entropy out?
