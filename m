Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316235AbSHRVQW>; Sun, 18 Aug 2002 17:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316258AbSHRVQW>; Sun, 18 Aug 2002 17:16:22 -0400
Received: from platypus.ociw.edu ([192.91.178.3]:35772 "EHLO platypus.ociw.edu")
	by vger.kernel.org with ESMTP id <S316235AbSHRVQU>;
	Sun, 18 Aug 2002 17:16:20 -0400
Date: Sun, 18 Aug 2002 14:20:20 -0700
From: "Brian M. Sutin" <sutin@ociw.edu>
To: linux-kernel@vger.kernel.org
Subject: Bug Report ... Please Forward
Message-ID: <20020818142020.A8898@zot.ociw.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Organization: The Observatories of the Carnegie Institution of Washington
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!  I have found what I think to be a hardware compatibility bug
with the basic operation of the kernel.  I would appreciate if you
could put me into contact with people who would be most interested in
fixing this bug, as my participation will probably be necessary to
solve the problem.  Here is the report:

Short Summary:

On a Toshiba Libretto 70CT, the 2.4.18-3 kernel boots up until freeing
the extra kernel memory.  After this, the execve to /sbin/init returns
success, but /sbin/init does not run.

Long Version:

The Toshiba Libretto 70CT has a 586 with MMX processor.  It runs vanilla
Redhat 6.2 fine (I forgot the kernel version, sorry...).  It will not
run Redhat 7.0 (kernel 2.2.late) or Redhat 7.3 (2.4.18-3), so the bug
has existed for quite some time.  The problem is that, on boot, I see:

    ...previous stuff...
    Freeing unused kernel memory: (some number)
    ...hangs forever here...

I tried having the kernel run the shell instead, but that did not work
either.  I also recompiled /sbin/init to print out a message to stderr
first off, but nothing appeared.

I recompiled the kernel and started adding printk debugging statements.
I found that search_binary_handler() (from fs/exec.c) returns success.
At this point it is clear to me that I am not going to get any farther
with printk statements.

I also tried to make an a.out executable (rather than an ELF), but the
ld in Redhat is not compiled to create one, and I was unable to figure
out how to configure the recompile of ld to make it do so.  If someone
could send me an a.out-style executable of some sort, that would be the
next obvious test.

My info:

Brian Sutin
sutin@ociw.edu
(626) 304 - 0265
I will be out of town from 2002-08-21 to 2002-08-29.


-- 
Brian M. Sutin        Optical Scientist        Pasadena, CA
The Observatories of the Carnegie Institution of Washington
