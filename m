Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273261AbRLQKnX>; Mon, 17 Dec 2001 05:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276591AbRLQKnN>; Mon, 17 Dec 2001 05:43:13 -0500
Received: from [195.66.192.167] ([195.66.192.167]:16902 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S273261AbRLQKnF>; Mon, 17 Dec 2001 05:43:05 -0500
Content-Type: text/plain;
  charset="PT 154"
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Chris Wright <chris@wirex.com>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] kill(-1,sig)
Date: Mon, 17 Dec 2001 12:41:21 -0200
X-Mailer: KMail [version 1.2]
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
In-Reply-To: <UTC200112141734.RAA20953.aeb@cwi.nl> <Pine.LNX.4.33.0112141224200.2957-100000@penguin.transmeta.com> <20011217013445.A30669@figure1.int.wirex.com>
In-Reply-To: <20011217013445.A30669@figure1.int.wirex.com>
MIME-Version: 1.0
Message-Id: <01121712412100.02022@manta>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 December 2001 07:34, Chris Wright wrote:
> * Linus Torvalds (torvalds@transmeta.com) wrote:
> > On Fri, 14 Dec 2001 Andries.Brouwer@cwi.nl wrote:
> > > The new POSIX 1003.1-2001 is explicit about what kill(-1,sig)
> > > is supposed to do. Maybe we should follow it.
> >
> > Well, we should definitely not do it in 2.4.x, at least not until proven
> > that no real applications break.
> >
> > But I applied it to 2.5.x, let's see who (if anybody) hollers.
>
> I had to back this change out of 2.5.1 in order to get a sane shutdown.
> killall5 -15 is commiting suicide ;-(

Hmm. Looking at killall5 source I see

kill(-1, STOP);
for(each proc with p.sid!=my_sid) kill(proc, sig);
kill(-1, CONT);

I guess STOP will stop killall5 too? Not good indeed.

We have two choices: either back it out or find a sane way to implement 
killall5 with new kill -1 behaviour.
--
vda
