Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130719AbQKCTtV>; Fri, 3 Nov 2000 14:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131433AbQKCTtL>; Fri, 3 Nov 2000 14:49:11 -0500
Received: from neuron.moberg.com ([209.152.208.195]:63246 "EHLO
	neuron.moberg.com") by vger.kernel.org with ESMTP
	id <S130719AbQKCTs6>; Fri, 3 Nov 2000 14:48:58 -0500
Message-ID: <3A0316D1.C96AADFC@moberg.com>
Date: Fri, 03 Nov 2000 14:49:37 -0500
From: george@moberg.com
Organization: Moberg Research, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ulrich Drepper <drepper@cygnus.com>, linux-kernel@vger.kernel.org
Subject: Re: Can EINTR be handled the way BSD handles it? -- a plea from a 
 user-land  programmer...
In-Reply-To: <3A03120A.DFC62AD5@moberg.com> <m3y9z0g7wp.fsf@otr.mynet.cygnus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> 
> george@moberg.com writes:
> 
> > Can we _PLEASE_PLEASE_PLEASE_ not do this anymore and have the kernel do
> > what BSD does:  re-start the interrupted call?
> 
> This is crap.  Returning EINTR is necessary for many applications.
> 
> --
> ---------------.                          ,-.   1325 Chesapeake Terrace
> Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
> Red Hat          `--' drepper at redhat.com   `------------------------

After reading about SA_RESTART, ok.  However, couldn't those
applications that require it enable this behaviour explicitly?

The problem I'm having right now is with pthread_create() failing
because deep somewhere in either the kernel or glibc, nanosleep()
returns EINTR during said pthread_create() and pthread_create() fails.

I've got a multithreaded program written using gcc (2.95.2) and glibc
(2.1.3), and it's talking to a natively threaded Java program (tried
both Sun & Blackdown ports, both 1.2.2 and 1.3) on a 2.2.17 kernel.  The
C program is listening for incoming socket connections, and the Java
program is hammering on it with many parallel connect() calls.  After a
short, a bit random interval, pthread_create() will fail in either my
program, or deep in the Java VM.  I assume that the Java VM is using
pthread_create().

I don't mean to sound like a psycho on this, but I can't see why
SA_RESTART isn't the default behavior.  Maybe I'm missing something
somewhere.
--
George T. Talbot
<george at moberg dot com>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
