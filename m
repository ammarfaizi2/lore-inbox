Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030396AbWGHVSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030396AbWGHVSr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 17:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030395AbWGHVSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 17:18:46 -0400
Received: from relay01.pair.com ([209.68.5.15]:33037 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S1030398AbWGHVSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 17:18:46 -0400
X-pair-Authenticated: 71.197.50.189
From: Chase Venters <chase.venters@clientec.com>
To: Ask List <askthelist@gmail.com>
Subject: Re: Runnable threads on run queue
Date: Sat, 8 Jul 2006 16:18:18 -0500
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <loom.20060708T220409-206@post.gmane.org>
In-Reply-To: <loom.20060708T220409-206@post.gmane.org>
Organization: Clientec, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607081618.42093.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 July 2006 15:18, Ask List wrote:
> Have an issue maybe someone on this list can help with.
>
> At times of very high load the number of processes on the run queue drops
> to 0 then jumps really high and then drops to 0 and back and forth. It
> seems to last 10 seconds or so. If you look at this vmstat you can see an
> example of what I mean. Now im not a linux kernel expert but i am thinking
> it has something to do with the scheduling algorithm and locking of the run
> queue. For this particular application I need all available threads to be
> processed as fast as possible. Is there a way for me to elimnate this
> behavior or at least minimize the window in which there are no threads on
> the run queue? Is there a sysctl parameter I can use?

If there's a runnable task on the system, the run queue should never empty 
except inside schedule(). The scheduler should then swap expired and active.

First question - what kernel are you running? Is it stock?

Second question - what's the application? Are you sure your threads just 
aren't falling into interruptible sleep due to an app bug of some sort? Are 
you observing misbehavior in the application (long pauses) or just in the 
reporting?

Thanks,
Chase
