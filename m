Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265430AbRFVOqm>; Fri, 22 Jun 2001 10:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265431AbRFVOqc>; Fri, 22 Jun 2001 10:46:32 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:39435 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S265430AbRFVOqV>; Fri, 22 Jun 2001 10:46:21 -0400
Date: Fri, 22 Jun 2001 16:46:16 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Reply-To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Rob Landley <landley@webofficenow.com>
cc: Timur Tabi <ttabi@interactivesi.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
In-Reply-To: <01062007520902.00776@localhost.localdomain>
Message-ID: <Pine.LNX.3.96.1010622162213.32091B-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > A lot of OS/2 software is written with this feature in mind.  I know of one
> > programmer who absolutely hates Linux because it's just too difficult
> > porting software to it, and the lack of decent thread support is part of
> > the problem.
> 
> Yup.  OS/2 is the largest nest of trained, experienced multi-threaded 
> programmers.  (And it takes a LOT of training experience to do threads 
> right.)  That's why I've been trying to recruit ex-OS/2 guys over to Linux 
> for years now.  (Most followed Java to Linux after Netscape opened up 
> Mozilla, but there used to be several notable holdouts...)

I did some threaded programming on OS/2 and it was real pain. The main
design flaw in OS/2 API is that thread can be blocked only on one
condition. There is no way thread can wait for more events. For example I
have a thread that processes GUI messages. It is blocked in WinGetMsg -
waiting for messages from pmshell. Now another part of application needs
to wake up the thread to do some things - but there is no way to wake it
up because the thread can't wait for anything else than messages from
pmshell. I actually had to create dummy invisible window. I send messages
to that GUI thread via event queue of that window - really dirty but it
can't be done otherwise. 

When OS/2 designers realised this API braindamage, they somewhere randomly
added funtions to unblock threads waiting for variuos events - for example
VioModeUndo or VioSavRedrawUndo - quite insane.

Programming with select, poll and kqueue on Unix is really much better
than with threads on OS/2. 

Mikulas


