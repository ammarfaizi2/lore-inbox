Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267287AbSKPQxR>; Sat, 16 Nov 2002 11:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267290AbSKPQxR>; Sat, 16 Nov 2002 11:53:17 -0500
Received: from [195.223.140.107] ([195.223.140.107]:46993 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267287AbSKPQxR>;
	Sat, 16 Nov 2002 11:53:17 -0500
Date: Sat, 16 Nov 2002 17:59:56 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, Con Kolivas <conman@kolivas.net>
Subject: Re: 2.[45] fixes for design locking bug in wait_on_page/wait_on_buffer/get_request_wait
Message-ID: <20021116165956.GF31697@dualathlon.random>
References: <200211161657.51357.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211161657.51357.m.c.p@wolk-project.de>
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 16, 2002 at 05:24:17PM +0100, Marc-Christian Petersen wrote:
> Hi Andrea,
> 
> I've applied your patch to 2.4.19 final and 2.4.20 final and those "pausings" 
> still exists when I do a full kernel tree copy with "cp -a linux-2.4.19 
> linux-2.4.20". When I am in a screen session and try to do a Ctrl-A-C to 
> create a new screen session it comes up within 3-5 seconds ... If I want to 
> switch to another session with Ctrl-A-N it sometimes happens fast and 
> sometimes within 3-5 seconds ... I've put above in a "while true; do ...; 
> done" loop. There is nothing else running or eating CPU and also nothing else 
> eating i/o. This does not happen with virgin 2.4.18.

Your pausing problem have little to do with the pausing fix, the problem
for you is the read latency, you're not triggering the race condition
fixed by the pausing fix so it can't make differences. One of the
foundamental obstacles to the read latency is the size of the I/O queue,
factor that is workarounded by the read-latency patch that basically
bypasses the size of the queue hiding the problem and in turn can't fix
the write latency with O_SYNC and the read latency during true read aio etc...

Andrea
