Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265732AbUARHzY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 02:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266252AbUARHzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 02:55:24 -0500
Received: from pcp05127596pcs.sanarb01.mi.comcast.net ([68.42.103.198]:60556
	"EHLO nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S265732AbUARHzX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 02:55:23 -0500
Subject: Re: [RFC] kill sleep_on
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: dwmw2@infradead.org,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       manfred@colorfullife.com, linux-kernel@vger.kernel.org
In-Reply-To: <20040117233618.094c9d22.akpm@osdl.org>
References: <40098251.2040009@colorfullife.com>
	 <1074367701.9965.2.camel@imladris.demon.co.uk>
	 <20040117201000.GL21151@parcelfarce.linux.theplanet.co.uk>
	 <1074383111.9965.4.camel@imladris.demon.co.uk>
	 <20040117224139.5585fb9c.akpm@osdl.org>
	 <1074409074.1569.12.camel@nidelv.trondhjem.org>
	 <20040117233618.094c9d22.akpm@osdl.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1074412497.1569.32.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 18 Jan 2004 02:54:57 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På su , 18/01/2004 klokka 02:36, skreiv Andrew Morton:
> That's quite a lot of contention on the lock_kernel() in remote_llseek().

The NFS use of the BKL may indeed end up leading to latencies within
llseek(), but what you just presented is more of an argument for
eliminating the use of the BKL within llseek()...

In general, though, the latencies involved with the actual RPC call are
so large that anything involving local locks will not tend to register
on the radar screen at all (your numbers for "default_idle" are an order
of magnitude larger than anything else).
This is certainly true of 100Mbit nets. However those latencies might
perhaps start to be measurable on GigE nets with fast servers...

Cheers,
  Trond
