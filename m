Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132704AbRDMIkn>; Fri, 13 Apr 2001 04:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135441AbRDMIkX>; Fri, 13 Apr 2001 04:40:23 -0400
Received: from mailout2-0.nyroc.rr.com ([24.92.226.121]:28877 "EHLO
	mailout2-0.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S132704AbRDMIkN>; Fri, 13 Apr 2001 04:40:13 -0400
Message-ID: <009801c0c3f6$69d45c70$0701a8c0@morph>
From: "Dan Maas" <dmaas@dcine.com>
To: <linux-kernel@vger.kernel.org>
Cc: <cj@cjcj.com>, <bart@jukie.net>
Subject: Re: Asynchronous IO
Date: Fri, 13 Apr 2001 04:45:07 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IIRC the problem with implementing asynchronous *disk* I/O in Linux today is
that the filesystem code assumes synchronous I/O operations that block the
whole process/thread. So implementing "real" asynch I/O (without the
overhead of creating a process context for each operation) would require
re-writing the filesystems as non-blocking state machines. Last I heard this
was a long-term goal, but nobody's done the work yet (aside from maybe the
SGI folks with XFS?). Or maybe I don't know what I'm talking about...

Bart, glad to hear you are working on an event interface, sounds cool! One
feature that I really, really, *really* want to see implemented is the
ability to block on a set of any "waitable kernel objects" with one
syscall - not just file descriptors, but also SysV semaphores and message
queues, UNIX signals and child proceses, file locks, pthreads condition
variables, asynch disk I/O completions, etc. I am dying for a clean way to
accomplish this that doesn't require more than one thread... (Win32 and
FreeBSD kick our butts here with MsgWaitForMultipleObjects() and
kevent()...) IMHO cleaning up this API deficiency is just as important as
optimizing the extreme case of socket I/O with zillions of file
descriptors...

Regards,
Dan

