Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbUKOMEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbUKOMEj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 07:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbUKOMEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 07:04:39 -0500
Received: from verein.lst.de ([213.95.11.210]:21377 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261586AbUKOMES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 07:04:18 -0500
Date: Mon, 15 Nov 2004 13:04:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andries.Brouwer@cwi.nl
Cc: akpm@osdl.org, hch@lst.de, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: [PATCH] appletalk Makefile
Message-ID: <20041115120409.GA17703@lst.de>
References: <200411151158.iAFBwi613920@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411151158.iAFBwi613920@apps.cwi.nl>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2004 at 12:58:44PM +0100, Andries.Brouwer@cwi.nl wrote:
> There is no dev.c in net/appletalk.

Dave forgot to bk add it when I sent him the patch.  Here's what
should be dev.c:

------------ snip ------------
/*
 * Moved here from drivers/net/net_init.c, which is:
 *	Written 1993,1994,1995 by Donald Becker.
 */

#include <linux/errno.h>
#include <linux/module.h>
#include <linux/netdevice.h>
#include <linux/if_arp.h>
#include <linux/if_ltalk.h>

static int ltalk_change_mtu(struct net_device *dev, int mtu)
{
	return -EINVAL;
}

static int ltalk_mac_addr(struct net_device *dev, void *addr)
{	
	return -EINVAL;
}

void ltalk_setup(struct net_device *dev)
{
	dev->change_mtu		= ltalk_change_mtu;
	dev->hard_header	= NULL;
	dev->rebuild_header 	= NULL;
	dev->set_mac_address 	= ltalk_mac_addr;
	dev->hard_header_cache	= NULL;
	dev->header_cache_update= NULL;

	dev->type		= ARPHRD_LOCALTLK;
	dev->hard_header_len 	= LTALK_HLEN;
	dev->mtu		= LTALK_MTU;
	dev->addr_len		= LTALK_ALEN;
	dev->tx_queue_len	= 10;	
	
	dev->broadcast[0]	= 0xFF;

	dev->flags		= IFF_BROADCAST|IFF_MULTICAST|IFF_NOARP;
}
EXPORT_SYMBOL(ltalk_setup);
