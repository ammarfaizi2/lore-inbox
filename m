Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262735AbVAQJTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262735AbVAQJTK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 04:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262738AbVAQJTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 04:19:10 -0500
Received: from speedy.student.utwente.nl ([130.89.163.131]:10205 "EHLO
	speedy.student.utwente.nl") by vger.kernel.org with ESMTP
	id S262735AbVAQJTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 04:19:07 -0500
Date: Mon, 17 Jan 2005 10:17:40 +0100
To: "Jack O'Quin" <joq@io.com>
Cc: Ingo Molnar <mingo@elte.hu>, Chris Wright <chrisw@osdl.org>,
       Matt Mackall <mpm@selenic.com>, Paul Davis <paul@linuxaudiosystems.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, arjanv@redhat.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050117091740.GA21384@speedy.student.utwente.nl>
References: <20050111125008.K10567@build.pdx.osdl.net> <20050111205809.GB21308@elte.hu> <20050111131400.L10567@build.pdx.osdl.net> <20050111212719.GA23477@elte.hu> <87fz15j325.fsf@sulphur.joq.us> <20050115134922.GA10114@elte.hu> <874qhiwb1q.fsf@sulphur.joq.us> <871xcmuuu4.fsf@sulphur.joq.us> <20050116231307.GC24610@elte.hu> <87vf9xdj18.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87vf9xdj18.fsf@sulphur.joq.us>
User-Agent: Mutt/1.5.6+20040907i
From: Sytse Wielinga <s.b.wielinga@student.utwente.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2005 at 05:57:23PM -0600, Jack O'Quin wrote:
> > * Jack O'Quin <joq@io.com> wrote:
> >> According to the manpage, nice(2) is per-process not per-thread.  That
> >> does not give the granularity we need. 
> 
> Ingo Molnar <mingo@elte.hu> writes:
> > the manpage is incorrect - sys_nice() is per-thread. (Btw., you could
> > use setpriority() too.)
> 
> OK.  Where is this stuff documented?
> 
> BTW, I think this violates POSIX, which states...
> 
>   The nice value set with nice() shall be applied to the process. If
>   the process is multi-threaded, the nice value shall affect all
>   system scope threads in the process.

We are talking about two different things here. POSIX is just about API and
has, correct me if I'm wrong, nothing to do with system calls whatsoever. The
manpage nice(2) is about the libc library call nice(), which is per-process,
which it should be according to POSIX. The system call, called sys_nice() in C,
is per-thread. Apparently glibc or some thread library contains some magic to
make the translation.

Sytse
