Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314459AbSHBRf3>; Fri, 2 Aug 2002 13:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315627AbSHBRfY>; Fri, 2 Aug 2002 13:35:24 -0400
Received: from fachschaft.cup.uni-muenchen.de ([141.84.250.61]:9478 "EHLO
	fachschaft.cup.uni-muenchen.de") by vger.kernel.org with ESMTP
	id <S314459AbSHBRfS>; Fri, 2 Aug 2002 13:35:18 -0400
Message-Id: <200208021738.g72HcCm02802@fachschaft.cup.uni-muenchen.de>
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: Linus Torvalds <torvalds@transmeta.com>,
       Benjamin LaHaise <bcrl@redhat.com>
Subject: Re: manipulating sigmask from filesystems and drivers
Date: Fri, 2 Aug 2002 19:33:44 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Roman Zippel <zippel@linux-m68k.org>,
       David Woodhouse <dwmw2@infradead.org>,
       David Howells <dhowells@redhat.com>, <alan@redhat.com>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0208020920120.18265-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0208020920120.18265-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> and then let code like generic_file_write() etc use other combinations
> than the two existing ones, ie
>
> 	(TASK_WAKEKILL | TASK_LOADAVG)
>
> results in a process that is woken up by signals that kill it (but not
> other signals), and is counted towards the loadaverage. Which is what we
> want in generic_file_read() (and _probably_ generic_file_write() as well,
> but that's slightly more debatable).
>
> (We'd also have to add a new way to test whether you've been killed, so
> that such users could use "process_killed()" instead of the
> "signal_pending()" that a INTERRUPTIBLE sleeper uses to test whether it
> should exit).
>
> This is the trivial way to get the best of both worlds - you can still
> kill a process that is in D wait (if that particular kernel path allows
> it), but you don't get process-visible semantic changes.

If you do this to generic_file_write() you change the semantics for the
parent process, which up to now can expect a change to a file
made by a single call to write() to be done either fully or not at all,
if there's no error.

So IMHO it would be better to limit this new kind of waiting to reading.

	Regards
		Oliver
