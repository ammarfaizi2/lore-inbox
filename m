Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261813AbVAMWxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbVAMWxN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 17:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261814AbVAMWuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 17:50:10 -0500
Received: from colin2.muc.de ([193.149.48.15]:43536 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261813AbVAMWsd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 17:48:33 -0500
Date: 13 Jan 2005 23:48:32 +0100
Date: Thu, 13 Jan 2005 23:48:32 +0100
From: Andi Kleen <ak@muc.de>
To: Ed L Cashin <ecashin@coraid.com>
Cc: Jens Axboe <axboe@suse.de>,
       Linux Kernel List <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
Subject: Re: [BUG] ATA over Ethernet __init calling __exit
Message-ID: <20050113224832.GA19673@muc.de>
References: <20050113000949.A7449@flint.arm.linux.org.uk> <20050113085035.GC2815@suse.de> <m1wtuh2kah.fsf@muc.de> <87is616oi2.fsf@coraid.com> <20050113215346.GB1504@muc.de> <87ekgp567u.fsf@coraid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ekgp567u.fsf@coraid.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 05:12:21PM -0500, Ed L Cashin wrote:

> It seems rash to make the change now, because there is no need for it.

It would be better to future proof the driver at least a bit.

> 
> For the skbuffs, we could use a mempool with GFP_NOIO allocation and
> then skb_get them before the network layer ever sees them.  We already
> keep track of the packets that we've sent out, so we'll just keep a
> pointer to the skbuffs.

That won't work because you don't know when the driver is done with it.

There is a callback, but it's already used by socket buffer management
(if you don't use a socket it may be usable) 


-Andi 
