Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135927AbREABRY>; Mon, 30 Apr 2001 21:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135935AbREABRP>; Mon, 30 Apr 2001 21:17:15 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:2340 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S135927AbREABQ5>; Mon, 30 Apr 2001 21:16:57 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Paul J Albrecht <pjalbrecht@home.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Debuggers, KDB or KGDB? 
In-Reply-To: Your message of "Mon, 30 Apr 2001 16:17:22 EST."
             <01043016264000.00697@CB57534-A> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 01 May 2001 11:16:50 +1000
Message-ID: <18223.988679810@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Apr 2001 16:17:22 -0500, 
Paul J Albrecht <pjalbrecht@home.com> wrote:
>Where can I find an analysis of the relative strengths and weaknesses of KDB
>and KGDB for kernel debug? Has the linux community come to any consensus
>regarding the utility one or the other?

kdb is a really low level debugger which understands the kernel
structures.  It does its utmost to stop all kernel activity while it is
running and to use as few kernel services as possible so it can run
even when the kernel is dead.  It (currently) has no source level
debugging.

kgdb relies on gdb so you loose the knowledge of kernel internals (no,
I am *not* going to teach gdb about kernel stacks, out of line lock
code etc.).  kgdb has more of a dependency on a working kernel.  It
provides source level debugging, although stack backtrace tends not to
work unless you compile the kernel with frame pointers.

UML is great for debugging generic kernel code such as filesystems, but
cannot be used for most arch code or hardware drivers.

My ideal debugger is one that combines the internal knowledge of kdb
with the source level debugging of gdb.  I know how to do this over a
serial line, finding time to write the code is the problem.

