Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbVAYGR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbVAYGR4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 01:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbVAYGR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 01:17:56 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:12496 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261829AbVAYGRz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 01:17:55 -0500
Date: Tue, 25 Jan 2005 07:17:41 +0100
From: Andi Kleen <ak@suse.de>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Andi Kleen <ak@suse.de>, hch@infradead.org, linux-kernel@vger.kernel.org,
       chrisw@osdl.org, davem@davemloft.net
Subject: Re: [PATCH] move common compat ioctls to hash
Message-ID: <20050125061741.GA27013@wotan.suse.de>
References: <20050118072133.GB76018@muc.de> <20050118110432.GE23127@mellanox.co.il> <20050124202609.GA15057@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124202609.GA15057@mellanox.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 10:26:09PM +0200, Michael S. Tsirkin wrote:
> Hi!
> The new ioctl code in fs/compat.c can be streamlined a little
> using the compat hash instead of an explicit switch statement.
> 
> The attached patch is against 2.6.11-rc2-bk2.
> Andi, could you please comment? Does this make sence?

Problem is that when a compat_ioctl handler returns -EINVAL
instead of -ENOIOCTLCMD on unknown ioctl it won't check the common
ones.

I fear this mistake would be common, that is why I put in the switch.

-Andi
