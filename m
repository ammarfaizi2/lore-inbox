Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131248AbQJ1Xqh>; Sat, 28 Oct 2000 19:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131371AbQJ1Xq0>; Sat, 28 Oct 2000 19:46:26 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:45216 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S131248AbQJ1XqQ>; Sat, 28 Oct 2000 19:46:16 -0400
Date: Sat, 28 Oct 2000 16:51:59 -0700
From: Dan Kegel <dank@alumni.caltech.edu>
Subject: Re: kqueue microbenchmark resul
To: linux-kernel@vger.kernel.org
Reply-to: dank@alumni.caltech.edu
Message-id: <39FB669F.2FDCDB60@alumni.caltech.edu>
MIME-version: 1.0
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.14-5.0 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >In fact, if you did leave the read queued in a daemon using select() 
> >before, you'd keep looping endlessly taking all CPU and never idle 
> >because there would always be read data available. 

That would be a programming error on the part of the application.
Any application using a level-triggered interface like select
or poll must of course mask off events it is not interested in,
to avoid getting them endlessly.  That's just 'select 101'.

> Also, level triggered notifications would also seem to cause 
> multiple thread wakeups and thundering herd problems when 
> there are multiple worker threads reading from the same queue. 
> 
> How does (?) kevent avoid this from happening? 

Easy - applications which have multiple threads reading from the
same queue would use oneshot events instead of level-triggered events.
Level-triggered events are only for applications where a single thread 
is reading from the queue.

- Dan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
