Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbTK2Dkp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 22:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263570AbTK2Dko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 22:40:44 -0500
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:49393 "EHLO
	mail.kroptech.com") by vger.kernel.org with ESMTP id S261881AbTK2Dkn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 22:40:43 -0500
Message-ID: <048f01c3b62a$8dd739c0$02c8a8c0@steinman>
Reply-To: "Adam Kropelin" <akropel1@rochester.rr.com>
From: "Adam Kropelin" <akropel1@rochester.rr.com>
To: "Derek Foreman" <manmower@signalmarketing.com>,
       "Sam Ravnborg" <sam@ravnborg.org>
Cc: <linux-kernel@vger.kernel.org>
References: <02d801c3b474$e09e42a0$02c8a8c0@steinman> <200311282126.59634.sam@ravnborg.org> <Pine.LNX.4.58.0311282039170.23104@uberdeity>
Subject: Re: Parallel build not working since -test6?
Date: Fri, 28 Nov 2003 22:40:37 -0500
Organization: Kroptech
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Derek Foreman <manmower@signalmarketing.com> wrote:
> On Fri, 28 Nov 2003, Sam Ravnborg wrote:
> 
>> On Thursday 27 November 2003 00:27, Adam Kropelin wrote:
>>> Lately I've noticed my kernel compilations taking longer than usual.
>>> Tonight I finally realized the cause... Parallel building (i.e.
>>> make -jN) is no longer working for me. I traced it back and the
>>> last kernel it worked in was -test5. It ceased working in -test6.
>> It works for me, and for sure it works for most others. Otherwise I
>> would have seen lot of complaints like yours.
>> I recall one similar post, and the person in question used a
>> homegrown script that caused the problems.
> 
> Well, this explains why 2.6.x builds so much slower here than it did
> a few kernels ago.
> 
> make -j3 improves things.  but currently, make -j2 doesn't use both my
> cpus.
> 
> no scripts, just make -j2 bzImage

Ah, yes... -j3 gets me 2 cpp/cc pairs as well. 

What I see with -j3 is 1 parent make process and two make child processes.
With -j2 I see one parent and one child. Leaving -j off entirely gives the same
as -j2. 

-j3:
root     25314 15539  0 Nov27 tty1     00:00:00 make -j3 bzImage
root     25545 25314  0 Nov27 tty1     00:00:00 make -f scripts/Makefile.build obj=arch/i386/kernel
root     25814 25314  0 Nov27 tty1     00:00:00 make -f scripts/Makefile.build obj=kernel


-j2:
root     26391 15539  0 Nov27 tty1     00:00:00 make -j2 bzImage
root     26582 26391  0 Nov27 tty1     00:00:00 make -f scripts/Makefile.build obj=init


--Adam

