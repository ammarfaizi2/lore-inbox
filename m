Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263035AbTDRPaU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 11:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263104AbTDRPaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 11:30:19 -0400
Received: from isis.cs3-inc.com ([207.224.119.73]:24059 "EHLO isis.cs3-inc.com")
	by vger.kernel.org with ESMTP id S263035AbTDRPaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 11:30:18 -0400
From: don-linux@isis.cs3-inc.com (Don Cohen)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16032.7069.454420.811252@isis.cs3-inc.com>
Date: Fri, 18 Apr 2003 08:37:01 -0700
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: proposed optimization for network drivers
In-Reply-To: <20030418.013640.28803567.davem@redhat.com>
References: <200304170656.h3H6ujA28940@isis.cs3-inc.com>
	<20030418.013640.28803567.davem@redhat.com>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In part I agree.  I would have preferred to make my change in one
place instead of one driver at a time.  On the other hand, it seems to
me that some of these details are already spread around all the
drivers.  For instance, why does every driver have to call
eth_type_trans?  Could that be delayed for netif_rx ?

I do think it's reasonable for a driver to test whether the upper
layers are ready to process another packet.  I suggest that this 
test be encapsulated into a new function that can be changed at the
cost of only recompiling all the drivers.

David S. Miller writes:
 > 
 > What is we change the congestion implementation?  Then we'll
 > have to edit every single driver.  I don't think that's very
 > maintainable.
 > 
 > The whole idea is to abstract things out as far as possible so that
 > the device drivers are totally agnostic about the details of the
 > generic network queueing implementation.
 > 
 > I mean, it's an interesting idea, but it exposes details that
 > should not be exposed.
