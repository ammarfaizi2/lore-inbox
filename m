Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132719AbRDNCDt>; Fri, 13 Apr 2001 22:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132722AbRDNCDj>; Fri, 13 Apr 2001 22:03:39 -0400
Received: from cy57850-a.rdondo1.ca.home.com ([24.5.132.106]:49678 "HELO
	firewall.philstone.com") by vger.kernel.org with SMTP
	id <S132719AbRDNCDW>; Fri, 13 Apr 2001 22:03:22 -0400
Date: Fri, 13 Apr 2001 19:00:20 -0700
From: Christopher Smith <x@xman.org>
To: Dan Maas <dmaas@dcine.com>, linux-kernel@vger.kernel.org
Cc: cj@cjcj.com, bart@jukie.net
Subject: Re: Asynchronous IO
Message-ID: <37480000.987213620@hellman>
In-Reply-To: <009801c0c3f6$69d45c70$0701a8c0@morph>
X-Mailer: Mulberry/2.0.8 (Linux/x86 Demo)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Friday, April 13, 2001 04:45:07 -0400 Dan Maas <dmaas@dcine.com> wrote:
> IIRC the problem with implementing asynchronous *disk* I/O in Linux today
> is that the filesystem code assumes synchronous I/O operations that block
> the whole process/thread. So implementing "real" asynch I/O (without the
> overhead of creating a process context for each operation) would require
> re-writing the filesystems as non-blocking state machines. Last I heard
> this was a long-term goal, but nobody's done the work yet (aside from
> maybe the SGI folks with XFS?). Or maybe I don't know what I'm talking
> about...

If the FS supports generic read then this is not a problem. This is what 
SGI's KAIO does as well as Bart's work.

> Bart, glad to hear you are working on an event interface, sounds cool! One
> feature that I really, really, *really* want to see implemented is the
> ability to block on a set of any "waitable kernel objects" with one
> syscall - not just file descriptors, but also SysV semaphores and message
> queues, UNIX signals and child proceses, file locks, pthreads condition
> variables, asynch disk I/O completions, etc. I am dying for a clean way to
> accomplish this that doesn't require more than one thread... (Win32 and
> FreeBSD kick our butts here with MsgWaitForMultipleObjects() and
> kevent()...) IMHO cleaning up this API deficiency is just as important as
> optimizing the extreme case of socket I/O with zillions of file
> descriptors...

Actually, sigwaitinfo() has zero problem waiting on muliple signals. If you 
are using real-time signals each signal can pass a pointer to the relevant 
object, so even if you're only blocking on a single signal you can receive 
info about several objects.

<insert thread about how signals suck here>

--Chris
