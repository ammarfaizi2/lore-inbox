Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263191AbUEWRUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263191AbUEWRUZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 13:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263188AbUEWRUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 13:20:25 -0400
Received: from fdd.com ([64.81.147.80]:61298 "EHLO FDD.COM")
	by vger.kernel.org with ESMTP id S263184AbUEWRUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 13:20:18 -0400
Date: Sun, 23 May 2004 12:20:13 -0500
From: Billy Biggs <vektor@dumbterm.net>
To: Con Kolivas <kernel@kolivas.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: tvtime and the Linux 2.6 scheduler
Message-ID: <20040523172013.GD22399@dumbterm.net>
References: <20040523154859.GC22399@dumbterm.net> <200405240254.20171.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405240254.20171.kernel@kolivas.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi Con, thanks for your reply.

Con Kolivas (kernel@kolivas.org):

> A program running as sched_fifo it will preempt absolutely everything
> regardless of how it behaves. It sounds like it's giving X less cpu
> time to draw the frame each time until eventually the processing fails
> to capture the frame and then X smooths out again. I cant pretend to
> understand how your application blocks (as you say) between X and
> tvtime, but does tvtime not try to schedule until X has finished using
> up cpu or will it just run off the timer and preempt X away? You say
> changing priorities doesnt help, but I cant tell if you tried this:
> run the processing sched_normal at lower priority than X.

  We call XvShmPutImage and then do an XSync, which will wait until X
sends a message indicating it has processed all outstanding requests.
The XvShmPutImage uploads the image to video memory immediately, so the
call to XSync blocks us until it is complete.  We are not preempting the
X server.

  I will get accurate information about the priorities of all processes
involved here.

  -Billy

