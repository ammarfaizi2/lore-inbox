Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265272AbRF0GSf>; Wed, 27 Jun 2001 02:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265273AbRF0GSZ>; Wed, 27 Jun 2001 02:18:25 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:41390 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S265272AbRF0GSR>; Wed, 27 Jun 2001 02:18:17 -0400
Date: Wed, 27 Jun 2001 11:51:36 +0530 (IST)
From: Balbir Singh <balbir.singh@wipro.com>
To: Dan Kegel <dank@kegel.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: A signal fairy tale
In-Reply-To: <3B38860D.8E07353D@kegel.com>
Message-ID: <Pine.SV4.4.21.0106271143430.23526-100000@wipro.wipsys.sequent.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shouldn't there be a sigclose() and other operations to make the API
orthogonal. sigopen() should be selective about the signals it allows
as argument. Try and make sigopen() thread specific, so that if one
thread does a sigopen(), it does not imply it will do all the signal
handling for all the threads.

Does using sigopen() imply that signal(), sigaction(), etc cannot be used.
In the same process one could do a sigopen() in the library, but the
process could use sigaction()/signal() without knowing what the library
does (which signals it handles, etc).

Let me know, when somebody has a patch or needs help, I would like to
help or take a look at it.

Balbir

|NAME
|       sigopen - open a signal as a file descriptor
| 
|SYNOPSIS
|       #include <signal.h>
| 
|       int sigopen(int signum);
| 
|DESCRIPTION
|       The sigopen system call opens signal number signum as a file descriptor.
|       That signal is no longer delivered normally or available for pickup
|       with sigwait() et al.  Instead, it must be picked up by calling
|       read() on the file descriptor returned by sigwait(); the buffer passed to
|       read() must have a size which is a multiple of sizeof(siginfo_t).
|       Multiple signals may be picked up with a single call to read().
|       When that file descriptor is closed, the signal is available once more 
|       for traditional use.
|       A signal number cannot be opened more than once concurrently; sigopen() 
|       thus provides a way to avoid signal usage clashes in large programs.
|
|RETURN VALUE
|       signal returns the new file descriptor, or -1 on error (in which case, errno
|       is set appropriately).
|
|ERRORS
|       EWOULDBLOCK signal is already open
|
|NOTES                                
|       read() will block when reading from a file descriptor opened by sigopen()
|       until a signal is available unless fcntl(fd, F_SETFL, O_NONBLOCK) is called
|       to set it into nonblocking mode.
|
|HISTORY
|       sigopen() first appeared in the 2.5.2 Linux kernel.
|
|Linux                      July, 2001                         1           
|

