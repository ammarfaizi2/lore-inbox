Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261894AbTANOgm>; Tue, 14 Jan 2003 09:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263039AbTANOgm>; Tue, 14 Jan 2003 09:36:42 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:46856 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S261894AbTANOgk>; Tue, 14 Jan 2003 09:36:40 -0500
Message-ID: <3E2422B5.B5F8AD31@aitel.hist.no>
Date: Tue, 14 Jan 2003 15:46:13 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.5.58 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Repeatable scheduling oddity in 2.5.5x?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I occationally use the program dvipdfm for creating pdf-files.
It works for a while, then it just pauses.  The process (and
child processes) sleeps and the load falls to 0 for no reason.

Moving the mouse around or holding down a keyboard key (even shift)
gets it going again.  Note that the windows with the "stuck"
processes don't need to have focus.
Pinging the machine don't seem to help, so it isn't
purely an interrupt thing.

This is not a case of starvation, the cpu is free but the kernel
seems to want some mouse/keyboard activity in order to hand out
timeslices.  This is hopeless if I'm logged in via ssh.  Causing massive
disk activity might help, but usually not.  Logging in as root
and giving the processes a massive priority boost don't
change a thing.

I don't think it is a timeout either, this is not a portable and
the problem can trigger in 10 seconds or so after giving the
command.

The machine is nowhere near OOM either.

ps and top just show the relevant processes sleeping along with
other processes that don't have any input to process.
But these have. :-(

I see this with 2.5.58 and 2.5.55, UP with preempt.

dvipdfm reads a .dvi file, and use a pipe with zcat and
gv to process postscript figures.  There seems to always
be such a pipe active when it gets stuck.

I don't think a programming error in these programs
can _know_ wether or not I'm wiggling the mouse,
that's why I suspect the kernel.

Is there anything more I could do to try tracking this down?
I have no problems repeating it.

Helge Hafting
