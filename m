Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263169AbUEWQyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263169AbUEWQyh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 12:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbUEWQyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 12:54:36 -0400
Received: from mail022.syd.optusnet.com.au ([211.29.132.100]:47002 "EHLO
	mail022.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263169AbUEWQye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 12:54:34 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Billy Biggs <vektor@dumbterm.net>
Subject: Re: tvtime and the Linux 2.6 scheduler
Date: Mon, 24 May 2004 02:54:19 +1000
User-Agent: KMail/1.6.1
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040523154859.GC22399@dumbterm.net>
In-Reply-To: <20040523154859.GC22399@dumbterm.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405240254.20171.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Mon, 24 May 2004 01:48 am, Billy Biggs wrote:
>   I am the author of tvtime, a TV application with advanced image
> processing algorithms.  Some users are complaining about poor
> performance under Linux 2.6, and I would like more information about how
> tvtime will be treated by the scheduler.  Here is an example of the
> intended usage:
>
>   - Program running as root and SCHED_FIFO

snip

>      33 ms : time per NTSC frame

snip

The followup email from someone describing good performance may help us 
understand what's going on. Your example of poor performance is one when the 
cpu performance is marginal to get exactly 30 fps processed and on the 
screen. The cpu overhead in 2.6 is slightly higher than 2.4 so a borderline 
case may be just pushed over. 

A program running as sched_fifo it will preempt absolutely everything 
regardless of how it behaves. It sounds like it's giving X less cpu time to 
draw the frame each time until eventually the processing fails to capture the 
frame and then X smooths out again. I cant pretend to understand how your 
application blocks (as you say) between X and tvtime, but does tvtime not try 
to schedule until X has finished using up cpu or will it just run off the 
timer and preempt X away? You say changing priorities doesnt help, but I cant 
tell if you tried this: run the processing sched_normal at lower priority 
than X.

Con
