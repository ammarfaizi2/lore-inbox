Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317973AbSGLBk7>; Thu, 11 Jul 2002 21:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317974AbSGLBk7>; Thu, 11 Jul 2002 21:40:59 -0400
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:16909
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S317973AbSGLBk4>; Thu, 11 Jul 2002 21:40:56 -0400
X-All-Your-Base: Are Belong To Us!!!
X-Envelope-Recipient: george@mvista.com
X-Envelope-Sender: oliver@klozoff.com
Message-Id: <5.1.0.14.2.20020711212948.00b02d58@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 11 Jul 2002 21:35:47 -0400
To: george anzinger <george@mvista.com>
From: Stevie O <oliver@klozoff.com>
Subject: Re: HZ, preferably as small as possible
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3D2E2C48.DCB509D7@mvista.com>
References: <Pine.LNX.4.10.10207110847170.6183-100000@zeus.compusonic.fi>
 <5.1.0.14.2.20020711201602.022387b0@whisper.qrpff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 06:09 PM 7/11/2002 -0700, george anzinger wrote:
>> Why must HZ be the same as 'interrupts per second'?
>
>Well, in truth it has nothing to do with interrupts.  It is
>just that that is the way most systems keep time.  The REAL
>definition of HZ is in its relationship to jiffies and
>seconds.  
>
>I.e. jiffies * HZ = seconds, by definition.  
>
>Then we define interfaces that promise to return so many
>jiffies from now and we keep execution time and time slice
>times in jiffies.  In order to keep these things true, it is
>usual to set up some sort of timer to interrupt once each
>jiffie.  Now we can actually do this two ways.  We can say
>that the interrupt is a reminder to look at a "reliable
>clock" and update the system time with what we find OR we
>can use the interrupt to actually drive the system time. 
>The former is the more accurate way of doing things as it
>eliminates interrupt latency.  It also allows us to use a
>more sloppy source of interrupts since they are just
>reminders to check a clock and not actually driving the
>clock.  This, by the way, is what the high-res-timers patch
>does.  Doing things this way also allows one to reprogram
>the timer interrupt hardware with out worrying too much
>about loosing track of time.  The HRT patch does this to
>generate interrupts at sub jiffie intervals, but only when
>required.

So why not do it this way:

1. Let HZ = 1000.

2. Program PIT (having programmed the PC speaker in DOS, I personally believe Intel forgot the 'A' at the end of the name) to fire every 10ms.

3. void pit_isr(void) { jiffies += 10; do_other_stuff(); }


--
Stevie-O

Real programmers use COPY CON PROGRAM.EXE

