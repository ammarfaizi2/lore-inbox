Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280730AbRKBQt5>; Fri, 2 Nov 2001 11:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280731AbRKBQtr>; Fri, 2 Nov 2001 11:49:47 -0500
Received: from lilly.ping.de ([62.72.90.2]:61202 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id <S280730AbRKBQtn>;
	Fri, 2 Nov 2001 11:49:43 -0500
Date: 2 Nov 2001 17:48:35 +0100
Message-ID: <20011102174835.B479@planetzork.spacenet>
From: jogi@planetzork.ping.de
To: "Linus Torvalds" <torvalds@transmeta.com>
Cc: "Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.14-pre6
In-Reply-To: <Pine.LNX.4.33.0110302349550.31996-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.33.0110302349550.31996-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Oct 31, 2001 at 12:00:00AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2001 at 12:00:00AM -0800, Linus Torvalds wrote:
> 
> Incredibly, I didn't get a _single_ bugreport about the fact that I had
> forgotten to change the version number in pre5. Usually that's everybody's
> favourite bug.. Is everybody asleep on the lists?

I noticed but I thought everybody else would complain :-)

[...]

> The MM has calmed down, but the OOM killer didn't use to work. Now it
> does, with heurstics that are so incredibly simple that it's almost
> embarrassing.
> 
> And I dare anybody to break those OOM heuristics - either by not
> triggering when they should, or by triggering too early. You'll get an
> honourable mention if you can break them and tell me how ("Honourable
> mention"? Yeah, I'm cheap. What else is new?)
> 
> In fact, I'd _really_ like to know of any VM loads that show bad
> behaviour. If you have a pet peeve about the VM, now is the time to speak
> up. Because otherwise I think I'm done.

I did my usual kernel compile testings and here are the resuls:

                    j25       j50       j75      j100

2.4.13-pre5aa1:   5:02.63   5:09.18   5:26.27   5:34.36
2.4.13-pre5aa1:   4:58.80   5:12.30   5:26.23   5:32.14
2.4.13-pre5aa1:   4:57.66   5:11.29   5:45.90   6:03.53
2.4.13-pre5aa1:   4:58.39   5:13.10   5:29.32   5:44.49
2.4.13-pre5aa1:   4:57.93   5:09.76   5:24.76   5:26.79

2.4.14-pre6:      4:58.88   5:16.68   5:45.93   7:16.56
2.4.14-pre6:      4:55.72   5:34.65   5:57.94   6:50.58
2.4.14-pre6:      4:59.46   5:16.88   6:25.83   6:51.43
2.4.14-pre6:      4:56.38   5:18.88   6:15.97   6:31.72
2.4.14-pre6:      4:55.79   5:17.47   6:00.23   6:44.85

2.4.14-pre7:      4:56.39   5:22.84   6:09.05   9:56.59
2.4.14-pre7:      4:56.55   5:25.15   7:01.37   7:03.74
2.4.14-pre7:      4:59.44   5:15.10   6:06.78   12:51.39*
2.4.14-pre7:      4:58.07   5:30.55   6:15.37      *
2.4.14-pre7:      4:58.17   5:26.80   6:41.44      *


The last three of the runs of make -j100 with -pre7 failed since some
processes (portmap and cc1) were killed. So the oom killer seems to
kill (in case of portmap) the wrong processes and might trigger a little
too early. I have no data about the swap / mem usage at that time since
the script runs unattended.

Otherwise -pre5aa1 still seems to be the fastest kernel *in this test*.

I have not checked about the interactivity issues so this might be a
*feature*.


Regards,

   Jogi

-- 

Well, yeah ... I suppose there's no point in getting greedy, is there?

    << Calvin & Hobbes >>
