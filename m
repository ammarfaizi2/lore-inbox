Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264152AbTFVP0A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 11:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264202AbTFVP0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 11:26:00 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:5133 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264152AbTFVPZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 11:25:59 -0400
Subject: Re: [PATCH] sleep_decay for interactivity 2.5.72 - testers  needed
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andreas Boman <aboman@midgaard.us>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>
In-Reply-To: <200306222345.52676.kernel@kolivas.org>
References: <5.2.0.9.2.20030619171843.02299e00@pop.gmx.net>
	 <200306201229.55425.kernel@kolivas.org>
	 <200306222335.10864.kernel@kolivas.org>
	 <200306222345.52676.kernel@kolivas.org>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1056296401.712.9.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 22 Jun 2003 17:40:02 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-06-22 at 15:45, Con Kolivas wrote:

> > Feel free to test it and comment. Things to look for - the dreaded audio
> > skip under load, and X remaining interactive during sustained use under
> > load.

I must say this seems to be getting better, but I still prefer Mike's
patches. With the latest sleep decay patch and 2.5.72-mm3, I can still
easily starve XMMS audio for a long time (~5 seconds) on my 700Mhz
Pentium III laptoñ (running RHL9 and KDE 3.1.2) simply by running "while
true; do a=2; done" on a konsole window. Dragging a window fast enough
also starves XMMS for ~5 seconds just until the scheduler adjusts the
priorities.

XMMS is running with an effective priority of 15 (that's what top says).
"while true; do a=2; done" starts with a priority of 15 (which causes
XMMS to stop playing sound), then it is detected as a CPU hog and every
second its priority is increased by one. When its priority reaches 20,
XMMS starts playing again.

When I move windows around fast enough. the X server starts with a
priority of 15, starving XMMS. If I keep moving windows around for a
long time, X's priority starts increasing by one, until it reaches 20.
At this moment, it stops disturbing XMMS audio playback.

I've been playing with scheduler parameters, mainly by reducing
MAX_SLEEP_AVG to (HZ) and STARVATION_LIMIT to (HZ). This seems to help a
lot, although I can still make XMMS skip sound every once a bit.
However, mplayer is a really hard one: I have been unable to make it
skip sound yet.


