Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263726AbTLTAV3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 19:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263728AbTLTAV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 19:21:29 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:62130 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263726AbTLTAV1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 19:21:27 -0500
Message-ID: <3FE39603.9000501@cyberone.com.au>
Date: Sat, 20 Dec 2003 11:21:23 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Christian Meder <chris@onestepahead.de>
CC: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6 vs 2.4 regression when running gnomemeeting
References: <1071864709.1044.172.camel@localhost>	 <20031219203227.GR31393@holomorphy.com> <1071876632.1044.179.camel@localhost>
In-Reply-To: <1071876632.1044.179.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Christian Meder wrote:

>On Fri, 2003-12-19 at 21:32, William Lee Irwin III wrote:
>
>>On Fri, Dec 19, 2003 at 09:11:50PM +0100, Christian Meder wrote:
>>
>>>I've got a longstanding regression in gnomemeeting usage when switching
>>>between 2.4 and 2.6 kernels.
>>>Phenomenon: 
>>>Without load gnomemeeting VOIP connections are fine. As soon as some
>>>load like a kernel compile is put on the laptop the gnomemeeting audio
>>>stream is cut to pieces and gets unintelligible . On 2.4.2x I don't get
>>>even the slightest distortion in the audio stream under load. I played
>>>around with different nice levels with no success. The problem persisted
>>>during the whole 2.6.0-test series no matter whether I used -mm kernels
>>>or pristine Linus kernels. Even when nicing the kernel compile to +19
>>>the distortions start right away. I tried Nick Piggin's scheduler which
>>>fared slightly better after changing the nice level of gnomemeeting to
>>>-10 but it's still a far cry from the 2.4.2x feeling without any
>>>fiddling with nice values.
>>>Any hints where to start looking are greatly appreciated.
>>>
>>Please instrument your workload with the following, and send logs of the
>>output (preferably compressed) to me and possibly others:
>>
>>top b d 5
>>vmstat 5
>>while true; do cat /proc/vmstat; sleep 5; done
>>while true; do cat /proc/meminfo; sleep 5; done
>>
>>A good way to log commands like this is:
>>
>>(command) > /home/foo.log.1 2>&1 &
>>
>>where parentheses surround the command in the actual shell input.
>>
>
>Hi,
>
>I've attached the tarred output of a gnomemeeting run without load and
>without distortions and another tarred output of a gnomemeeting run
>while compiling a kernel with severe distortions in the audio stream.
>

You're getting a lot fewer interrupts in the loaded case. Maybe its
the sound card driver that has the regression from 2.4? It could be
that 2.6 allows a smaller sound fragment size which is more stressful.


