Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267122AbTAURS4>; Tue, 21 Jan 2003 12:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267123AbTAURS4>; Tue, 21 Jan 2003 12:18:56 -0500
Received: from packet.digeo.com ([12.110.80.53]:55768 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267122AbTAURSz>;
	Tue, 21 Jan 2003 12:18:55 -0500
Date: Tue, 21 Jan 2003 09:27:54 -0800
From: Andrew Morton <akpm@digeo.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.59-mm1
Message-Id: <20030121092754.146e64ff.akpm@digeo.com>
In-Reply-To: <Pine.LNX.3.96.1030121085913.30318A-100000@gatekeeper.tmr.com>
References: <20030117002451.69f1eda1.akpm@digeo.com>
	<Pine.LNX.3.96.1030121085913.30318A-100000@gatekeeper.tmr.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Jan 2003 17:27:55.0619 (UTC) FILETIME=[6F385330:01C2C172]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> wrote:
>
> On Fri, 17 Jan 2003, Andrew Morton wrote:
> 
> > http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.59/2.5.59-mm1/
> 
> > -rcf.patch
> > 
> >  run-child-first didn't seem to help anything, and an alarming number of
> >  cleanups and fixes were needed to get it working right.  Later.
> 
> I don't know about right, it seems to make threaded applications
> originally developed on BSD work better (much lower context switching).
> Anyone know if BSD does rcf? This may be an artifact of...

"seems to make"?  This is too vague for me to comment on, unfortunately.

What applications?  What measurements have been made?

It can only affect creation of new threads, not the switching between extant
ones.

> > +ext3-scheduling-storm.patch
> > 
> >  Fix the bug wherein ext3 sometimes shows blips of 100k context
> >  switches/sec.
> 
> Is this a 2.5 bug only? Does this need to be back ported to 2.4? Perhaps
> this is why I have ctx rate problems and some other sites don't with a
> certain application. Very commercial, unfortunately.
> 

The problem has existed in 2.4 since 2.4.20-pre5.  The context switch
problem will only exhibit for small periods of time (say, 10's to 100's of
milliseconds) when the filesystem is under heavy write load.

A patch for 2.4 is at

http://www.zip.com.au/~akpm/linux/patches/2.4/2.4.20/ext3-scheduling-storm.patch
