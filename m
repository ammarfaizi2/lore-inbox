Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbUE0Lfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbUE0Lfu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 07:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbUE0Lfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 07:35:50 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:42756 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261939AbUE0Lfs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 07:35:48 -0400
Subject: Re: tvtime and the Linux 2.6 scheduler
From: Redeeman <lkml@metanurb.dk>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040523154859.GC22399@dumbterm.net>
References: <20040523154859.GC22399@dumbterm.net>
Content-Type: text/plain
Message-Id: <1085657741.10917.0.camel@redeeman.kaspersandberg.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 27 May 2004 13:35:41 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

using nicksched solves this, now tvtime only uses 1% again! yay!

On Sun, 2004-05-23 at 17:48, Billy Biggs wrote:
>   I am the author of tvtime, a TV application with advanced image
> processing algorithms.  Some users are complaining about poor
> performance under Linux 2.6, and I would like more information about how
> tvtime will be treated by the scheduler.  Here is an example of the
> intended usage:
> 
>   - Program running as root and SCHED_FIFO
>   - NTSC, input ~30 fps, each field processed for an output of ~60 fps
>   - CPU intensive processing, say 9 ms per field on my P3-733
>   - with a typical AGP card, the X driver takes 4 ms to draw
>   - Wait using /dev/rtc set to 1024 Hz
> 
>   for(;;)
>       9 ms : process frame
>       4 ms : draw frame
>       3 ms : wait until next field time using /dev/rtc
>       9 ms : process frame
>       4 ms : draw frame
>       3 ms : block on /dev/video0 for next frame
>      -----
>      33 ms : time per NTSC frame
> 
>   The theory is that Linux classifies this as a CPU hog regardless of
> its priority, and preempts tvtime with other processes.  Oswald
> Buddenhagen describes the effect as this:
> 
>   "[...] it starts up fine, but after a few seconds (when the scheduler
> gathered some stats) ... well, it looks funny: the scene goes roughly
> exponentially into slow motion, then there is a frame drop and the
> process starts over.  this behaviour can be observed at any priority,
> which is clearly against the claim "no normally priorized interactive
> process will preempt a highly priorized cpu-hog" that i've read
> somewhere.  the xserver priority does not change anything, either;"
> 
>   Avoiding root/SCHED_FIFO and using usleep() instead of /dev/rtc seems
> to exhibit the same behavior.
> 
>   Thoughts?
> 
>   -Billy
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Regards, Redeeman
redeeman@metanurb.dk

