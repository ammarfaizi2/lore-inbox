Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271399AbRIJRUy>; Mon, 10 Sep 2001 13:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271401AbRIJRUo>; Mon, 10 Sep 2001 13:20:44 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:47605 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S271399AbRIJRUc>;
	Mon, 10 Sep 2001 13:20:32 -0400
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15260.63089.955454.709358@napali.hpl.hp.com>
Date: Mon, 10 Sep 2001 10:20:49 -0700
To: Andrea Arcangeli <andrea@suse.de>
Cc: David Mosberger <davidm@hpl.hp.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] proposed fix for ptrace() SMP race
In-Reply-To: <20010908191108.B11329@athlon.random>
In-Reply-To: <200109062300.QAA27430@napali.hpl.hp.com>
	<20010907021900.L11329@athlon.random>
	<15256.6038.599811.557582@napali.hpl.hp.com>
	<20010907032801.N11329@athlon.random>
	<15256.22858.57091.769101@napali.hpl.hp.com>
	<20010907152858.O11329@athlon.random>
	<15256.59715.523045.796917@napali.hpl.hp.com>
	<20010908191108.B11329@athlon.random>
X-Mailer: VM 6.76 under Emacs 20.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sat, 8 Sep 2001 19:11:08 +0200, Andrea Arcangeli <andrea@suse.de> said:

  Andrea> On Fri, Sep 07, 2001 at 08:35:31AM -0700, David Mosberger
  Andrea> wrote:
  >> Also, other signals will still wake up the task.  Yes, it won't
  >> get very far as do_signal() will notify the parent instead, but
  >> still, the task will run and that could be enough to create some
  >> race condition.

  Andrea> this is the real issue, agreed.

Good.

  Andrea> However still I don't like the cpus_allowed racy approch. I
  Andrea> either prefer to force the deschedule with a new ptrace
  Andrea> bitflag with new hooks in the scheduler or with a blocker
  Andrea> (delayer) to the signals again with a new ptrace bitflag but
  Andrea> in this case with hooks in the signal code. I think putting
  Andrea> the hooks in the signal code is better.

Yes, though I don't really see how you could do this without any
change to the scheduler.

  Andrea> BTW, checking this stuff I found two bugs, one is the check
  Andrea> for cpus_allowed before calling reschedule_idle, such check
  Andrea> has to be removed, then it also seems the signals seems to
  Andrea> wakeup the task two times unless I've overlooked something.

  Andrea> You may want to make a new patch at the light of those
  Andrea> considerations otherwise I'll put this in my todo list once
  Andrea> more important things are solved.

Why don't you keep it on your todo list.  I too have a couple of other
things I need to finish first so it will be a while before I'd get to
this (not before November, I'd guess).  But I'll keep it in mind as
well.

Thanks,

	--david
