Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274631AbRJEXnK>; Fri, 5 Oct 2001 19:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274617AbRJEXnA>; Fri, 5 Oct 2001 19:43:00 -0400
Received: from mail.webmaster.com ([216.152.64.131]:2249 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S274596AbRJEXmm> convert rfc822-to-8bit; Fri, 5 Oct 2001 19:42:42 -0400
From: David Schwartz <davids@webmaster.com>
To: <alex@pennace.org>, Neil Brown <neilb@cse.unsw.edu.au>
CC: Bernd Eckenfels <ecki@lina.inka.de>, <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.51 (988) - Registered Version
Date: Fri, 5 Oct 2001 16:43:09 -0700
In-Reply-To: <20011005193049.A6981@buick.pennace.org>
Subject: Re: Desperately missing a working "pselect()" or similar...
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <20011005234310.AAA24657@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>> A technique I used in a similar situation once went something like:  

>> tv.tv_sec=bignum;
>> tv.tv_usec = 0;
>> enable_signals();
>> select(nfds, &readfds,&writefds,0,&tv);

>> and have the signal handlers set tv.tv_sec to 0. (tv is a global
>>variable).

>I've thought about that, but I haven't been able to find any guarantee that
>there will be no user space futzing around with &tv, like a library wrapper
>that copies tv to another spot in memory and invokes the syscall with that
>address.

	This will commonly happen if, for example, the user-side timeval structure 
contains seconds and microseconds and the kernel-side structure contains 
seconds and nanoseconds. The signal might occur after the library has 
performed the structure conversion.

	DS


