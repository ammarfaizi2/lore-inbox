Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289484AbSC0V2g>; Wed, 27 Mar 2002 16:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288801AbSC0V2Z>; Wed, 27 Mar 2002 16:28:25 -0500
Received: from abraham.CS.Berkeley.EDU ([128.32.247.199]:3088 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP
	id <S288012AbSC0V2U>; Wed, 27 Mar 2002 16:28:20 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: Linux Kernel Patch; setpriority
Date: 27 Mar 2002 21:19:37 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <a7td19$em8$1@abraham.cs.berkeley.edu>
In-Reply-To: <3CA232A1.7040702@cisco.com>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1017263977 15048 128.32.45.153 (27 Mar 2002 21:19:37 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 27 Mar 2002 21:19:37 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What's the argument why this change to the semantics of setpriority()
is a reasonable one to make?

Previously, non-root users [*] could not decrement their current priority
value (i.e., make their own processes run faster).  Now you're allowing
processes to decrement the current priority, so long as they stay within
the range 0..19.  But what if the priority had been increased by the
scheduler because this process was running a long time and taking up
a lot of CPU time?  The proposed change to the setpriority() interface
allows such a process to "cheat" and get more CPU time than it ought to
be able to receive.

It seems to me that the scheduler should be able to renice a CPU hog
to make sure that interactive processes receive good performance, and
your proposed change circumvents this.  It's one thing for a process
to decrement its priority if this process was the one who voluntarily
incremented it earlier; it's another thing if the priority value was
incremented forcibly by the OS.  If this is correct, the proposed change
doesn't look so good.

Am I overlooking something?
