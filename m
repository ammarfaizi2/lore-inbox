Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263763AbTLTB0i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 20:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263767AbTLTB0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 20:26:38 -0500
Received: from mail-09.iinet.net.au ([203.59.3.41]:64192 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263763AbTLTB0e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 20:26:34 -0500
Message-ID: <3FE3A53F.6090203@cyberone.com.au>
Date: Sat, 20 Dec 2003 12:26:23 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Christian Meder <chris@onestepahead.de>
CC: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6 vs 2.4 regression when running gnomemeeting
References: <1071864709.1044.172.camel@localhost>	 <20031219203227.GR31393@holomorphy.com>	 <1071876632.1044.179.camel@localhost>  <3FE39603.9000501@cyberone.com.au>	 <1071880660.1044.194.camel@localhost>  <3FE39C7A.7050507@cyberone.com.au> <1071882705.1044.207.camel@localhost>
In-Reply-To: <1071882705.1044.207.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Christian Meder wrote:

>On Sat, 2003-12-20 at 01:48, Nick Piggin wrote:
>
>>Sounds reasonable. Maybe its large interrupt or scheduling latency
>>caused somewhere else. Does disk activity alone cause a problem?
>>find / -type f | xargs cat > /dev/null
>>how about
>>dd if=/dev/zero of=./deleteme bs=1M count=256
>>
>
>Ok. I've attached the logs from a run with a call with only an
>additional dd. The quality was almost undisturbed only very slightly
>worse than the unloaded case.
>

OK, its probably not that then. Try the find command though, it would
be closer to what make/gcc is doing.

>
>>You said it faired slightly better with my scheduler when renicing
>>gnome meeting to -10. How much better is that?
>>
>
>Worse than unloaded and worse than the disk loaded case from above. But
>all (CPU) loaded cases were producing almost complete audio dropouts
>while with your scheduler and renicing to -10 I got at least a
>stuttering audio stream (a regular pattern of very short slices of audio
>mixed with very short slices of silence).
>

So it does sound like scheduling latency then. Its difficult to find
out what is happening with top and vmstat because they don't give you
an idea of individual scheduling events, which is what is important
for things like this. I'll have a look into making up a patch to gather
what I want to know.

In the meantime, I have a newer scheduler patch against 2.6.0 you could
try: http://www.kerneltrap.org/~npiggin/v28p1.gz

Try nicing the compile to +19 if it still stutters.


