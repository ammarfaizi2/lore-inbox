Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267581AbTBFT6i>; Thu, 6 Feb 2003 14:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267598AbTBFT6i>; Thu, 6 Feb 2003 14:58:38 -0500
Received: from hera.cwi.nl ([192.16.191.8]:23205 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S267581AbTBFT6d>;
	Thu, 6 Feb 2003 14:58:33 -0500
From: Andries.Brouwer@cwi.nl
Date: Thu, 6 Feb 2003 21:08:10 +0100 (MET)
Message-Id: <UTC200302062008.h16K8Aa23600.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: syscall documentation (2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The next new page is futex.2.

Comments welcome.
Andries
aeb@cwi.nl

-------------------------------
NAME
       futex - Fast Userspace Locking system call

SYNOPSIS
       #include <linux/futex.h>

       #include <sys/time.h>

       int  sys_futex (void *futex, int op, int val, const struct
       timespec *timeout);

DESCRIPTION
       The sys_futex system call provides a method for a  program
       to  wait  for  a value at a given address to change, and a
       method to wake up anyone waiting on a  particular  address
       (while  the addresses for the same memory in separate pro­
       cesses may not be equal, the kernel maps  them  internally
       so the same memory mapped in different locations will cor­
       respond for sys_futex calls).  It  is  typically  used  to
       implement  the  contended case of a lock in shared memory,
       as described in futex(4).

       When a futex(4) operation did not  finish  uncontended  in
       userspace,  a call needs to be made to the kernel to arbi­
       trate. Arbitration can either  mean  putting  the  calling
       process to sleep or, conversely, waking a waiting process.

       Callers of this function are expected  to  adhere  to  the
       semantics  as  set  out  in  futex(4).  As these semantics
       involve writing non-portable assembly  instructions,  this
       in  turn  probably  means  that most users will in fact be
       library authors and not general application developers.

       The futex argument needs to point to  an  aligned  integer
       which  stores  the  counter.   The operation to execute is
       passed via the op parameter, along with a value val.

       Three operations are currently defined:

       FUTEX_WAIT
              This operation atomically verifies that  the  futex
              address  still contains the value given, and sleeps
              awaiting FUTEX_WAKE on this futex address.  If  the
              timeout argument is non-NULL, its contents describe
              the maximum duration of the wait, which is infinite
              otherwise.   For futex(4), this call is executed if
              decrementing the count gave a negative value (indi­
              cating  contention),  and  will sleep until another
              process   releases  the  futex  and  executes   the
              FUTEX_WAKE operation.

       FUTEX_WAKE
              This  operation wakes at most val processes waiting
              on this futex address (ie. inside FUTEX_WAIT).  For
              futex(4),  this  is  executed  if  incrementing the
              count showed that  there  were  waiters,  once  the
              futex  value  has been set to 1 (indicating that it
              is available).

       FUTEX_FD
              To support a asynchronous wakeups,  this  operation
              associates  a  file  descriptor  with  a futex.  If
              another process executes a FUTEX_WAKE, the  process
              will  receive  the signal number that was passed in
              val. The calling process must  close  the  returned
              file descriptor after use.

              To  prevent race conditions, the caller should test
              if the futex has been upped after FUTEX_FD returns.

RETURN VALUE
       Depending  on  which  operation was executed, the returned
       value can have differing meanings.

       FUTEX_WAIT
              Returns 0 if the process was woken by a  FUTEX_WAKE
              call. In case of timeout, ETIMEDOUT is returned. If
              the futex was not equal to the expected value,  the
              operation  returns  EWOULDBLOCK.  Signals (or other
              spurious wakeups) cause FUTEX_WAIT to return EINTR.

       FUTEX_WAKE
              Returns the number of processes woken up.

       FUTEX_FD
              Returns the new file descriptor associated with the
              futex.

NOTES
       To reiterate, bare futexes are not intended as an easy  to
       use  abstraction  for end-users. Implementors are expected
       to be assembly literate and to have read  the  sources  of
       the futex userspace library referenced below.

AUTHORS
       Futexes  were  designed  and  worked on by Hubertus Franke
       (IBM Thomas J. Watson Research Center), Matthew  Kirkwood,
       Ingo  Molnar  (Red Hat) and Rusty Russell (IBM Linux Tech­
       nology Center). This page written by bert hubert.

VERSIONS
       Initial futex support was merged in Linux 2.5.7  but  with
       different  semantics  from those described above.  Current
       semantics are available from Linux 2.5.40 onwards.

SEE ALSO
       futex(4), `Fuss,  Futexes  and  Furwocks:  Fast  Userlevel
       Locking  in Linux' (proceedings of the Ottawa Linux Sympo­
       sium  2002),  futex   example   library,   futex-*.tar.bz2
       <URL:ftp://ftp.nl.kernel.org:/pub/linux/kernel/peo­
       ple/rusty/>.

                         31 December 2002                FUTEX(2)
