Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265570AbTBYBrc>; Mon, 24 Feb 2003 20:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266702AbTBYBrb>; Mon, 24 Feb 2003 20:47:31 -0500
Received: from air-2.osdl.org ([65.172.181.6]:1464 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265570AbTBYBr3>;
	Mon, 24 Feb 2003 20:47:29 -0500
Date: Mon, 24 Feb 2003 19:34:57 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
cc: <mingo@elite.hu>
Subject: Badness between recent signal changes and minicom.
Message-ID: <Pine.LNX.4.33.0302241918380.1088-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey there.

I had been using minicom on 2.5.59 for some time with no problems. After
finally upgrading that system to 2.5.62, minicom decided it didn't want to
run anymore. An strace of it reveals that it's receiving -ECHILD from
wait4(2) after executing lockdev, although lockdev appears to exit 
normally. 

For the record, this is a Redhat 7.3 system, with the following versions 
of the relevant programs:

minicom-2.00.0-3
lockdev-1.0.0-16

I backtracked through kernel versions, and eventually through individual 
changesets to find the patch that causes the change in behavior. It has 
the heading of:

ChangeSet@1.914.91.10, 2003-02-06 12:49:30-08:00, mingo@elte.hu
  [PATCH] signal-fixes-2.5.59-A4
  
and can otherwise be seen here:

http://linux.bkbits.net:8080/linux-2.5/cset@1.914.91.10?nav=index.html|ChangeSet@-4w


Unfortunately, it is quite a large diff, and I am quite happy maintaining 
my ignorance of the signal code. However, I'm wondering if there is 
anything to do be done about. I am more than happy to upgrade the relevant 
software, though I am wondering if the change in behavior was intentional.


Thanks,

	-pat


