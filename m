Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264945AbTBOTKH>; Sat, 15 Feb 2003 14:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264950AbTBOTKG>; Sat, 15 Feb 2003 14:10:06 -0500
Received: from dhcp-66-212-193-131.myeastern.com ([66.212.193.131]:15263 "EHLO
	mail.and.org") by vger.kernel.org with ESMTP id <S264945AbTBOTKE>;
	Sat, 15 Feb 2003 14:10:04 -0500
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Synchronous signal delivery..
References: <Pine.LNX.4.44.0302131452450.4232-100000@penguin.transmeta.com>
	<Pine.LNX.4.50.0302141553020.988-100000@blue1.dev.mcafeelabs.com>
From: James Antill <james@and.org>
Content-Type: text/plain; charset=US-ASCII
Date: 15 Feb 2003 14:19:54 -0500
In-Reply-To: <Pine.LNX.4.50.0302141553020.988-100000@blue1.dev.mcafeelabs.com>
Message-ID: <m3fzqpgxlx.fsf@code.and.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi <davidel@xmailserver.org> writes:

> On Thu, 13 Feb 2003, Linus Torvalds wrote:
> 
> > > > One of the reasons for the "flags" field (which is not unused) was because
> > > > I thought it might have extensions for things like alarms etc.
> > >
> > > I was thinking more like :
> > >
> > > int timerfd(int timeout, int oneshot);
> >
> > It could be a separate system call, ...
> 
> I would personally like it a lot to have timer events available on
> pollable fds. Am I alone in this ?

 Think of "timer events" as a single TCP connection, so you have...

time X: empty
time X+Y: timed event "Arrives"
time X+Z: timed event "Arrives"

...at which point it's pretty obvious that if you "poll" the timer
event queue from anytime before X+Y it'll be empty, and anytime after
X+Y it'll be "full". There isn't any point in being able to distinguish
between the events X+Y and X+Z, you only need to know a timed event has
occurred so you should process all timed events that are needed.
 At which point you just need to work out the difference between X and
X+Y, and pass that to poll/sigtimedwait/etc.

-- 
# James Antill -- james@and.org
:0:
* ^From: .*james@and\.org
/dev/null
