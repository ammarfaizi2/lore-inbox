Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267357AbUG1RsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267357AbUG1RsS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 13:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267348AbUG1RsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 13:48:18 -0400
Received: from ns1.landhost.net ([66.98.188.87]:30913 "EHLO
	secure.landhost.net") by vger.kernel.org with ESMTP id S267383AbUG1Rrp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 13:47:45 -0400
Message-ID: <1408.81.36.109.252.1091036862.squirrel@www.marcansoft.com>
Date: Wed, 28 Jul 2004 12:47:42 -0500 (CDT)
Subject: Re: ksoftirqd uses 99% CPU triggered by network traffic 
     (maybeRLT-8139 related)
From: hector@marcansoft.com
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Cc: "Pasi Sjoholm" <ptsjohol@cc.jyu.fi>
User-Agent: SquirrelMail/1.4.0
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - secure.landhost.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [32268 769] / [47 12]
X-AntiAbuse: Sender Address Domain - secure.landhost.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 27 Jul 2004, Robert Olsson wrote:
>
>>  > Yeah, when the ksoftirqd is taking all the cpu it will be like that,
>> but
>>  > when the kernel is behaving normally the starving diff is between
>> 0->1sec.
>>  Well ksoftirqd makes your kernel load just visible which is good and
>>  ksofirqd gets accounted for this when softirq's get deferred to it.
>>  It may look like goes from 0 to 100% but thats probably not the case.
>>  The problem is we can starve userland at high loads. As said we were
>>  trying some way to cure this I may have some old patch if you like to
>> try.
>
> Ok, as I said before I'm willing to test your patches.
>
> It would be nice that one could use the full capacity of his/her computer.
> This is not a big problem for everyday use for a workstation but prevents
> 2.6-series to be used in production-enviroments in the servers.
> But hey.. we need to do some work and maybe we will resolve this. =)
>
> --
> Pasi Sjöholm

Hi all, and first of all thanks for all the feedback!

Currently i'm on vacation (reading this through webmail, if you notice
anything strange please tell me) and I won't be able to test anything, but
Monday I'm back.

As I mentioned in the first e-mail, I can reproduce this under heavy
_packet_ load, UDP load actually, with 5-20 byte packets at a moderate
rate. No other CPU usage is needed to reproduce it, so it seems to be more
related to the number of packets than to the bytes/sec. Presumably more
packets means more interrupts, hence this behaviour. Also, the fact that
this packet stream is actually a debug-mesage protocol stream which
basically gets dumped to the screen (each UDP packet is one line) might
account for a slightly increased CPU load.

I'm willing to test any patches and other stuff that may be needed, I have
free time currently.

BTW this actually is a pretty big pain in the ass for me, since I need
those messages to get feedback from an application I'm developing. I can
reduce them, but then I get less feedback.

This seems to be something resource-related since the first 15-30 minutes
all goes well, but it just starts (not having touched the computer) and
then there's no going back. I can (with some effort) close down X and
telnet in, but performance is very bad (even the framebuffer screen takes
some time to refresh after a line scroll--and that's a kernel job AFAIK)

BTW when I get back I'll test it with the old 10mbps card that I use for
the external connection (internet) to see if it still happens with the
other driver. I might be able to try other cards as well.
