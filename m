Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267403AbUHJCgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267403AbUHJCgI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 22:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267404AbUHJCgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 22:36:08 -0400
Received: from smtp2.Stanford.EDU ([171.67.16.125]:21419 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S267403AbUHJCgC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 22:36:02 -0400
Subject: Re: 2.4.x vs 2.6.x: denormal handling and audio performance
From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       jackit-devel <jackit-devel@lists.sourceforge.net>
In-Reply-To: <1092099606.22613.12.camel@mindpipe>
References: <1092079195.16794.257.camel@cmn37.stanford.edu>
	 <1092099606.22613.12.camel@mindpipe>
Content-Type: text/plain
Organization: 
Message-Id: <1092105353.16799.848.camel@cmn37.stanford.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Aug 2004 19:35:53 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-09 at 18:00, Lee Revell wrote:
> On Mon, 2004-08-09 at 15:19, Fernando Pablo Lopez-Lezcano wrote:
> > Hi all, I've been trying to track weird behavior I'm experiencing when
> > trying to use 2.6.x for "pro audio" applications and I think I have
> > something to report (and some questions). 
> > 
> > First, the environment. I'm running the Jack low latency server on top
> > of two different software installs on the same hardware, one is FC1 +
> > 2.4.26 + low latency and preemption patches, the other is FC2 + 2.6.7
> > rc2-mm2 + voluntary preemption O3. They are different hard disks swapped
> > into the same P4 laptop. Both are running the same source code versions
> > of all the audio programs that I use to test (but _not_ the same
> > binaries, each one is built in the environment it runs on). 
>
> Have you tried using the exact same binaries under both 2.4 and 2.6? 
> This would rule out a compiler issue.

I finally managed to boot the 2.6 kernel on top of FC1, but I can't run
jack with realtime priority, somehow the kernel is not happy with
something in the system, some jack client applications just hang. 

Anyway, running under 2.6 without realtime makes the numbers fluctuate a
lot more but I see the same effect. After a while freqtweak samples
decay to close to zero and it starts using a lot of cpu. Starting
hydrogen again (the drum machine feeding freqtweak in my tests)
immediately solves the problem. 

[some time later]

_BUT_ 

[frantically trying to find a big brown bag to hide in... sigh...]

I retested with 2.4.x under FC1 yet again and I do see the same
effect... argh... [*]

> In case anyone thinks this is an application bug, here are some links
> pertaining to the P4 denormals-are-zero issue, these were at the bottom
> of Fernando's post:
> 
> http://gcc.gnu.org/ml/gcc/2001-07/msg02162.html
> http://lkml.org/lkml/2003/5/9/144

So, this is good in a way. I've been trying to find some code snippet
that would enable me to change the DAZ flag in MXCSR, without luck so
far... I know this is probably OT but would anyone out there know how to
do this, or where to find useful information?

-- Fernando

[*] the test conditions in my two systems were not _exactly_ the same (I
should know by now that is bad), so that in the FC1 case the decay into
denormals was taking a lot longer. I have to learn to be more patient. 


