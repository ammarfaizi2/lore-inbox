Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263318AbUJ2NVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263318AbUJ2NVq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 09:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263320AbUJ2NUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 09:20:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47490 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263318AbUJ2NQI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 09:16:08 -0400
Date: Fri, 29 Oct 2004 14:16:07 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: davem@davemloft.net, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/3] net: generic netdev_ioaddr
Message-ID: <20041029131607.GU24336@parcelfarce.linux.theplanet.co.uk>
References: <1099044244.9566.0.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099044244.9566.0.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 01:04:04PM +0300, Pekka Enberg wrote:
> Hi,
> 
> This patch introduces a generic netdev_ioaddr and converts natsemi and
> 8139too drivers to use it.
> 
> With the recent __iomem annotations, the network drivers need to either
> invent this wrapper (like natsemi has done) or duplicate the IO base
> address in their private data (similar to 8139too).  Therefore, lets
> make netdev_ioaddr generic before it is all over the place.

NAK.  ->base_addr casting is a Bad Idea(tm) and natsemi "solution" isn't
(thanks for spotting that crap in natsemi, though; will fix...)

Note that there is no such thing as "generic IO base address" - it _is_
private and in the best case current ->base_addr is a scratch register
probably used for something vaguely connected with some IO, but it's
really up to driver...
