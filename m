Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269148AbRGaBke>; Mon, 30 Jul 2001 21:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269149AbRGaBkY>; Mon, 30 Jul 2001 21:40:24 -0400
Received: from server.igoweb.org ([206.129.95.116]:34787 "HELO
	server2.igoweb.org") by vger.kernel.org with SMTP
	id <S269148AbRGaBkX>; Mon, 30 Jul 2001 21:40:23 -0400
Message-ID: <3B660C8D.2080004@igoweb.org>
Date: Mon, 30 Jul 2001 18:40:29 -0700
From: "William M. Shubert" <wms@igoweb.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010712
X-Accept-Language: en-US, en, fr
MIME-Version: 1.0
To: "Matthew G. Marsh" <mgm@paktronix.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Leak in network memory?
In-Reply-To: <Pine.LNX.4.31.0107300939420.14419-100000@netmonster.pakint.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Thanks for your response. I think that we have different problems though 
- my application is not growing at all, so it doesn't seem to be a glibc 
problem. Instead the kernel is refusing my "write()" calls with EAGAIN 
even though I know that I have written only a few kbytes and my output 
buffer size is set to 64K. Because this took 60+ days to start 
happening, I'm guessing that the kernel network code is either leaking 
memory or else is miscounting its memory consumed over time...what I 
really need to know is what I can do to confirm or refute this guess. It 
is also possible of course that there is no leak but my kernel has the 
"network takes too much memory" threshold set too low (and I was just 
lucky until now and didn't see the problem). I have looked at 
"/proc/sys/net/ipv4/tcp_mem", and it claims that it would take 48640 
pages (=200MB) before the TCP stack starts feeling memory pressure. I 
know that my TCP stack is not using this much memory, because I have 
only 256MB in the system and 150MB is under "active" in /proc/meminfo 
(I'm assuming this total does not include TCP data?)...so how can I 
check how much the TCP stack thinks it is currently using, and why it is 
refusing my "write()" calls?

Matthew G. Marsh wrote:

>On Sun, 29 Jul 2001, William M. Shubert wrote:
>
>>...At first it ran fine, but now after an uptime of 67 days
>>I'm starting to see strange problems. It seems as if only a very small
>>amount of memory can be held in the output buffer of each socket, even
>>though they are still set to 64KB!
>>...
>>I tried to trace through the
>>kernel code to see why the kernel would be refusing to give me the
>>buffering that I ask for, and it looks like if the network code thinks
>>that it is using too much memory, then it will behave this way. I'm not
>>100% sure of this, though...which is why I'm posting this message.
>>
>Worse here - the app keeps adding memory and the size of the memory is
>almost exactly equal to the amount of data transferred in (plus a few
>bytes of overhead). This memory is permanently cached and never released.
>We have an open case with RH ....
>
>>Does anybody have any hints on how I can track down exactly why my
>>output buffers aren't working? I see lots of /proc info related to
>>network parameters, but there is little documentation on them.
>>
>We were using the 2.4.5 kernel and were told to go back to the original
>kernel and it got worse. ?? When I find out more - looks like a memory
>leak in the glibc right now but... - I will let you know.
>
-- 

Bill Shubert (wms@igoweb.org) <mailto:wms@igoweb.org>
http://www.igoweb.org/~wms/ <http://igoweb.org/%7Ewms/>



