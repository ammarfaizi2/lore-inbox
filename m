Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262585AbREOAIH>; Mon, 14 May 2001 20:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262588AbREOAH5>; Mon, 14 May 2001 20:07:57 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:46603 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S262585AbREOAHl>; Mon, 14 May 2001 20:07:41 -0400
Date: Mon, 14 May 2001 19:29:28 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Ben LaHaise <bcrl@redhat.com>
Cc: alan@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] v2.4.4-ac9 highmem deadlock
In-Reply-To: <Pine.LNX.4.33.0105141930270.11830-100000@toomuch.toronto.redhat.com>
Message-ID: <Pine.LNX.4.21.0105141925580.32493-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 May 2001, Ben LaHaise wrote:

> Hey folks,

Hi. 

> 
> The patch below consists of 3 seperate fixes for helping remove the
> deadlocks present in current kernels with respect to highmem systems.
> Each fix is to a seperate file, so please accept/reject as such.

<snip>

> The third patch (to vmscan.c) adds a SCHED_YIELD to the page launder code
> before starting a launder loop.  This one needs discussion, but what I'm
> attempting to accomplish is that when kswapd is cycling through
> page_launder repeatedly, bdflush or some other task submitting io via the
> bounce buffers needs to be given a chance to run and complete their io
> again.  Failure to do so limits the rate of progress under extremely high
> load when the vast majority of io will be transferred via bounce buffers.

Your patch may allow bdflush or some other task to submit IO if kswapd is
looping mad --- but it will not avoid kswapd from eating all the CPU
time, which is the _main_ problem. 

If we avoid kswapd from doing such a thing (which is what we should try to
fix in the first place), there is no need for your patch.


