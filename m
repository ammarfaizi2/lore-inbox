Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269994AbTHSKUU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 06:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270007AbTHSKUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 06:20:20 -0400
Received: from mail.gmx.de ([213.165.64.20]:39045 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S269994AbTHSKUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 06:20:15 -0400
Message-Id: <5.2.1.1.2.20030819113225.019dae48@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Tue, 19 Aug 2003 12:24:17 +0200
To: Nick Piggin <piggin@cyberone.com.au>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [CFT][PATCH] new scheduler policy
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3F4182FD.3040900@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:53 AM 8/19/2003 +1000, Nick Piggin wrote:
>Hi everyone,
>
>As per the latest trend these days, I've done some tinkering with
>the cpu scheduler. I have gone in the opposite direction of most
>of the recent stuff and come out with something that can be nearly
>as good interactivity wise (for me).
>
>I haven't run many tests on it - my mind blanked when I tried to
>remember the scores of scheduler "exploits" thrown around. So if
>anyone would like to suggest some, or better still, run some,
>please do so. And be nice, this isn't my type of scheduler :P

Ok, I took it out for a quick spin...

Test-starve.c starvation is back (curable via other means), but irman2 is 
utterly harmless.  Responsiveness under load is very nice until I get to 
the "very hefty" end of the spectrum (expected).  Throughput is down a bit 
at make -j30, and there are many cc1's running at very high priority once 
swap becomes moderately busy.  OTOH, concurrency for the make -jN in 
general appears to be up a bit.  X is pretty choppy when moving windows 
around, but that _appears_ to be the newer/tamer backboost bleeding a 
kdeinit thread a bit too dry.  (I think it'll be easy to correct, will let 
you know if what I have in mind to test that theory works out).  Ending on 
a decidedly positive note, I can no longer reproduce priority inversion 
troubles with xmms's gl thread, nor with blender.

(/me wonders what the reports from wine/game folks will be like)

         -Mike



