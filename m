Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313057AbSEAPDQ>; Wed, 1 May 2002 11:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313070AbSEAPDP>; Wed, 1 May 2002 11:03:15 -0400
Received: from avscan1.sentex.ca ([199.212.134.11]:61164 "EHLO
	avscan1.sentex.ca") by vger.kernel.org with ESMTP
	id <S313057AbSEAPDO>; Wed, 1 May 2002 11:03:14 -0400
Message-ID: <00f501c1f121$6b7614c0$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "David Dyck" <dcd@tc.fluke.com>, "Alan Modra" <alan@linuxcare.com>,
        "Kiyokazu SUTO" <suto@ks-and-ks.ne.jp>,
        "Andrew Morton" <andrewm@uow.edu.au>,
        "Arnaldo Carvalho de Melo" <acme@conectiva.com.br>,
        "Kanoj Sarcar" <kanoj@sgi.com>,
        "Christer Weinigel" <wingel@hog.ctrl-c.liu.se>,
        "Robert Schwebel" <robert@schwebel.de>,
        "Juergen Beisert" <jbeisert@eurodsn.de>,
        "Theodore Ts'o" <tytso@mit.edu>, "Sapan Bhatia" <sapan@corewars.org>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0204301451300.2964-100000@dd.tc.fluke.com>
Subject: Re: changes between 2.2.20 and 2.4.x 'broke' select() from detecting input characters in my serial /dev/ttyS0 program
Date: Wed, 1 May 2002 11:03:57 -0400
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "David Dyck" <dcd@tc.fluke.com>
> It turns out also that the O_WRONLY channel had CREAD turned off,
> which I would expect was appropriate for an output channel, and
> in 2.2 kernels, it didn't affect the O_RDONLY channel.  If I enable
> the CREAD bit in termios c_cflag register for the O_WRONLY channel also
> then the select on the O_RDONLY channel reports characters available.
>
> I suspect that there is a different level of information sharing
> between the 2 channels that are open, but which is the correct behaviour,
> and why?

CREAD handling was changed to be correct; recently, but I don't know
exactly when. The 2.4 vs 2.2 difference sounds about right though.
Previously CREAD had been incorrectly handled by the driver and hadn't
been changed because some apps would break. Now data is correctly
ignored on receive when CREAD is off.

When you talk about the "O_WRONLY channel" and the "O_RDONLY channel"
you're not actually referring to separate things. Each serial port is
represented in the kernel as one entity that may be opened different
ways, possibly multiple times.

When you turn off CREAD in your write side, you turn off CREAD for the
whole port, including the read only side. This is not a bug in the
driver.

..Stu


