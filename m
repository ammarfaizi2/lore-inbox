Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262876AbTCKJas>; Tue, 11 Mar 2003 04:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262877AbTCKJar>; Tue, 11 Mar 2003 04:30:47 -0500
Received: from pop.gmx.net ([213.165.65.60]:48180 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S262876AbTCKJar>;
	Tue, 11 Mar 2003 04:30:47 -0500
Message-Id: <5.2.0.9.2.20030311095954.01f9a008@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Tue, 11 Mar 2003 10:46:05 +0100
To: jim.houston@attbi.com
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] self tuning scheduler
Cc: linux-kernel@vger.kernel.org, jim.houston@ccur.com
In-Reply-To: <200303110030.h2B0UsR00844@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I took your patch out for a test-drive, and it appears to have starvation 
problems with irman's process load (dang thing seems to be HELL on schedulers).

Irman starts a load (defaults to 9 tasks passing data in a pipe ring), and 
forks a child which pingpongs one character back and forth to the parent 
for 1000000 iterations, measuring response time for each iteration and 
computing statistics.  With an iteration % 1000 printf() in the evaluation 
routine, I see it start off nice and fast, then begins to get starved for 
up to 30 seconds.  It jerks around for a bit, then slows down to a ~stable 
1 sec/iteration after approximately 300000 iterations.  The whole test 
takes ~2minutes with 2.5.64-virgin.  (I'm not patient enough to wait for 
the rest of the .5million iterations left on this burn before reporting:)

It also shows a serious throughput loss with make -j30 bzImage on this box 
(I think you expect that though from what I read).  With stock, it takes 
~8m30s... this scheduler adds a full minute.

The window wave test with a make -j5 bzImage running (fits easily in ram) 
is pretty ragged.

Ending on a more positive note, vmstat output from the parallel build looks 
quite nice.

	-Mike

