Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266519AbUGURuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266519AbUGURuN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 13:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266534AbUGURuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 13:50:13 -0400
Received: from smtp3.Stanford.EDU ([171.67.16.138]:56762 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S266519AbUGURuG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 13:50:06 -0400
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary	Kernel
	Preemption Patch
From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: "The Linux Audio Developers' Mailing List" 
	<linux-audio-dev@music.columbia.edu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040721125352.7e8e95a1@mango.fruits.de>
References: <20040712163141.31ef1ad6.akpm@osdl.org>
	 <1090306769.22521.32.camel@mindpipe> <20040720071136.GA28696@elte.hu>
	 <200407202011.20558.musical_snake@gmx.de>
	 <1090353405.28175.21.camel@mindpipe> <40FDAF86.10104@gardena.net>
	 <1090369957.841.14.camel@mindpipe>
	 <20040721125352.7e8e95a1@mango.fruits.de>
Content-Type: text/plain
Organization: 
Message-Id: <1090432198.29593.18.camel@cmn37.stanford.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 21 Jul 2004 10:49:58 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-21 at 03:53, Florian Schmidt wrote:
> On Tue, 20 Jul 2004 20:32:37 -0400
> Lee Revell <rlrevell@joe-job.com> wrote:
> > Yes, this is important.  One problem I had recently with the Via EPIA
> > board was that unless 2D acceleration was disabled by setting 'Option
> > "NoAccel"' in /etc/X11/XF86Config-4, overloading the X server would
> > cause interrupts from the soundcard to be completely disabled for tens
> > of milliseconds.  Users should keep in mind that by using 2D or 3D
> > hardware acceleration in X, you are allowing the X server to directly
> > access hardware, which can have very bad results if the driver is
> > buggy.  I am not sure the kernel can do anything about this.
> 
> Hi,
> 
> interesting that you mention the Xserver. I use a dual graphics card setup atm 
> [Nvidia GF3 TI and some matrox pci card]. The nvidia card seems to work flawlessly 
> even with HW accelleration [i use nvidias evil binary only drivers]. The matrox 
> card OTH disturbs the soundcard severely. Whenever i have activity on my second 
> monitor i get sound artefacts in jack's output [no cracklling, it's rather as 
> if the volume is set to 0 for short moments and then back to normal]. There's 
> a certain chance that this artefact produces an xrun. I suppose it's because 
> the card is on the pci bus.

The mga dri kernel driver shares a problem with the radeon (which I use
a lot) and the r128 drivers. They have high latency points that reach
10-15 msecs in normal operation[*]. I have a very old patch (not mine, I
don't quite remember where I got it from) that solves this, but it is
not a "legal" patch in the sense that in schedules with a lock held. It
seems to work but it will lock the computer at some point. AFAIK there
is no proper patch for this latency point at this time. Turning off
acceleration should get rid of the latency spikes with the usual
tradeoff of slow video performance. 

-- Fernando

[*] with the (bad) patch:
http://ccrma.stanford.edu/~nando/latencytest/20040323/2.6.4-1.279.ll.ccrma.radeon/
without the patch:
http://ccrma.stanford.edu/~nando/latencytest/20040323/2.6.4-1.279.ll.ccrma/


