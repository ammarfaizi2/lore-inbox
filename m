Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265352AbRFVHHi>; Fri, 22 Jun 2001 03:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265355AbRFVHH3>; Fri, 22 Jun 2001 03:07:29 -0400
Received: from www.wen-online.de ([212.223.88.39]:15 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S265352AbRFVHHV>;
	Fri, 22 Jun 2001 03:07:21 -0400
Date: Fri, 22 Jun 2001 09:06:42 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Tom Vier <tmv5@home.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.5-ac17
In-Reply-To: <20010621222557.A553@zero>
Message-ID: <Pine.LNX.4.33.0106220722450.535-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2001, Tom Vier wrote:

> i having some strange vm behavour with -ac17 that didn't happen with -ac14
> (i haven't tried 15 or 16). it starts swapping even when i have hundreds of
> megs of free ram. [...]
>
> vmstat:
>    procs                      memory    swap          io     system         cpu
>  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
>  1  0  0   2864 408488   2488  67080   0   0   216    28 1052   470  83   4  13

Hi,

It's not actually swapping unless you see IO (si/so).  It's allocating
swap space, but won't send pages out to disk unless there's demand. One
benefit of this early allocation is that idle pages will be identified
prior to demand, and will be moved out of the way sooner.  Watch as
memory demand rises, and you should see these pages migrating to disk
and staying there.. buys you more working space.

	-Mike

