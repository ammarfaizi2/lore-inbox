Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291386AbSBMFgo>; Wed, 13 Feb 2002 00:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291387AbSBMFgZ>; Wed, 13 Feb 2002 00:36:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47888 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291386AbSBMFgL>;
	Wed, 13 Feb 2002 00:36:11 -0500
Message-ID: <3C69FB14.167B899E@zip.com.au>
Date: Tue, 12 Feb 2002 21:35:16 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sys_sync livelock fix
In-Reply-To: <3C69EBB7.24EA9C05@zip.com.au> <Pine.LNX.3.96.1020213000859.8487A-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> 
> > But we want sync to be useful.
> 
>   No one has proposed otherwise. Unless you think that a possible hang is
> useful, the questions becomes adding all dirty buffers to the elevator,
> then (a) waiting or (b) returning. Either satisfies SuSv2.

errr.  Bill.  I wrote the patch.   Please take this as a sign
that I'm not happy with the current implementation :)

> >
> > >
> > >   If this were only a performance issue I wouldn't push for prompt
> > > implementation, but anything which can hang the system, particularly in
> > > shutdown, is bad.
> > >
> >
> > If shutdown hangs, it's probably due to something else.
> 
>   If you discount the evidence you can prove anything... or disbelieve
> anything.

Thing is, at shutdown all the tasks which are generating write
traffic should have been killed off, and the filesystems unmounted
or set readonly.    There's no obvious way in which this shutdown
sequence can be indefinitely stalled by the problem we're discussing here.

If the shutdown scripts are calling sys_sync() *before* killing
everything then yes, the scripts could hang indefinitely.  Is
this the case?

If "yes" then the scripts are dumb.  Just remove the `sync' call.

If "no" then something else is causing the hang.

-
