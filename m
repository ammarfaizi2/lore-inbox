Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289327AbSA1TfO>; Mon, 28 Jan 2002 14:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289339AbSA1TfF>; Mon, 28 Jan 2002 14:35:05 -0500
Received: from zarjazz.demon.co.uk ([194.222.135.25]:1152 "EHLO
	zarjazz.demon.co.uk") by vger.kernel.org with ESMTP
	id <S289327AbSA1Te5>; Mon, 28 Jan 2002 14:34:57 -0500
Message-ID: <002801c1a832$d38933e0$0201010a@frodo>
From: "Vincent Sweeney" <v.sweeney@barrysworld.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <E16UyCO-0002zE-00@the-village.bc.nu>
Subject: Re: PROBLEM: high system usage / poor SMP network performance
Date: Mon, 28 Jan 2002 19:34:35 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
To: "Vincent Sweeney" <v.sweeney@barrysworld.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Sunday, January 27, 2002 10:54 PM
Subject: Re: PROBLEM: high system usage / poor SMP network performance


> >     CPU0 states: 27.2% user, 62.4% system,  0.0% nice,  9.2% idle
> >     CPU1 states: 28.4% user, 62.3% system,  0.0% nice,  8.1% idle
>
> The important bit here is     ^^^^^^^^ that one. Something is causing
> horrendous lock contention it appears. Is the e100 driver optimised for
SMP
> yet ? Do you get better numbers if you use the eepro100 driver ?


I've switched a server over to the default eepro100 driver as supplied in
2.4.17 (compiled as a module). This is tonights snapshot with about 10%
higher user count than above (2200 connections per ircd)

  7:25pm  up  5:44,  2 users,  load average: 0.85, 1.01, 1.09
38 processes: 33 sleeping, 5 running, 0 zombie, 0 stopped
CPU0 states: 27.3% user, 69.3% system,  0.0% nice,  2.2% idle
CPU1 states: 26.1% user, 71.2% system,  0.0% nice,  2.0% idle
Mem:   385096K av,  232960K used,  152136K free,       0K shrd,    4724K
buff
Swap:  379416K av,       0K used,  379416K free                   21780K
cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
  659 ircd      15   0 74976  73M   660 R    96.7 19.4 263:21 ircd
  666 ircd      14   0 75004  73M   656 R    95.5 19.4 253:10 ircd

So as you can see the numbers are almost the same, though they were worse at
lower users than the e100 driver (~45% system per cpu at 1000 users per ircd
with eepro100,  ~30% with e100).

I will try the profiling tomorrow with the eepro100 driver compiled into the
kernel, I was unable to do the same for the Intel e100 driver today as I
discovered that the Intel driver can currenty only be compiled as a module.

Vince.


