Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318601AbSIFOAc>; Fri, 6 Sep 2002 10:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318602AbSIFOAc>; Fri, 6 Sep 2002 10:00:32 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:52145 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318601AbSIFOAb>; Fri, 6 Sep 2002 10:00:31 -0400
Subject: pid_max hang again...
From: Paul Larson <plars@linuxtestproject.org>
To: mingo@elte.hu, Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 06 Sep 2002 08:52:47 -0500
Message-Id: <1031320378.24570.44.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the nightly bk pull testing I do, I saw that this got commited
yesterday:

-ChangeSet@1.619, 2002-09-05 08:45:49-07:00, mingo@elte.hu
-  [PATCH] pid-max-2.5.33-A0
-  
-  This is the pid-max patch, the one i sent for 2.5.31 was botched.  I
-  have removed the 'once' debugging stupidity - now PIDs start at 0
-  again.
-  Also, for an unknown reason the previous patch missed the hunk that 
-  had the declaration of 'DEFAULT_PID_MAX' which made it not compile

It looks like this change dropped us back to the same error all this was
originally supposed to fix.  When you hit PID_MAX, get_pid() starts
looping forever looking for a free pid and hangs.  I could probably make
my original fix work on this very easily if you'd like.

I wonder though, would it be possible to do this in a more simple way by
just throttling max_threads back to something more sane if it gets
defaulted too high?  Since it gets checked before we even get to the
get_pid call in copy_process().  That would keep the number of processes
down to a sane level without the risk.

Thanks,
Paul Larson
http://www.linuxtestproject.org

