Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264093AbTEaApe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 20:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264094AbTEaApe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 20:45:34 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:18174 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S264093AbTEaApd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 20:45:33 -0400
Subject: Re: [PATCH][CFT] new IO scheduler for 2.4.20
From: Robert Love <rml@tech9.net>
To: Neil Schemenauer <nas@python.ca>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       akpm@digeo.com
In-Reply-To: <20030531005247.GA646@glacier.arctrix.com>
References: <20030530220923.GA404@glacier.arctrix.com>
	 <200305310940.41780.kernel@kolivas.org>
	 <20030531005247.GA646@glacier.arctrix.com>
Content-Type: text/plain
Message-Id: <1054317501.15356.2183.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (1.3.92-1) (Preview Release)
Date: 30 May 2003 17:58:21 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-05-31 at 00:52, Neil Schemenauer wrote:

> I didn't change the size of the request queue.  I can't find where that
> gets set in 2.4.20. :-(

in drivers/block/ll_rw_blk.c :: blk_init_free_list()

I think the main reason (aside from memory consumption) 2.4 has such
small queues is to minimize read latency. If your patch goes off fixes
that, you can probably get away with larger queues, which will help in
merging. But then you definitely want to look into always merging reads,
like Andrew does.

A maximum of ~1000 request entries seems nice if you really give a boost
to reads otherwise.

	Robert Love

