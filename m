Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287798AbSAMSnR>; Sun, 13 Jan 2002 13:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287656AbSAMSnI>; Sun, 13 Jan 2002 13:43:08 -0500
Received: from smtp006pub.verizon.net ([206.46.170.185]:35027 "EHLO
	smtp006pub.verizon.net") by vger.kernel.org with ESMTP
	id <S287488AbSAMSmw>; Sun, 13 Jan 2002 13:42:52 -0500
Reply-To: <owensjc@bellatlantic.net>
From: "James C. Owens" <owensjc@bellatlantic.net>
To: <mingo@elte.hu>
Cc: "'Matti Aarnio'" <matti.aarnio@zmailer.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: O(1) scheduler ver H6 - more straightforward timeslice macros
Date: Sun, 13 Jan 2002 13:42:34 -0500
Message-ID: <000001c19c62$11882e30$0100a8c0@jcowens.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
In-Reply-To: <Pine.LNX.4.33.0201131907460.5526-100000@localhost.localdomain>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: mingo@localhost.localdomain
> [mailto:mingo@localhost.localdomain]On
> Behalf Of Ingo Molnar
> Sent: Sunday, January 13, 2002 1:09 PM
> To: James C. Owens
> Cc: 'Matti Aarnio'; linux-kernel@vger.kernel.org
> Subject: Re: O(1) scheduler ver H6 - more straightforward timeslice
> macros

[snip]
>
> the macros are still not equivalent. Try HZ = 100 and nice == -17 for
> example.
>
> 	Ingo
>
>

I agree they are not quite equivalent. I have to point out that your macro
definition never delivers max timeslice for the valid nice range. I wrote a
short program to compare the two. Here is the output. Your macro is the
"orig timeslice", the one I am suggesting is "new timeslice". I used the
same values 150 and 30 for max and min timeslice, respectively, that you do
in the sched.h in -H6.

What I am suggesting is that (1) my suggested expressions actually deliver
the correct timeslice range, (2) they clearly show the decrement from
max-timeslice to min-timeslice as p is numerically increased, and (3) they
have a smaller number of arithmetic operators, five in mine versus eight in
the originals. Since these expressions get executed during a significant
fraction of scheduler_tick(task_t *p) calls, which are at HZ frequency, I
would think it would make sense to make them as simple as possible.

nice  -20, orig timeslice  147, new timeslice  150, difference    3
nice  -19, orig timeslice  144, new timeslice  147, difference    3
nice  -18, orig timeslice  141, new timeslice  144, difference    3
nice  -17, orig timeslice  138, new timeslice  141, difference    3
nice  -16, orig timeslice  135, new timeslice  138, difference    3
nice  -15, orig timeslice  132, new timeslice  135, difference    3
nice  -14, orig timeslice  129, new timeslice  132, difference    3
nice  -13, orig timeslice  126, new timeslice  129, difference    3
nice  -12, orig timeslice  123, new timeslice  126, difference    3
nice  -11, orig timeslice  120, new timeslice  123, difference    3
nice  -10, orig timeslice  117, new timeslice  120, difference    3
nice   -9, orig timeslice  114, new timeslice  117, difference    3
nice   -8, orig timeslice  111, new timeslice  114, difference    3
nice   -7, orig timeslice  108, new timeslice  110, difference    2
nice   -6, orig timeslice  105, new timeslice  107, difference    2
nice   -5, orig timeslice  102, new timeslice  104, difference    2
nice   -4, orig timeslice   99, new timeslice  101, difference    2
nice   -3, orig timeslice   96, new timeslice   98, difference    2
nice   -2, orig timeslice   93, new timeslice   95, difference    2
nice   -1, orig timeslice   90, new timeslice   92, difference    2
nice    0, orig timeslice   87, new timeslice   89, difference    2
nice    1, orig timeslice   84, new timeslice   86, difference    2
nice    2, orig timeslice   81, new timeslice   83, difference    2
nice    3, orig timeslice   78, new timeslice   80, difference    2
nice    4, orig timeslice   75, new timeslice   77, difference    2
nice    5, orig timeslice   72, new timeslice   74, difference    2
nice    6, orig timeslice   69, new timeslice   70, difference    1
nice    7, orig timeslice   66, new timeslice   67, difference    1
nice    8, orig timeslice   63, new timeslice   64, difference    1
nice    9, orig timeslice   60, new timeslice   61, difference    1
nice   10, orig timeslice   57, new timeslice   58, difference    1
nice   11, orig timeslice   54, new timeslice   55, difference    1
nice   12, orig timeslice   51, new timeslice   52, difference    1
nice   13, orig timeslice   48, new timeslice   49, difference    1
nice   14, orig timeslice   45, new timeslice   46, difference    1
nice   15, orig timeslice   42, new timeslice   43, difference    1
nice   16, orig timeslice   39, new timeslice   40, difference    1
nice   17, orig timeslice   36, new timeslice   37, difference    1
nice   18, orig timeslice   33, new timeslice   34, difference    1
nice   19, orig timeslice   30, new timeslice   30, difference    0

