Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbWAKMha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbWAKMha (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 07:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWAKMh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 07:37:29 -0500
Received: from a.relay.invitel.net ([62.77.203.3]:20099 "EHLO
	a.relay.invitel.net") by vger.kernel.org with ESMTP
	id S1751446AbWAKMh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 07:37:27 -0500
Date: Wed, 11 Jan 2006 13:37:45 +0100
From: =?iso-8859-1?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: linux-kernel@vger.kernel.org
Subject: OT: fork(): parent or child should run first?
Message-ID: <20060111123745.GB30219@lgb.hu>
Reply-To: lgb@lgb.hu
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Operating-System: vega Linux 2.6.12-10-686 i686
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The following problem may be simple for you, so I hope someone can answer
here. We've got a complex software using child processes and a table
to keep data of them together, like this:

childs[n].pid=fork();

where "n" is an integer contains a free "slot" in the childs struct array.

I also handle SIGCHLD in the parent and signal handler  searches the childs
array for the pid returned by waitpid(). However here is my problem. The
child process can be fast, ie exits before scheduler of the kernel give
chance the parent process to run, so storing pid into childs[n].pid in the
parent context is not done yet. Child may exit, than scheduler gives control
to the signal handler before doing the store of the pid (if child run for
more time, eg 10 seconds it works of course). So it's impossible to store
child pids and search by that information in eg the signal handler? It's
quite problematic, since the code uses blocking I/O a lot, so other
solutions (like searching in childs[] in the main program and not in signal
handler) would require to recode the whole project. The problem can be
avoided with having a fork() run the PARENT first, but I thing this is done
by the scheduler so it's a kernel issue. Also the problem that source should
be portable between Linux and Solaris ...

Sorry for disturbing the list with this kind of problem but I can't find
any solution elsewhere.

Thanks a lot,

-- 
- Gábor
