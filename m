Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263953AbTJFDBt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 23:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263954AbTJFDBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 23:01:49 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:28933 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263953AbTJFDBs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 23:01:48 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
Date: 6 Oct 2003 02:52:12 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <blqlcs$dfg$1@gatekeeper.tmr.com>
References: <1065139380.736.109.camel@cube> <Pine.LNX.4.44.0310021720510.7833-100000@home.osdl.org>
X-Trace: gatekeeper.tmr.com 1065408732 13808 192.168.12.62 (6 Oct 2003 02:52:12 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0310021720510.7833-100000@home.osdl.org>,
Linus Torvalds  <torvalds@osdl.org> wrote:
| 
| On 2 Oct 2003, Albert Cahalan wrote:
| > 
| > No. I mean "ban" like we ban CLONE_THREAD w/o CLONE_DETACHED.
| 
| No. Let's not do that.
| 
| We ban only things that do not make sense. That was true of trying to 
| share signal handlers with different address spaces. But it is _not_ true 
| of having separate file descriptors for different threads.
| 
| I don't imagine anybody cares _that_ deeply about fuser that it can't 
| afford to recurse into thread directories.
| 
| And it may or may not make sense to not have a "/proc/<nn>/task/<yy>/fd"
| directory at all if the thread shares file descriptors with the thread 
| group leader. That would be a fairly easy optimization.

I think Albert has a good point on performance, since nothing is using
the ability to have separate fd sets, I can't see it as a requirement.
However, I have an application which has a lot of files and sockets
open, and I think having the separation may make things far nicer when
not all the threads need have everything open.

But if there are going to be both kinds of threaded processes, there
should be a good way to tell if a program like lsof needs to chase every
thread or not. I'm not totally sure what Albert has in mind for
/proc/task, but if there were a way to create subdirs only for threads
with separate fd space, that would be one approach.

lsof is painful now, hopefully for things which share fd it can be much
faster.

And how does this new capability fit with SUS, if at all?
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
