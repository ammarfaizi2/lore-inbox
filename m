Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbTKEC5v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 21:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbTKEC5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 21:57:51 -0500
Received: from mail-09.iinet.net.au ([203.59.3.41]:1170 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262719AbTKEC5u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 21:57:50 -0500
Message-ID: <3FA86645.7030302@cyberone.com.au>
Date: Wed, 05 Nov 2003 13:53:57 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: john stultz <johnstul@us.ibm.com>, Joel Becker <Joel.Becker@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: get_cycles() on i386
References: <Pine.LNX.4.44.0311041545030.20373-100000@home.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0311041545030.20373-100000@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Linus Torvalds wrote:

>On 4 Nov 2003, john stultz wrote:
>
>>CONFIG_X86_TSC be the devil. Personally, I'd much prefer dropping the
>>compile time option and using dynamic detection. Something like (not
>>recently tested and i believe against 2.5.something, but you get the
>>idea):
>>
>
>Some of the users are really timing-critical (eg scheduler).
>

The scheduler uses its own sched_clock which only gives jiffies
resolution if CONFIG_NUMA is defined. Unfortunate because I think
its interactive behaviour isn't so good with ms resolution.

The scheduler does not need to have synchronised TSCs though, I think.
It just means 2 more calls to sched_clock in a slow path (smp migration).


