Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267415AbTALTaO>; Sun, 12 Jan 2003 14:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267421AbTALTaO>; Sun, 12 Jan 2003 14:30:14 -0500
Received: from mta1.srv.hcvlny.cv.net ([167.206.5.4]:3582 "EHLO
	mta1.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S267415AbTALTaL>; Sun, 12 Jan 2003 14:30:11 -0500
Date: Sun, 12 Jan 2003 14:37:00 -0500
From: Rob Wilkens <robw@optonline.net>
Subject: Re: any chance of 2.6.0-test*?
In-reply-to: <1042400094.1208.26.camel@RobsPC.RobertWilkens.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: robw@optonline.net
Message-id: <1042400219.1208.29.camel@RobsPC.RobertWilkens.com>
Organization: Robert Wilkens
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com>
 <1042400094.1208.26.camel@RobsPC.RobertWilkens.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minor change to my original message below.. I left a line out of a code
change suggestion.

On Sun, 2003-01-12 at 14:34, Rob Wilkens wrote:
> Linus,
> 
> I'm REALLY opposed to the use of the word "goto" in any code where it's
> not needed.  OF course, I'm a linux kernel newbie, so I'm in no position
> to comment
> 
> Let me comment below the relevant code snippet below as to how I would
> change it:
> 
> On Sun, 2003-01-12 at 14:15, Linus Torvalds wrote:
> > 		if (spin_trylock(&tty_lock.lock))
> > 			goto got_lock;
> > 		if (tsk == tty_lock.lock_owner) {
> > 			WARN_ON(!tty_lock.lock_count);
> > 			tty_lock.lock_count++;
> > 			return flags;
> > 		}
> > 		spin_lock(&tty_lock.lock);
> > 	got_lock:
> > 		WARN_ON(tty_lock.lock_owner);
> 	    	   <etc...>
> 
> I would change it to something like the following (without testing the
> code through a compiler or anything to see if it's valid):
> 
> 			if (!(spin_trylock(&tty_lock.lock))){
> 				if (tsk ==tty_lock.lock_owner){
> 					WRAN_ON(!tty_lock.lcok_count);
> 					tty_lock.lock_count++;
> 					return flags;
> 				}
> 			}
oops - Yes,  I forgot to add one line here (my point remains the same: 
			  spin_lock(&tty_lock.lock);
> 			WARN_ON(tty_lock.lock_owner);	
> 			<etc...>
> 
> Am I wrong that the above would do the same thing without generating the
> sphagetti code that a goto would give you.  Gotos are BAD, very very
> bad.  Please note also that the two if statements above could probably
> even be combined further into one statement by using a short circuit &&
> in the if.
> 
> If I'm misinterpreting the original code, then forgive me..  I just saw
> a goto and gasped.  There's always a better option than goto.
> 
> -Rob

