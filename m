Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbVDLBE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbVDLBE5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 21:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbVDLBE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 21:04:57 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:30891 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261991AbVDLBEx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 21:04:53 -0400
Subject: Re: bdflush/rpciod high CPU utilization, profile does not make
	sense
From: Greg Banks <gnb@melbourne.sgi.com>
To: Jakob Oestergaard <jakob@unthought.net>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050411154211.GG13369@unthought.net>
References: <20050407153848.GN347@unthought.net>
	 <1112890671.10366.44.camel@lade.trondhjem.org>
	 <20050409213549.GW347@unthought.net>
	 <1113083552.11982.17.camel@lade.trondhjem.org>
	 <20050411074806.GX347@unthought.net>
	 <1113222939.14281.17.camel@lade.trondhjem.org>
	 <20050411134703.GC13369@unthought.net>
	 <1113230125.9962.7.camel@lade.trondhjem.org>
	 <20050411144127.GE13369@unthought.net>
	 <1113232905.9962.15.camel@lade.trondhjem.org>
	 <20050411154211.GG13369@unthought.net>
Content-Type: text/plain
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1113267809.1956.242.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 12 Apr 2005 11:03:29 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-12 at 01:42, Jakob Oestergaard wrote:
> Yes, as far as I know - the Broadcom Tigeon3 driver does not have the
> option of enabling/disabling RX polling (if we agree that is what we're
> talking about), but looking in tg3.c it seems that it *always*
> unconditionally uses NAPI...

I've whined and moaned about this in the past, but for all its
faults NAPI on tg3 doesn't lose packets.  It does cause a huge
increase in irq cpu time on multiple fast CPUs.  What irq rate
are you seeing?

I did once post a patch to make NAPI for tg3 selectable at
configure time.
http://marc.theaimsgroup.com/?l=linux-netdev&m=107183822710263&w=2

> No dropped packets... I wonder if the tg3 driver is being completely
> honest about this...

At one point it wasn't, since this patch it is:
http://marc.theaimsgroup.com/?l=linux-netdev&m=108433829603319&w=2

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


