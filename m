Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312938AbSHBXWD>; Fri, 2 Aug 2002 19:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316933AbSHBXWD>; Fri, 2 Aug 2002 19:22:03 -0400
Received: from pcp01179415pcs.strl1201.mi.comcast.net ([68.60.208.36]:15613
	"EHLO mythical") by vger.kernel.org with ESMTP id <S312938AbSHBXWD>;
	Fri, 2 Aug 2002 19:22:03 -0400
Date: Fri, 2 Aug 2002 19:25:01 -0400 (EDT)
From: Ryan Anderson <ryan@michonline.com>
To: Paul Menage <pmenage@ensim.com>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: manipulating sigmask from filesystems and drivers
In-Reply-To: <E17agg9-0001vK-00@pmenage-dt.ensim.com>
Message-ID: <Pine.LNX.4.10.10208021920210.579-100000@mythical.michonline.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Aug 2002, Paul Menage wrote:

> In article <0C01A29FBAE24448A792F5C68F5EA47D2D3E2B@nasdaq.ms.ensim.com>,
>  you write:
> >
> >With write(), you have to make a judgement call. Unlike read, a truncated
> >write _is_ visible outside the killed process. But exactly like read()
> >there _are_ system management reasons why you may really need to kill
> >writers. So the debatable point comes from whether you want to consider a
> >killing signal to be "exceptional enough" to warrant the partial write.
> >
> 
> How about a sysctl that lets the user specify the size threshold at
> which writes use a killable wait state rather than
> TASK_UNINTERRUPTIBLE? (Probably defaulting to never.)

/usr/include/linux/limits.h:#define PIPE_BUF        4096        /* #
bytes in atomic write to a pipe */

According to SUSv3, this is the maximum size that write is guaranteed to
be atomic for.

The minimum size this can be set to is 512.  I *think* this applies to
file io - but I'm not up to tracking all the definitions down.

So, you've already got the definitions in place, especially the size
limits.  It even reads like changing the behavior for larger writes
would be acceptable.

Just leave the small writes alone and I think you'll avoid causing large
problems for the majority of applications.

--
Ryan Anderson
  sometimes Pug Majere

