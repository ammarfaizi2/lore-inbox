Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269346AbUJFSHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269346AbUJFSHy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 14:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269360AbUJFSHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 14:07:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:20900 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269346AbUJFSHa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 14:07:30 -0400
Date: Wed, 6 Oct 2004 11:06:45 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
cc: jgarzik@pobox.com, acme@conectiva.com.br, corey@world.std.com,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Raylink/WebGear testing - ray_cs.c iomem bug?
In-Reply-To: <20041006105453.5f7d1888.davem@davemloft.net>
Message-ID: <Pine.LNX.4.58.0410061102590.8290@ppc970.osdl.org>
References: <Pine.LNX.4.58.0410061032410.8290@ppc970.osdl.org>
 <20041006105453.5f7d1888.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Oct 2004, David S. Miller wrote:
> 
> In the spot where this occurs, it adds both CCS_BASE and
> 'rcsindex' to the sram base, and only when rcsindex >= NUMBER_OF_CCS.
> 
> NUMBER_OF_CCS is 64, and the difference between CCS_BASE and RCS_BASE
> is 0x400 so this really doesn't account for anything.

It does, though: as I noted in my second mail (after trying to figure it
out some more) the size of both ccs and rcs is 16 bytes, so when you
offset by 64, so the difference between RCS_BASE and CCS_BASE ends up 
being exactly "NUMBER_OF_CCS*sizeof(struct ccs/rcs)", which explains how 
the base is the same, and the _index_ ends up being the one that selects 
between the two.

> I can't see how you've changed the behavior, so it should work as well
> as it did before your changes.

Agreed. I've only removed a few casts, and cleaned up some of the 
accesses, so it _should_ work the way it did before.

Of course, I _should_ be handsome, so things clearly don't always work out 
the way they should. Testing would still be appreciated.

		Linus
