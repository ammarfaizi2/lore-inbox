Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263569AbTHZJpY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 05:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263562AbTHZJpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 05:45:24 -0400
Received: from multiserv.relex.ru ([213.24.247.63]:463 "EHLO
	mail.techsupp.relex.ru") by vger.kernel.org with ESMTP
	id S263561AbTHZJpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 05:45:22 -0400
From: Yaroslav Rastrigin <yarick@relex.ru>
Organization: RELEX Inc.
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [PATCH] Nick's scheduler policy v7
Date: Tue, 26 Aug 2003 13:44:05 +0400
User-Agent: KMail/1.5.2
References: <3F48B12F.4070001@cyberone.com.au> <3F497BB6.90100@cyberone.com.au> <3F49E7D1.4000309@cyberone.com.au>
In-Reply-To: <3F49E7D1.4000309@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308261344.05642.yarick@relex.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !
>
> This one has a few changes. Children now get a priority boost
> on fork, and parents retain more priority after forking a child,
> however exiting CPU hogs will now penalise parents a bit.
>
> Timeslice scaling was tweaked a bit. Oh and remember raising X's
> priority should _help_ interactivity with this patch, and IMO is
> not an unreasonable thing to be doing.
>
> Please test. I'm not getting enough feedback!
And here's my report (almost no numbers, everything is purely subjective).
I haven't tested Con's O18.1 yet, so my comparision is against -test4 vanilla.
First (and most subjective opinion) - great. Under casual load (Opera 
rendering page and using its motifwrapper to handle flash (it's a CPU hog 
alone) + ocassional compilation + XMMS using ALSA ) everything feels very 
smooth _and_ responsive, no XMMS jerks, windows are moving nicely - X is 
definitely not starved, ps ax in xterm displays its output almost instantly, 
apps startup time is also very pleasantly low - all in all great. 
Unusual load (make -j 4 bzImage + aforementioned activity ) - I was able to 
notice 1 jerk in XMMS (wasn't able to reproduce, so this is acceptable), 
application startup time is slightly worse, but nonetheless useable and once 
started, all apps are quite smooth, but X is definitely starved, and it has 
great impact on WM - window movement is jerky and feels bad. However, renice 
-20 <X pid> cures this behavior completely, without any noticeable penalty on 
another apps - music is playing nicely, page rendering is still clean and 
nice.

Overall - very nice. 
I'll stick to your scheduling policy for a while .

System specs:

IBM ThinkPad T21, PIII-800Mhz , 256Mb. 
Linux 2.6.0-test4, APM, ALSA, anticipatory IO scheduling
XFree 4.3.99.9 

P.S. make clean && make -j 4 bzImage completed while I was writing this 
letter, so I'm assuming throughput is also OK for me.

-- 
With all the best, yarick at relex dot ru.

