Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264507AbRFJIis>; Sun, 10 Jun 2001 04:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264508AbRFJIii>; Sun, 10 Jun 2001 04:38:38 -0400
Received: from beasley.gator.com ([63.197.87.202]:47633 "EHLO
	beasley.gator.com") by vger.kernel.org with ESMTP
	id <S264507AbRFJIiX>; Sun, 10 Jun 2001 04:38:23 -0400
From: "George Bonser" <george@gator.com>
To: "Rik van Riel" <riel@conectiva.com.br>, <linux-mm@kvack.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] 2.4.6-pre2 page_launder() improvements
Date: Sun, 10 Jun 2001 01:38:01 -0700
Message-ID: <CHEKKPICCNOGICGMDODJMEJLDEAA.george@gator.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <Pine.LNX.4.33.0106100128100.4239-100000@duckman.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> This patch has given excellent results on my laptop and my
> workstation here and seems to improve kernel behaviour in tests
> quite a bit. I can play mp3's unbuffered during moderate write
> loads or moderately heavy IO ;)
>
> YMMV, please test it. If it works great for everybody I'd like
> to get this improvement merged into the next -pre kernel.

For the test I ran it through, it was about the same as 2.4.6-pre2 vanilla.

The test I did can be simulated easilly enough. Apache with keepalives off.
about 50 connections/second pulling a 10K file. Have half a gig of swap.
Told the machine on boot that it had 64MB of RAM. Prestarted 250 apache
children. Once everything settles down, I was about 10meg into swap and
everything is running smoothly. So far so good. Now I figured I would push
it a little more into swap so this being a production server, I can't really
tell the world to make more connections so I do the next best thing and turn
keepalives on with a timeout of 2 seconds figuring this would increase the
number of apache children alive and push me deeper into swap. Restarted
apache and within about 5 seconds the machine stopped responding to console
input. top would not update the screen but the machine would respond to
pings.

I took it out of the load balancer and regained control in seconds. The 15
minute load average showed somewhere over 150 with a bazillion apache
processes. Even top -q would not update when I put it back into the
balancer. The load average and number of processes started to increase until
I got to some point where it would just stop providing output. Again,
control returned within seconds after taking it out of the balancer. As far
as I could tell, I never at any time got more than 100MB into swap.

Your patch did seem to keep the machine alive a little longer but that is
subjective and I have no data to back that statement up. Vanilla 2.4.6-pre2
seemed to die off a little faster. Again, with both kernels, pings were
fine, just no interactive at all. I was logged in over the net with no
console so I could not see what was hogging the CPU bot it did not appear to
be a user process. That top -q would not update tells me it was likely in
the kernel because that runs as the highest priority user process. I just
could not get any CPU in user space.


