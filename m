Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261539AbSIXCrJ>; Mon, 23 Sep 2002 22:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261540AbSIXCrJ>; Mon, 23 Sep 2002 22:47:09 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:59122 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S261539AbSIXCrI>; Mon, 23 Sep 2002 22:47:08 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <15759.53896.973330.270617@wombat.chubb.wattle.id.au>
Date: Tue, 24 Sep 2002 12:48:40 +1000
To: Mark Mielke <mark@mark.mielke.cc>
Cc: =?iso-8859-1?Q?Peter_W=E4chtler?= <pwaechtler@mac.com>,
       Ingo Molnar <mingo@elte.hu>, Larry McVoy <lm@bitmover.com>,
       Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
In-Reply-To: <987738530@toto.iv>
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Mark" == Mark Mielke <mark@mark.mielke.cc> writes:

Mark> On Mon, Sep 23, 2002 at 11:08:53PM +0200, Peter Wächtler wrote:
Mark> Think of it this way... two threads are blocked on different
Mark> resources...  The currently executing thread reaches a point
Mark> where it blocks.

Mark>     OS threads: 1) thread#1 invokes a system call 2) OS switches
Mark> tasks to thread#2 and returns from blocking

Mark>     user-space threads: 1) thread#1 invokes a system call 2)
Mark> thread#1 returns from system call, EWOULDBLOCK 3) thread#1
Mark> invokes poll(), select(), ioctl() to determine state 4) thread#1
Mark> returns from system call 5) thread#1 switches stack pointer to
Mark> be thread#2 upon determination that the resource thread#2 was
Mark> waiting on is ready.

No way!  THe Solaris M:N model notices when all threads belonging to a
process have blocked, and wakes up the master thread, which can then
create a new kernel thread if there are any user-mode threads that can
do work.

PeterC
