Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261542AbVASCH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbVASCH0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 21:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbVASCH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 21:07:26 -0500
Received: from mail05.syd.optusnet.com.au ([211.29.132.186]:57531 "EHLO
	mail05.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261542AbVASCHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 21:07:19 -0500
Message-ID: <41EDC118.6050105@kolivas.org>
Date: Wed, 19 Jan 2005 13:08:24 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
Cc: "Jack O'Quin" <joq@io.com>, hihone@bigpond.net.au,
       linux <linux-kernel@vger.kernel.org>, CK Kernel <ck@vds.kolivas.org>,
       paul@linuxaudiosystems.com
Subject: Re: [ck] [PATCH][RFC] sched: Isochronous class for unprivileged	soft
 rt	scheduling
References: <41ED08AB.5060308@kolivas.org> <41ED2F1F.1080905@bigpond.net.au>	 <87d5w2u2xd.fsf@sulphur.joq.us> <1106100122.30792.23.camel@krustophenia.net>
In-Reply-To: <1106100122.30792.23.camel@krustophenia.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Tue, 2005-01-18 at 10:17 -0600, Jack O'Quin wrote:
> 
>>Cal <hihone@bigpond.net.au> writes:
>>
>>
>>>There's a collection of test summaries from jack_test3.2 runs at
>>><http://www.graggrag.com/ck-tests/ck-tests-0501182249.txt>
>>>
>>>Tests were run with iso_cpu at 70, 90, 99, 100, each test was run
>>>twice. The discrepancies between consecutive runs (with same
>>>parameters) is puzzling.  Also recorded were tests with SCHED_FIFO and
>>>SCHED_RR.
>>
>>It's probably suffering from some of the same problems of thread
>>granularity we saw running nice --20.  It looks like you used
>>schedtool to start jackd.  IIUC, that will cause all jackd processes
>>to run in the specified scheduling class.  JACK is carefully written
>>not to do that.  Did you also use schedtool to start all the clients?
>>
>>I think your puzzling discrepancies are probably due to interference
>>from non-realtime JACK threads running at elevated priority.
> 
> 
> Isn't this going to be a showstopper?  If I understand the scheduler
> correctly, a nice -20 task is not guaranteed to preempt a nice -19 task,
> if the scheduler decides that one is more CPU bound than the other and
> lowers its dynamic priority.  The design of JACK, however, requires the
> higher priority threads to *always* preempt the lower ones.

The point was the application was started in a manner which would not 
make best use of this policy. The way it was started put everything 
under the same policy, and had equal performance with doing the same 
thing as SCHED_FIFO. So if it's a showstopper for SCHED_ISO then it is a 
showstopper for SCHED_FIFO. Which is, of course, not the case. The test 
needs to be performed again with the rt threads running SCHED_ISO, which 
  Jack has pointed out is trivial. Nice -n -20 on the other hand will 
suffer from this problem even if only the real time thread was run at -20.

Cheers,
Con
