Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263499AbSIWDgv>; Sun, 22 Sep 2002 23:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264743AbSIWDgv>; Sun, 22 Sep 2002 23:36:51 -0400
Received: from packet.digeo.com ([12.110.80.53]:23800 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263499AbSIWDgu>;
	Sun, 22 Sep 2002 23:36:50 -0400
Message-ID: <3D8E8D7F.810EF57F@digeo.com>
Date: Sun, 22 Sep 2002 20:41:51 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] gcc3.2 v 2.95.3 (contest and linux-2.5.38)
References: <1032750261.3d8e84b5486a9@kolivas.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Sep 2002 03:41:51.0695 (UTC) FILETIME=[273FB5F0:01C262B3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> 
> I performed contest benchmarks on kernel 2.5.38 when the kernel is compiled with
> gcc3.2 to gcc2.95.3
> 
> warning: The following benchmarks may be disturbing to some viewers:
> 
> No Load:
> Kernel                  Time            CPU
> 2.5.38                  68.25           99%
> 2.5.38-gcc32            103.03          99%
> 

Try gcc-2.91.66.  It might break the 45 second mark.

> IO Full Load:
> Kernel                  Time            CPU
> 2.5.38                  170.21          42%
> 2.5.38-gcc32            1405.25         8%

The streaming write is stalling gcc's read for long enough for gcc's
working set to be evicted.  And the working set cannot be reestablished
because the streaming write prevents it.  Meltdown.

I have fixed this.  Hang around.
