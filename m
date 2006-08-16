Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWHPXsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWHPXsn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 19:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWHPXsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 19:48:43 -0400
Received: from gate.crashing.org ([63.228.1.57]:22968 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932133AbWHPXsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 19:48:42 -0400
Subject: Re: [PATCH 2/4]: powerpc/cell spidernet low watermark patch.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, Jens Osterkamp <Jens.Osterkamp@de.ibm.com>,
       James K Lewis <jklewis@us.ibm.com>, Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <20060811170813.GJ10638@austin.ibm.com>
References: <20060811170337.GH10638@austin.ibm.com>
	 <20060811170813.GJ10638@austin.ibm.com>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 01:43:40 +0200
Message-Id: <1155771820.11312.116.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-11 at 12:08 -0500, Linas Vepstas wrote:
> 
> Implement basic low-watermark support for the transmit queue.
> 
> The basic idea of a low-watermark interrupt is as follows.
> The device driver queues up a bunch of packets for the hardware
> to transmit, and then kicks he hardware to get it started.
> As the hardware drains the queue of pending, untransmitted 
> packets, the device driver will want to know when the queue
> is almost empty, so that it can queue some more packets.
> 
> This is accomplished by setting the DESCR_TXDESFLG flag in
> one of the packets. When the hardware sees this flag, it will 
> interrupt the device driver. Because this flag is on a fixed
> packet, rather than at  fixed location in the queue, the
> code below needs to move the flag as more packets are
> queued up. This implementation attempts to keep te flag 
> at about 3/4's of the way into the queue.
> 
> This patch boosts driver performance from about 
> 300-400Mbps for 1500 byte packets, to about 710-740Mbps.

Sounds good (without actually looking at the code though :), that was a
long required improvement to that driver. Also, we should probably look
into using NAPI polling for tx completion queue as well, no ?

Cheers,
Ben.


