Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133003AbRDKV1a>; Wed, 11 Apr 2001 17:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133004AbRDKV1V>; Wed, 11 Apr 2001 17:27:21 -0400
Received: from t2.redhat.com ([199.183.24.243]:9969 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S133003AbRDKV1E>; Wed, 11 Apr 2001 17:27:04 -0400
To: Andrew Morton <andrewm@uow.edu.au>
Cc: David Howells <dhowells@cambridge.redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 rw_semaphores fix 
In-Reply-To: Your message of "Wed, 11 Apr 2001 09:56:09 PDT."
             <3AD48CA9.CA03B85D@uow.edu.au> 
Date: Wed, 11 Apr 2001 22:27:02 +0100
Message-ID: <17752.987024422@warthog.cambridge.redhat.com>
From: David Howells <dhowells@cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You need sterner testing stuff :)  I hit the BUG at the end of rwsem_wake()
> in about a second running rwsem-4.  Removed the BUG and everything stops
> in D state.
> 
> Grab rwsem-4 from
> 
> 	http://www.uow.edu.au/~andrewm/linux/rwsem.tar.gz
> 
> It's very simple.  But running fully in-kernel shortens the
> code paths enormously and allows you to find those little
> timing windows.  Run rmsem-4 in two modes: one with
> the schedule() in sched() enabled, and also with it
> commented out.  If it passes that, it works.  When
> you remove the module it'll print out the number of
> read-grants versus write-grants.  If these run at 6:1
> with schedule() disabled then you've kicked butt.
> 
> Also, rwsem-4 checks that the rwsems are actually providing
> exclusion between readers and writers, and between
> writers and writers.  A useful thing to check, that.

It now works (patch to follow).

schedule() enabled:
 reads taken: 686273
 writes taken: 193414

schedule() disabled:
 reads taken: 585619
 writes taken: 292997

David
