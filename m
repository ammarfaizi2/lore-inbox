Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263984AbUDVMP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263984AbUDVMP3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 08:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263989AbUDVMP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 08:15:29 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:11684 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S263986AbUDVMP1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 08:15:27 -0400
Subject: Re: [PATCH] s390 (9/9): no timer interrupts in idle.
To: Arjan van de Ven <arjanv@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OF694C3C12.232234B8-ONC1256E7E.00423882-C1256E7E.004344A0@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Thu, 22 Apr 2004 14:14:44 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.0.2CF2|July 23, 2003) at
 22/04/2004 14:14:46
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





> ok maybe I need to word it differently.
> What I'm proposing as alternative is using the one shot mode of the
timers
> on most machines to do teh following:
> when the timer irq hits, you do the business you need to do. And then you
> check all existing timers and the scheduler when the next "virtual tick"
is where
> you're going to do real work. You then set the one-shot counter to that
> amount. This means that in add_timer/mod_timer you will need to check if
the
> just added timer is before the current one-shot runs out, and if so,
adjust
> it. Perhaps in the scheduler too.

You can't do that with the current timer code. A HZ timer interrupt is used
for several things: 1) increase jiffies_64, 2) update the xtime, 3) calculate
the load every 5 seconds, 4) check cpu time limits and send SIGXCPU,
5) do interval timer stuff, 6) run local timer queue and 7) add time slice to
current process. With your one-shot timer you won't do the correct updates
to the jiffies and the xtime.

blue skies,
   Martin

