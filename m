Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263958AbTJFDHK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 23:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263959AbTJFDHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 23:07:10 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:30213 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263958AbTJFDHH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 23:07:07 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
Date: 6 Oct 2003 02:57:30 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <blqlmq$dgn$1@gatekeeper.tmr.com>
References: <Pine.LNX.4.44.0310010803530.23860-100000@home.osdl.org> <3F7B9CF9.4040706@redhat.com> <blgol5$vd0$1@news.cistron.nl>
X-Trace: gatekeeper.tmr.com 1065409050 13847 192.168.12.62 (6 Oct 2003 02:57:30 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <blgol5$vd0$1@news.cistron.nl>,
Miquel van Smoorenburg <miquels@cistron.nl> wrote:
| In article <3F7B9CF9.4040706@redhat.com>,
| Ulrich Drepper  <drepper@redhat.com> wrote:
| >Linus Torvalds wrote:
| >
| >> I think /proc/self most likely _should_ point into the thread, not the 
| >> task. 
| >
| >As much as I want to not see this, I fear I have to agree.
| >
| >There is, for instance, no guarantee that all CLONE_THREAD clones also
| >have CLONE_FILES set.  Then using /proc/self/%d for some thread-local
| >file descriptor will return the process group leaders file descriptor,
| >not the own.
| 
| How about use /proc/self/task/self/fd/%d if /proc/self/task/self
| exists, /proc/self/fd/%d otherwise ?

Let me bend your suggestion slightly and suggest that for a task which
shares fd with the leader, /proc/N/task/M/fd would be a symlink to
/proc/M/fd, and if fd's were not shared it would be a directory. That
would make it easy for programs like lsof to know when to look and whn
not.

This doesn't prevent your suggestion which triggered the thought, it
just seems to avoid having a boatload of symlinks for the most common
case when one would do.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
