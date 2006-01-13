Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161378AbWAMIKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161378AbWAMIKB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 03:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161455AbWAMIKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 03:10:01 -0500
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:16359
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1161378AbWAMIKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 03:10:00 -0500
Date: Fri, 13 Jan 2006 00:07:34 -0800
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       david singleton <dsingleton@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: RT Mutex patch and tester [PREEMPT_RT]
Message-ID: <20060113080734.GA22091@gnuppy.monkey.org>
References: <20060112113316.GA14416@gnuppy.monkey.org> <Pine.LNX.4.44L0.0601121337480.30644-100000@lifa03.phys.au.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0601121337480.30644-100000@lifa03.phys.au.dk>
User-Agent: Mutt/1.5.11
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 01:54:23PM +0100, Esben Nielsen wrote:
> turnstiles? What is that?

http://www.freebsd.org/cgi/cvsweb.cgi/src/sys/kern/subr_turnstile.c

Please, read. Now tell me or not if that looks familiar ? :)

Moving closer an implementation is arguable, but it is something that
should be considered somewhat since folks in both the Solaris (and
FreeBSD) communities have given a lot more consideration to these issues.

The stack allocated objects are fine for now. Priority inheritance
chains should never get long with a fine grained kernel, so the use
of a stack allocated object and migrating pi-ed waiters should not
be a major real world issue in Linux yet.

Folks should also consider using an adaptive spin in the __grab_lock() (sp?)
related loops as a possible way of optimizing away the immediate blocks.
FreeBSD actually checks the owner of a lock aacross another processor
to see if it's actively running, "current", and will block or wait if
it's running or not respectively. It's pretty trivial code, so it's
not a big issue to implement. This is ignoring the CPU local storage
issues.

bill

