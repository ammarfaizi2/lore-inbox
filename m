Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbUDIACC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 20:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbUDIACC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 20:02:02 -0400
Received: from marasystems.com ([213.150.153.194]:16549 "EHLO
	filer.marasystems.com") by vger.kernel.org with ESMTP
	id S262136AbUDIAB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 20:01:56 -0400
Date: Fri, 9 Apr 2004 02:01:25 +0200 (CEST)
From: Henrik Nordstrom <hno@marasystems.com>
X-X-Sender: henrik@filer.marasystems.com
To: "K.Anantha Kiran" <ananth@cse.iitk.ac.in>
cc: linux-kernel@vger.kernel.org, <linux-net@vger.kernel.org>
Subject: Re: Can i use dev_queue_xmit()
In-Reply-To: <Pine.LNX.4.44.0404090039460.3687-200000@csews112.cse.iitk.ac.in>
Message-ID: <Pine.LNX.4.44.0404090150510.14014-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Apr 2004, K.Anantha Kiran wrote:

> This module is working fine for less rate of traffic(< 200 Mbps) , But 
> same module is dropping some of the packets(4 lakhs out of 10 lakhs)  for 
> highier speeds(> 200Mbps).Function  *dev_queue_xmit()* in the kernel 
> module, is returning NET_XMIT_DROP for dropped packets.This is due to 
> the function call *q->enqueue(skb,q)* in dev_queue_xmit().What might be 
> the reason for that return value.

The transmit queue dicipline for the device is full and throwing away 
packets.

You need to give the device some breathing time to catch up on processing
the already queued packets, or make sure the device transmit queues are
sufficiently large for the packet bursts you are generating.

Regards
Henrik


