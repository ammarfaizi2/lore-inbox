Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750979AbWEITEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbWEITEx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 15:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWEITEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 15:04:53 -0400
Received: from hera.kernel.org ([140.211.167.34]:14732 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750829AbWEITEx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 15:04:53 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [openib-general] Re: [PATCH 07/16] ehca: interrupt handling
 routines
Date: Tue, 9 May 2006 12:04:21 -0700
Organization: OSDL
Message-ID: <20060509120421.6ac3f15c@localhost.localdomain>
References: <4450A196.2050901@de.ibm.com>
	<adaejz9o4vh.fsf@cisco.com>
	<445B4DA9.9040601@de.ibm.com>
	<adafyjomsrd.fsf@cisco.com>
	<44608C90.30909@de.ibm.com>
	<adalktbcgl1.fsf@cisco.com>
	<20060509164919.GC5063@mellanox.co.il>
	<40FCD6B6-9135-43C1-8974-E9070475DB78@schihei.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1147201456 1166 10.8.0.54 (9 May 2006 19:04:16 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Tue, 9 May 2006 19:04:16 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.1.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 May 2006 20:57:01 +0200
Heiko J Schick <info@schihei.de> wrote:

> On 09.05.2006, at 18:49, Michael S. Tsirkin wrote:
> 
> >> The trivial way to do it would be to use the same idea as the current
> >> ehca driver: just create a thread for receive CQ events and a thread
> >> for send CQ events, and defer CQ polling into those two threads.
> >
> > For RX, isn't this basically what NAPI is doing?
> > Only NAPI seems better, avoiding interrupts completely and avoiding  
> > latency hit
> > by only getting triggered on high load ...
> 
> Does NAPI schedules CQ callbacks to different CPUs or stays the callback
> (handling of data, etc.) on the same CPU where the interrupt came in?
> 

NAPI runs callback on same cpu that called netif_rx_schedule. 
This has benefit of cache location and reduces locking overhead.
