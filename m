Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbTJ0XhJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 18:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263770AbTJ0XhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 18:37:09 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:29459 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263769AbTJ0Xgz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 18:36:55 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Linux 2.6.0-test9
Date: 27 Oct 2003 23:26:44 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bnk9jk$m05$1@gatekeeper.tmr.com>
References: <UTC200310260116.h9Q1GdR00982.aeb@smtp.cwi.nl> <Pine.LNX.4.44.0310252237510.6370-100000@home.osdl.org>
X-Trace: gatekeeper.tmr.com 1067297204 22533 192.168.12.62 (27 Oct 2003 23:26:44 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0310252237510.6370-100000@home.osdl.org>,
Linus Torvalds  <torvalds@osdl.org> wrote:
| 
| On Sun, 26 Oct 2003 Andries.Brouwer@cwi.nl wrote:
| > 
| > I have run 2.6.0-test6 without any problems. Switched
| > to 2.6.0-test9 today. Something involving job control
| > or so is broken. Several of my remote xterms hang.
| 
| Btw, this one sounds like a known bug in bash.
| 
| The bash bug does bad things when setting up pipelines of processes, and
| it assigns the process groups in the wrong order. This causes the tty
| layer to send SIGTTOU if the process touches the tty at just the right
| time, which in turn causes processes to become stuck in STOPPED state.
| It's very timing sensitive, and it apparently became easier to trigger
| within the last month or so, probably because of the scheduler
| interactivity changes.
| 
| You can trigger it under 2.4.x, and in fact it seems to be reasonably easy 
| to see with
| 
| 	while true ; do date | less -E ; done
| 
| which will cause processes to become stuck in stopped state after a while 
| (but because of the timing issues it's not 100% repeatable - you may 
| have to do this for a while).
| 
| You can work around it by building basb without the "PGRP_PIPE" config
| option (which may cause other issues), but Ernie Petrides also had a
| proper fix for it in the bash sources. Last I say (this was end of
| September), Chet Ramey acknowledged the bug but hadn't yet put it in
| standard bash sources.

Suggestion: when the real 2.6.0 comes out, it would be very helpful to
have a document which lists what is needed to upgrade from 2.4 to 2.6
and where to get it. And that the document include information like this
patch you mention, and whatever information is needed to help people
running major distributions.

If the idea is to tell people to read the post-Halowe'en doc and a year
of LKML, it is much the same as telling people to wait for a
distribution. I kept great notes as I built several RH 7.3 and 8.0
machines into 2.6 functionality, and I find that things have moved,
tricks don't work, versions have changed, etc. So a list from the
current Redhat, SuSE, Debian and Slackware at minimum would save people
a lot of problems. Not a major handhold for the clueless, just a list
of issues (emphasis because some people will claim I'm suggesting much
more than I said or meant).

| It's definitely not a kernel bug. I chased it for a while myself, and 
| Ernie proved it quite conclusively.

I found that child-run-first broke some code, not that I wrote but
that I certainly maintained without seeing the subtle issues. There will
be people who claim bugs in forked and threaded cooperating processes.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
