Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271684AbRIHRKs>; Sat, 8 Sep 2001 13:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271697AbRIHRKi>; Sat, 8 Sep 2001 13:10:38 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:11597 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S271684AbRIHRK0>; Sat, 8 Sep 2001 13:10:26 -0400
Date: Sat, 8 Sep 2001 19:11:08 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: David Mosberger <davidm@hpl.hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] proposed fix for ptrace() SMP race
Message-ID: <20010908191108.B11329@athlon.random>
In-Reply-To: <200109062300.QAA27430@napali.hpl.hp.com> <20010907021900.L11329@athlon.random> <15256.6038.599811.557582@napali.hpl.hp.com> <20010907032801.N11329@athlon.random> <15256.22858.57091.769101@napali.hpl.hp.com> <20010907152858.O11329@athlon.random> <15256.59715.523045.796917@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15256.59715.523045.796917@napali.hpl.hp.com>; from davidm@hpl.hp.com on Fri, Sep 07, 2001 at 08:35:31AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2001 at 08:35:31AM -0700, David Mosberger wrote:
> Also, other signals will still wake up the task.  Yes, it won't get
> very far as do_signal() will notify the parent instead, but still, the
> task will run and that could be enough to create some race condition.

this is the real issue, agreed.

However still I don't like the cpus_allowed racy approch. I either
prefer to force the deschedule with a new ptrace bitflag with new hooks
in the scheduler or with a blocker (delayer) to the signals again with a
new ptrace bitflag but in this case with hooks in the signal code. I
think putting the hooks in the signal code is better.

BTW, checking this stuff I found two bugs, one is the check for
cpus_allowed before calling reschedule_idle, such check has to be
removed, then it also seems the signals seems to wakeup the task two
times unless I've overlooked something.

You may want to make a new patch at the light of those considerations
otherwise I'll put this in my todo list once more important things are
solved.

Andrea
