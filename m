Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264914AbRFZMwz>; Tue, 26 Jun 2001 08:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264913AbRFZMwq>; Tue, 26 Jun 2001 08:52:46 -0400
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:30080 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S264912AbRFZMw0>; Tue, 26 Jun 2001 08:52:26 -0400
Message-ID: <3B38860D.8E07353D@kegel.com>
Date: Tue, 26 Jun 2001 05:54:37 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: A signal fairy tale
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once upon a time a hacker named Xman
wrote a library that used aio, and decided
to use sigtimedwait() to pick up completion
notifications.  It worked well, and his I/O
was blazing fast (since was using a copy
of Linux that was patched to have good aio).
But when he tried to integrate his library
into a large application someone else had
written, woe! that application's use of signals
conflicted with his library.  "Fsck!" said Xman.
At that moment a fairy appeared, and said
"Young man, watch your language, or I'm going to
have to turn you into a goon!  I'm the good fairy Eunice.  
Can I help you?"  Xman explained his problem to Eunice,
who smiled and said "All you need is right here,
just type 'man 2 sigopen'".  Xman did, and saw:

 
SIGOPEN(2)        Linux Programmer's Manual           SIGOPEN(2)
 
NAME
       sigopen - open a signal as a file descriptor
 
SYNOPSIS
       #include <signal.h>
 
       int sigopen(int signum);
 
DESCRIPTION
       The sigopen system call opens signal number signum as a file descriptor.
       That signal is no longer delivered normally or available for pickup
       with sigwait() et al.  Instead, it must be picked up by calling
       read() on the file descriptor returned by sigwait(); the buffer passed to
       read() must have a size which is a multiple of sizeof(siginfo_t).
       Multiple signals may be picked up with a single call to read().
       When that file descriptor is closed, the signal is available once more 
       for traditional use.
       A signal number cannot be opened more than once concurrently; sigopen() 
       thus provides a way to avoid signal usage clashes in large programs.

RETURN VALUE
       signal returns the new file descriptor, or -1 on error (in which case, errno
       is set appropriately).

ERRORS
       EWOULDBLOCK signal is already open

NOTES                                
       read() will block when reading from a file descriptor opened by sigopen()
       until a signal is available unless fcntl(fd, F_SETFL, O_NONBLOCK) is called
       to set it into nonblocking mode.

HISTORY
       sigopen() first appeared in the 2.5.2 Linux kernel.

Linux                      July, 2001                         1           

When he finished reading, he knew just how to solve his
problem, and he lived happily ever after.  

The End.

- Dan
