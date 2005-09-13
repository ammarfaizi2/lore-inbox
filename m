Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbVIMOAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbVIMOAr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 10:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbVIMOAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 10:00:46 -0400
Received: from 216-54-166-16.gen.twtelecom.net ([216.54.166.16]:52950 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S1750805AbVIMOAq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 10:00:46 -0400
Message-ID: <4326DB8A.7040109@compro.net>
Date: Tue, 13 Sep 2005 10:00:42 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041220
X-Accept-Language: en-us, en
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org
Subject: Re: HZ question
References: <4326CAB3.6020109@compro.net> <Pine.LNX.4.61.0509130919390.29445@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0509130919390.29445@chaos.analogic.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 5.0.3.165339, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.9.12.33
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> On Tue, 13 Sep 2005, Mark Hounschell wrote:
> 
>>I need to know the kernels value of HZ in a userland app.
>>
>>getconf CLK_TCK
>>     and
>>hz = sysconf (_SC_CLK_TCK)
>>
>>both seem to return CLOCKS_PER_SEC which is defined as USER_HZ which is
>>defined as 100.
>>
>>include/asm/param.h:
>>
>>#ifdef __KERNEL__
>># define HZ       1000   /* Internal kernel timer frequency */
>># define USER_HZ  100    /* .. some user interfaces are in "ticks" */
>># define CLOCKS_PER_SEC  (USER_HZ)       /* like times() */
>>#endif
>>
>>Thanks in advance for any help
>>Mark
> 
> You are not supposed to 'tear apart' user-mode headers. In particular
> you are not supposed to use anything in /usr/include/bits, /usr/include/asm,
> or /usr/include/linux in user-mode programs. These are not POSIX headers.
>

This was a kernel header used for reference. I'm not including them.


> If a user-mode program needs to know HZ, it is very, very, broken.
> HZ is some kernel timeout tick which doesn't relate to anything
> a user program needs to know.
> 

Most if not all userland delay calls rely on HZ value in some way or 
another. The minimum reliable delay you can get is one (kernel)HZ. A 
program that needs an acurrate delay for a time shorter that one 
(kernel)HZ may have an alternative if it knows that HZ is greater the 
the requested delay. So to say my program is broken because it wants to 
know the limitations of my OS/kernel is kind of far fetched.


> This is a problem and is why we should have a kernel system-call
> that returns the HZ value. I asked about this several years ago
> and its inclusion was flatly refused because of what I quoted
> above. Perhaps now that HZ are dynamic, it would be posasible to
> add that system call.
> 

I'll second that. I thought sysconf(_SC_CLK_TCK) was supposed to be that 
call.

> Note, that on this particular kernel, at this phase of the moon...
> This program returns the HZ value.
> 
> #include <stdio.h>
> #include <unistd.h>
> 
> int main()
> {
>      printf("%d\n", sysconf(_SC_CLK_TCK));
>      return 0;
> }
> 
> 
> 

No it does not. It returns USER_HZ. At least on any 2.6.12 and <.

Mark
