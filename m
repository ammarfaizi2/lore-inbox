Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262650AbVAPX4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262650AbVAPX4a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 18:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbVAPX4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 18:56:30 -0500
Received: from mail.joq.us ([67.65.12.105]:57477 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262650AbVAPX40 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 18:56:26 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Chris Wright <chrisw@osdl.org>, Matt Mackall <mpm@selenic.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, arjanv@redhat.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <200501111305.j0BD58U2000483@localhost.localdomain>
	<20050111191701.GT2940@waste.org>
	<20050111125008.K10567@build.pdx.osdl.net>
	<20050111205809.GB21308@elte.hu>
	<20050111131400.L10567@build.pdx.osdl.net>
	<20050111212719.GA23477@elte.hu> <87fz15j325.fsf@sulphur.joq.us>
	<20050115134922.GA10114@elte.hu> <874qhiwb1q.fsf@sulphur.joq.us>
	<871xcmuuu4.fsf@sulphur.joq.us> <20050116231307.GC24610@elte.hu>
From: "Jack O'Quin" <joq@io.com>
Date: Sun, 16 Jan 2005 17:57:23 -0600
In-Reply-To: <20050116231307.GC24610@elte.hu> (Ingo Molnar's message of
 "Mon, 17 Jan 2005 00:13:07 +0100")
Message-ID: <87vf9xdj18.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> * Jack O'Quin <joq@io.com> wrote:
>> According to the manpage, nice(2) is per-process not per-thread.  That
>> does not give the granularity we need. 

Ingo Molnar <mingo@elte.hu> writes:
> the manpage is incorrect - sys_nice() is per-thread. (Btw., you could
> use setpriority() too.)

OK.  Where is this stuff documented?

BTW, I think this violates POSIX, which states...

  The nice value set with nice() shall be applied to the process. If
  the process is multi-threaded, the nice value shall affect all
  system scope threads in the process.

(It does not affect SCHED_FIFO or SCHED_RR threads, however.)

Is it possible to call sched_setscheduler() with a thread ID instead
of a pid?  That's what I really need.  JACK sets and resets the thread
priorities from a different thread.
-- 
  joq
