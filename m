Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263787AbTLTCi1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 21:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263796AbTLTCi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 21:38:27 -0500
Received: from mail-08.iinet.net.au ([203.59.3.40]:33152 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263787AbTLTCiY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 21:38:24 -0500
Message-ID: <3FE3B61C.4070204@cyberone.com.au>
Date: Sat, 20 Dec 2003 13:38:20 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Christian Meder <chris@onestepahead.de>
CC: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6 vs 2.4 regression when running gnomemeeting
References: <1071864709.1044.172.camel@localhost>	 <20031219203227.GR31393@holomorphy.com>	 <1071876632.1044.179.camel@localhost>  <3FE39603.9000501@cyberone.com.au>	 <1071880660.1044.194.camel@localhost>  <3FE39C7A.7050507@cyberone.com.au>	 <1071882705.1044.207.camel@localhost>  <3FE3A53F.6090203@cyberone.com.au> <1071885178.1044.227.camel@localhost>
In-Reply-To: <1071885178.1044.227.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Christian Meder wrote:

>On Sat, 2003-12-20 at 02:26, Nick Piggin wrote:
>
>>Christian Meder wrote:
>>
>>
>>>On Sat, 2003-12-20 at 01:48, Nick Piggin wrote:
>>>
>>>
>>>>Sounds reasonable. Maybe its large interrupt or scheduling latency
>>>>caused somewhere else. Does disk activity alone cause a problem?
>>>>find / -type f | xargs cat > /dev/null
>>>>how about
>>>>dd if=/dev/zero of=./deleteme bs=1M count=256
>>>>
>>>>
>>>Ok. I've attached the logs from a run with a call with only an
>>>additional dd. The quality was almost undisturbed only very slightly
>>>worse than the unloaded case.
>>>
>>>
>>OK, its probably not that then. Try the find command though, it would
>>be closer to what make/gcc is doing.
>>
>
>Ok. I've attached the find load log. Doesn't feel different from the dd
>disk load case. Quality is almost undisturbed.
>

OK I guess that rules that out then.

>
>>In the meantime, I have a newer scheduler patch against 2.6.0 you could
>>try: http://www.kerneltrap.org/~npiggin/v28p1.gz
>>
>
>Is this patch supposed to be different schedulerwise from the scheduler
>rollup patches against 2.6.0-testx
>

Its just a newer version I haven't released yet. It has a few improvements.

>
>>Try nicing the compile to +19 if it still stutters.
>>
>
>Ok. I'll try it but I'm not too optimistic about the outcome ;-)
>
>

I don't know what it could be if that doesn't work. Sound driver or maybe
some change in 2.6 causing gnomemeeting to do silly things. scheduling
latency is typically very low...

Running a not niced make -j3 bzImage while in X playing a video causes
my (not niced) latency measurement program to average 14us latency,
with 14 samples over 2ms and 136 over 100us out of 145 000 (maximum 7ms).

Running the latency measurement at -10 gives an average of 12us scheduling
latency, with one sample over 100us (305us).

Thats with my scheduler and a PIII-1000. I haven't tried plain 2.6 for a
while, but it wouldn't be much worse (if any). I haven't tried 2.4 either
and I would be surprised if it were any better.



