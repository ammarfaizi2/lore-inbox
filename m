Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263760AbTLTAh7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 19:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263762AbTLTAh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 19:37:59 -0500
Received: from port-212-202-159-243.reverse.qsc.de ([212.202.159.243]:38379
	"EHLO mail.onestepahead.de") by vger.kernel.org with ESMTP
	id S263760AbTLTAht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 19:37:49 -0500
Subject: Re: 2.6 vs 2.4 regression when running gnomemeeting
From: Christian Meder <chris@onestepahead.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3FE39603.9000501@cyberone.com.au>
References: <1071864709.1044.172.camel@localhost>
	 <20031219203227.GR31393@holomorphy.com>
	 <1071876632.1044.179.camel@localhost>  <3FE39603.9000501@cyberone.com.au>
Content-Type: text/plain
Message-Id: <1071880660.1044.194.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 20 Dec 2003 01:37:40 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-12-20 at 01:21, Nick Piggin wrote:
> Christian Meder wrote:
> 
> >On Fri, 2003-12-19 at 21:32, William Lee Irwin III wrote:
> >
> >>On Fri, Dec 19, 2003 at 09:11:50PM +0100, Christian Meder wrote:
> >>
> >>>I've got a longstanding regression in gnomemeeting usage when switching
> >>>between 2.4 and 2.6 kernels.
> >>>Phenomenon: 
> >>>Without load gnomemeeting VOIP connections are fine. As soon as some
> >>>load like a kernel compile is put on the laptop the gnomemeeting audio
> >>>stream is cut to pieces and gets unintelligible . On 2.4.2x I don't get
> >>>even the slightest distortion in the audio stream under load. I played
> >>>around with different nice levels with no success. The problem persisted
> >>>during the whole 2.6.0-test series no matter whether I used -mm kernels
> >>>or pristine Linus kernels. Even when nicing the kernel compile to +19
> >>>the distortions start right away. I tried Nick Piggin's scheduler which
> >>>fared slightly better after changing the nice level of gnomemeeting to
> >>>-10 but it's still a far cry from the 2.4.2x feeling without any
> >>>fiddling with nice values.
> >>>Any hints where to start looking are greatly appreciated.
> >>>
> >>Please instrument your workload with the following, and send logs of the
> >>output (preferably compressed) to me and possibly others:
> >>
> >>top b d 5
> >>vmstat 5
> >>while true; do cat /proc/vmstat; sleep 5; done
> >>while true; do cat /proc/meminfo; sleep 5; done
> >>
> >>A good way to log commands like this is:
> >>
> >>(command) > /home/foo.log.1 2>&1 &
> >>
> >>where parentheses surround the command in the actual shell input.
> >>
> >
> >Hi,
> >
> >I've attached the tarred output of a gnomemeeting run without load and
> >without distortions and another tarred output of a gnomemeeting run
> >while compiling a kernel with severe distortions in the audio stream.
> >
> 
> You're getting a lot fewer interrupts in the loaded case. Maybe its
> the sound card driver that has the regression from 2.4? It could be
> that 2.6 allows a smaller sound fragment size which is more stressful.
> 

Well I had the same problem with the OSS driver on 2.6. Now I use the
ALSA driver because I thought that could possibly improve things. The
ALSA driver is better indeed but it doesn't change this particular
phenomenon. Additionally I'd guess that the latest ALSA driver in 2.4
and 2.6 doesn't differ significantly and 2.4.2x with the latest ALSA
works great while 2.6 doesn't.


			Christian Meder

-- 
Christian Meder, email: chris@onestepahead.de
 
What's the railroad to me ?
I never go to see
Where it ends.
It fills a few hollows,
And makes banks for the swallows, 
It sets the sand a-blowing,
And the blackberries a-growing.
                      (Henry David Thoreau)
 




