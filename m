Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbWHPW4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWHPW4E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 18:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWHPW4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 18:56:04 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:20678 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932320AbWHPW4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 18:56:01 -0400
Date: Wed, 16 Aug 2006 17:55:58 -0500
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Miller <davem@davemloft.net>, jeff@garzik.org,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, jklewis@us.ibm.com, Jens.Osterkamp@de.ibm.com,
       akpm@osdl.org
Subject: Re: [PATCH 1/2]: powerpc/cell spidernet bottom half
Message-ID: <20060816225558.GM20551@austin.ibm.com>
References: <44E34825.2020105@garzik.org> <44E38157.4070805@garzik.org> <20060816.134640.115912460.davem@davemloft.net> <200608162324.47235.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608162324.47235.arnd@arndb.de>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 11:24:46PM +0200, Arnd Bergmann wrote:
> 
> it only
> seems to be hard to make it go fast using any of them. 

Last round of measurements seemed linear for packet sizes between
60 and 600 bytes, suggesting that the hardware can handle a 
maximum of 120K descriptors/second, independent of packet size.
I don't know why this is.

> That may
> be the fault of strange locking rules 

My fault; a few months ago, we were in panic mode trying to get
the thing functioning reliably, and I put locks around anything
and everything.  This last patch removes those locks, and protects
only a few pointers (the incrementing of the head and the tail 
pointers, and the location ofthe low watermark) that actually 
needed protection. They need protection because the code can 
get called in various different ways.

> Cleaning up the TX queue only from ->poll() like all the others

I'll try this ... 

> sounds like the right approach to simplify the code.

Its not a big a driver. 'wc' says its 2.3 loc, which 
is 1/3 or 1/5 the size of tg3.c or the e1000*c files.

--linas
