Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbTHSSuO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 14:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbTHSSrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 14:47:52 -0400
Received: from imap.gmx.net ([213.165.64.20]:36555 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261185AbTHSSpV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 14:45:21 -0400
Message-Id: <5.2.1.1.2.20030819201902.019f2d88@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Tue, 19 Aug 2003 20:49:24 +0200
To: Nick Piggin <piggin@cyberone.com.au>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [CFT][PATCH] new scheduler policy
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3F4228CB.9000805@cyberone.com.au>
References: <5.2.1.1.2.20030819113225.019dae48@pop.gmx.net>
 <5.2.1.1.2.20030819113225.019dae48@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:40 PM 8/19/2003 +1000, Nick Piggin wrote:


>Mike Galbraith wrote:
>
>>At 11:53 AM 8/19/2003 +1000, Nick Piggin wrote:
>>
>>>Hi everyone,
>>>
>>>As per the latest trend these days, I've done some tinkering with
>>>the cpu scheduler. I have gone in the opposite direction of most
>>>of the recent stuff and come out with something that can be nearly
>>>as good interactivity wise (for me).
>>>
>>>I haven't run many tests on it - my mind blanked when I tried to
>>>remember the scores of scheduler "exploits" thrown around. So if
>>>anyone would like to suggest some, or better still, run some,
>>>please do so. And be nice, this isn't my type of scheduler :P
>>
>>
>>Ok, I took it out for a quick spin...
>
>
>Thanks again.
>
>>
>>Test-starve.c starvation is back (curable via other means), but irman2 is 
>>utterly harmless.  Responsiveness under load is very nice until I get to 
>>the "very hefty" end of the spectrum (expected).  Throughput is down a 
>>bit at make -j30, and there are many cc1's running at very high priority 
>>once swap becomes moderately busy.  OTOH, concurrency for the make -jN in 
>>general appears to be up a bit.  X is pretty choppy when moving windows 
>>around, but that _appears_ to be the newer/tamer backboost bleeding a 
>>kdeinit thread a bit too dry.  (I think it'll be easy to correct, will 
>>let you know if what I have in mind to test that theory works 
>>out).  Ending on a decidedly positive note, I can no longer reproduce 
>>priority inversion troubles with xmms's gl thread, nor with blender.
>
>
>Well, it sounds like a good start, though I'll have to get up to scratch
>on the array of scheduler badness programs!

(looks like a fine start to me.  my box [and subjective driver] give it a 
one thumb up plus change;)

>I expect throughput to be down in this release due to the timeslice thing.
>This should be fixable.
>
>I think either there is a bug in my accounting somewhere or I have not quite
>thought it though properly because priorities don't seem to get distributed
>well. Also its not using the nanosecond timing stuff (yet). This might help
>a bit.

Hmm.  I watched priority distribution (eyeballs, not instrumentation), and 
it looked "right" to me until the load reached "fairly hefty"... at the 
point where swap really became a factor, distribution flattened, and the 
mean priority rose (high).  I did see some odd-ball high priority cc1's at 
the low to moderate end (historically indicator of trouble here), but not 
much.  At what I call moderate load, it behaved well, and looked/felt good.

         -Mike 

