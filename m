Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288460AbSBDElU>; Sun, 3 Feb 2002 23:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288354AbSBDElL>; Sun, 3 Feb 2002 23:41:11 -0500
Received: from tomts11.bellnexxia.net ([209.226.175.55]:48628 "EHLO
	tomts11-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S288422AbSBDEk5>; Sun, 3 Feb 2002 23:40:57 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: <mingo@elte.hu>
Subject: Re: [PATCH] improving O(1)-J9 in heavily threaded situations
Date: Sun, 3 Feb 2002 23:40:55 -0500
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.33.0202040627001.22583-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0202040627001.22583-100000@localhost.localdomain>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020204044055.EF0579251@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 4, 2002 12:27 am, Ingo Molnar wrote:
> Ed,
>
> i've just uploaded -K2. It should handle your java load better, eg.
> renicing to +15 or +19 should give nice 0 CPU-hogs a clear advantage.
> Please let me know what you find,

Will see what K2 does tomorrow (probably evening).  

>> If system tasks are a problem its easy to exclude them.  I did not do
>> this since monitoring who was triggering this code did not show system
>> tasks.

>the fact that we might need to 'exclude' certain tasks from a mechanism
>shows that the mechanism is not robust.

Testing showed no reason to remove the system tasks.  They were not being
deferred...  We can always add exceptions - here I did not need too.  I
do agree that if we have to start adding exceptions we probably have not
found the best mechanism.

One point that seems to get missed is that a group of java threads,
posix threads or sometimes forked processes combine to make an application.   
Linux, at the scheduler level at least, does not have the ability to 
determine that all the tasks are really one application.  Under light 
loads this makes no difference.  When the load gets heavy having 
this ability helps here.

Maybe we can control this with nice.  Is the the best or only
way to do it?  I am not at all sure it is.  After all nice is just
another knob.  The fewer knobs we have to tweak the easier linux
is to use.

I really think giving the linux schedule more information (not necessarily
using a shared mm) about which groups of tasks comprise an application would
help things. 

What I coded was an attempt to give the scheduler a way to cope under load.
If it knows groups of processes belong together then it can control them 
when required.  With my current code it place running my freenet node at
nice +10 still leaves me with a very responsive system.

I am very interested to see what K2 does here - if no new code is needed
great.  On the other hand if we can figure a way to add a simple and 
understandable knob that let it perform better under load do not think
its a bad thing either.

Ed 




