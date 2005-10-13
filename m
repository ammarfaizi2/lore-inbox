Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932543AbVJMXtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbVJMXtq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 19:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbVJMXtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 19:49:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59877 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751122AbVJMXtq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 19:49:46 -0400
Date: Thu, 13 Oct 2005 19:49:34 -0400
From: Alexander Viro <aviro@redhat.com>
To: torvalds@osdl.org
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: BLKSECTGET userland API breakage (2.4 and 2.6 incompatible)
Message-ID: <20051013234934.GB6711@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[that had started as "BLKSECTGET 32bit compat is broken"]

Situation:

all 2.4:      BLKSECTGET takes long * and is supported by several block drivers
bio-14-pre9:  Takes BLKSECTGET to drivers/block/blkpg.c, defining it for all
              block drivers *AND* making it take unsigned short *
2.5.1-pre2:   bio merge
all 2.[56] kernels since then: BLKSECTGET takes unsigned short *
32bit compat: unchanged since 2.4 and thus broken on 2.[56]
applications: we have seen ones using 2.6 ABI and getting buggered in
              32bit compat.  Most likely there are some using 2.4 ABI...

IMO the least painful variant is to switch 2.6 compat code to match
2.6 native (i.e. use COMPATIBLE_IOCTL()), leave 2.4 as-is and live
with the fact of userland ABI change between 2.4 and 2.6...

