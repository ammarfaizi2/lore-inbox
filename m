Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316587AbSEUU14>; Tue, 21 May 2002 16:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316588AbSEUU1z>; Tue, 21 May 2002 16:27:55 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:47787 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316587AbSEUU1y>; Tue, 21 May 2002 16:27:54 -0400
Date: Tue, 21 May 2002 15:27:48 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [RFC] POSIX personality
Message-ID: <64270000.1022012868@baldur.austin.ibm.com>
X-Mailer: Mulberry/2.2.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As part of improving support for POSIX multithreading I've been putting
together some patches to allow more things to be shared between tasks.
Right now this is accomplished via flags to clone() with one flag per
resource to be shared.  This usually translates to a data structure pointed
to out of task_struct, complete with reference count and lock.

In a discussion today an alternate idea was proposed by Ben LaHaise.  He
suggested creating a POSIX personality, or execution domain.  This would
take some pressure off the clone flag space as well as allowing some
optimizations in the code. It could also be used in situations where
POSIX-compatible behavior entails more than just sharing extra resources
between tasks.

This would assume that the resources I'm sharing would only be useful for
POSIX compatibility, but at this point it seems unlikely that anyone would
want to share a subset of them.  The resources I'm currently working on
include credentials, signals,  and timers, and there's a patch available
for semaphore undo that could also be part of this mechanism.

Since you've made it this far my question to you all is this:  assuming
that we do want improved POSIX compatibility does this sound like a
reasonable way to add it?

Thanks,
Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

