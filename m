Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269400AbTGVBTn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 21:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270576AbTGVBTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 21:19:43 -0400
Received: from newpeace.netnation.com ([204.174.223.7]:3481 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP id S269400AbTGVBTk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 21:19:40 -0400
Date: Mon, 21 Jul 2003 18:34:43 -0700
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org
Subject: Scheduler starvation (2.5.x, 2.6.0-test1)
Message-ID: <20030722013443.GA18184@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I keep seeing cases where browsing in mozilla / galeon will suck away all
CPU from X updating the mouse, xmms playing, etc., for about a second as
Mozilla renders a page (which should take 50 ms to render, but anyway..).

This is only a Celeron 466 MHz, but there never used to be such a problem
in 2.2 and 2.4 kernels.  All processes (X, galeon, xmms) are running with
the default nice of 0.  It seems there is something with the scheduler
heuristics which is giving galeon a way-too-large preemptive timeslice
and not even allowing enough CPU to other processes to, for example, let
X update the mouse cursor.  This seems wrong -- Shouldn't the device
event always wake up and switch to the X task if the process has usable
timeslices left?

This only seems to happen after letting the system settle for some time. 
If I refresh a page once, the problem happens.  Again, less.  Again, the
scheduler seems to allow mouse updates normally.  I have to wait about 30
seconds for the problem to occur again.  This is much easier to see with
X reniced to +1.  It occurs with X reniced to +0, but not as often.  With
the old scheduler, +20 wouldn't even make a noticeable difference because
mouse events would still wake up and run the process as expected.

It is really easy to notice the problem on this box not because of the
audible and visible skips, but the fact that there's a bug in the ALSA
Gravis Ultrasound Classic driver which causes it to sometimes play
incorrect portions of RAM when the sound restarts. :)

Is anybody else seeing this or is it something to do with my setup here?

Simon-
