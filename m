Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273622AbRI0QCG>; Thu, 27 Sep 2001 12:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273623AbRI0QB4>; Thu, 27 Sep 2001 12:01:56 -0400
Received: from hermes.toad.net ([162.33.130.251]:22762 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S273624AbRI0QBj>;
	Thu, 27 Sep 2001 12:01:39 -0400
Message-ID: <3BB34D5C.15C76E1A@yahoo.co.uk>
Date: Thu, 27 Sep 2001 12:01:32 -0400
From: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: OOM killer
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After meeting the OOM killer for the first time (not a pleasant meeting)
I went looking for info about it and read through some of the threads
that took place on l-k a few months ago.  I'm sure I didn't read
everything, and I am far from being an expert in this area, but are my
two cents anyway.

It is all very well to have a "smart" function that tries to
minimize the damage done when the OS has to start killing
processes in order to recover memory.  However:

1) It's better if this situation doesn't arise in the first place, and,
2) once it does arise, it's better to let the administrator decide 
   what to kill.  Sometimes the administrator will get fired for killing
   the database and sometimes he'll get fired for killing Netscape---
   there is no way for the authors of Linux to know in advance.

Some OSes don't allow memory overcommit at all.  On these OSes, a process
will simply fail if it tries to allocate memory that's not available.
That Linux allows processes to go ahead under such circumstances can,
I suppose, be called a 'feature'.  But the result of that feature is
that OOM can occur and then a kill decision has to be made.  How this
decision is made ought to be under the administrator's control.

How about assigning each process a property similar to its niceness
which would be used to decide which process to kill in the event of
OOM?  Let's call this property 'humility'.  By default, processes 
would run with humility zero.  A process run with negative humility
would never be allowed to proceed unless there was enough VM to back
up its memory request.  A process with non-negative humility would
be allowed to proceed under such circumstances, but it would be
taking the chance that it would be killed later.

So the system starts to run out of memory.  If all processes have the
same humility then the OOM-killer adjudicator is left to decide among
them just as it does now.  Those with negative humility will never be
killed, and they will never have to be killed because all the memory
they allocated really exists.  Among remaining process, the humblest
get killed first; among those equally humble, the baddest get killed.

So someday in the future I fire up my webserver and start Apache with
negative humility since it's a mission-critical app.  My boss logs in
and starts writing e-mail (humility 0 process).  There's memory 
pressure, so I take the precaution of starting Netscape with
    $ humble communicator
to make sure that communicator gets the axe if we run oom.

Your humble servant,
Thomas Hood
