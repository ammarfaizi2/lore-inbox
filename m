Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263552AbUCPIeq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 03:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263546AbUCPIeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 03:34:46 -0500
Received: from mail-09.iinet.net.au ([203.59.3.41]:27817 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263552AbUCPIeo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 03:34:44 -0500
Message-ID: <4056A062.6040203@cyberone.com.au>
Date: Tue, 16 Mar 2004 17:36:18 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jeremy Higdon <jeremy@sgi.com>
CC: linux-kernel@vger.kernel.org, jbarnes@sgi.com, axboe@suse.de
Subject: Re: [PATCH] per-backing dev unplugging #2
References: <20040316052256.GA647970@sgi.com>
In-Reply-To: <20040316052256.GA647970@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jeremy Higdon wrote:

>| Hi,
>| 
>| Final version, unless something stupid pops up. Changes:
>| 
>| - Adapt to 2.6.4-mm1
>| - Cleaned up the dm bits, much nicer with the lockless unplugging
>|   (thanks Joe)
>| - md and loop unplugging, stacked devices should unplug their targets.
>|   Otherwise they'll end up waiting for the unplug timer, which sucks.
>| - XFS fixed up, I hope. XFS folks still encouraged to look at this,
>|   looks better this time around though (and works, I tested).
>| - blk_run_* inlined in blkdev.h
>| 
>| Against 2.6.4-mm1 (note you need other attached patch to boot it).
>
>I got a chance to try this.
>
>It makes a huge improvement.
>
>Prior to the last per-cpu patch, I was getting about 75000 to 80000
>IOPS at 100% cpu usage.
>
>With the per-cpu patch, that went up to 110000 IOPS at 100% CPU.
>
>With this patch, I'm seeing 200000 IOPS at about 65% CPU usage.
>
>So it makes a tremendous improvement in I/O scalability, dramatically
>improving performance in small size I/O, high I/O count workloads.
>
>My tests were on an 8 CPU x 1300 MHz Altix with 64 disks.
>
>

Nice - so if you had enough IO capacity to saturate the CPUs it
might come close to a 4x improvement - and this sounds like one
of your baby systems?

I wonder why nobody's complained about this before?

