Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbVATAOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbVATAOX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 19:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbVATAMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 19:12:53 -0500
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:60595 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261987AbVATAGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 19:06:34 -0500
Message-ID: <41EEF649.4070705@kolivas.org>
Date: Thu, 20 Jan 2005 11:07:37 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jack O'Quin" <joq@io.com>
Cc: linux <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       rlrevell@joe-job.com, paul@linuxaudiosystems.com,
       CK Kernel <ck@vds.kolivas.org>, Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [PATCH][RFC] sched: Isochronous class for unprivileged soft rt
 scheduling
References: <41ED08AB.5060308@kolivas.org> <87is5tx61a.fsf@sulphur.joq.us>	<41EE2987.1040005@kolivas.org> <873bwxpckv.fsf@sulphur.joq.us>
In-Reply-To: <873bwxpckv.fsf@sulphur.joq.us>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack O'Quin wrote:
> Try again with JACK 0.99.48.  It's in CVS now, but you probably need
> this tarball to get around the dreaded SourceForge anon CVS lag...
> 
>    http://www.joq.us/jack/tarballs/jack-audio-connection-kit-0.99.48.tar.gz

Thanks it finally ran to completion. By the way the patch you sent with 
the test suite did not apply so I had to do it manually (booraroom..)

> The results I get with these versions are a lot more stable.  But,
> there are still some puzzles about the scheduling.  Do you distinguish
> different SCHED_ISO priorities?  

It was not clear whether that would be required or not. This is why 
testing is so critical because if you are having latency issues it 
wouldn't be a problem of getting cpu time since your cpu usage is well 
below the 70% limit.

> 
> JACK runs with three different SCHED_FIFO priorities:
> 
>   (1) The main jackd audio thread uses the -P parameter.  The JACK
>   default is 10, but Rui's script sets it with -P60.  I don't think
>   the absolute value matters, but the value relative to the other JACK
>   realtime threads probably does.
> 
>   (2) The clients' process threads run at a priority one less (59).
> 
>   (3) The watchdog timer thread runs at a priority 10 greater (70).
> 
>   (4) LinuxThreads creates a manager thread in each process running
>   one level higher than the highest user realtime thread priority.

Since I (finally) have it running at this end at last I'll do some 
benchmarking of my own to see how (lack of) priorities affects 
SCHED_ISO. If it is inadequate, it wont be too difficult to add them to 
the design. The problem with priorities is that once you go over the cpu 
limit everyone suffers equally; but that's a failsafe that you shouldn't 
actually hit in normal usage so it probably doesn't matter... Hmm come 
to think of it, it probably _is_ a good idea to implement priority 
support afterall.

Cheers,
Con
