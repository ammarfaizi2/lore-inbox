Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbUCPFXj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 00:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262806AbUCPFXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 00:23:39 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:7203 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262784AbUCPFXg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 00:23:36 -0500
Date: Mon, 15 Mar 2004 21:22:56 -0800
From: Jeremy Higdon <jeremy@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: jbarnes@sgi.com, axboe@suse.de
Subject: Re: [PATCH] per-backing dev unplugging #2
Message-ID: <20040316052256.GA647970@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

| Hi,
| 
| Final version, unless something stupid pops up. Changes:
| 
| - Adapt to 2.6.4-mm1
| - Cleaned up the dm bits, much nicer with the lockless unplugging
|   (thanks Joe)
| - md and loop unplugging, stacked devices should unplug their targets.
|   Otherwise they'll end up waiting for the unplug timer, which sucks.
| - XFS fixed up, I hope. XFS folks still encouraged to look at this,
|   looks better this time around though (and works, I tested).
| - blk_run_* inlined in blkdev.h
| 
| Against 2.6.4-mm1 (note you need other attached patch to boot it).

I got a chance to try this.

It makes a huge improvement.

Prior to the last per-cpu patch, I was getting about 75000 to 80000
IOPS at 100% cpu usage.

With the per-cpu patch, that went up to 110000 IOPS at 100% CPU.

With this patch, I'm seeing 200000 IOPS at about 65% CPU usage.

So it makes a tremendous improvement in I/O scalability, dramatically
improving performance in small size I/O, high I/O count workloads.

My tests were on an 8 CPU x 1300 MHz Altix with 64 disks.

jeremy
