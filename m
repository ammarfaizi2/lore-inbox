Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136049AbREBWtz>; Wed, 2 May 2001 18:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136050AbREBWtq>; Wed, 2 May 2001 18:49:46 -0400
Received: from femail17.sdc1.sfba.home.com ([24.0.95.144]:13710 "EHLO
	femail17.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S136049AbREBWtk>; Wed, 2 May 2001 18:49:40 -0400
From: Paul J Albrecht <pjalbrecht@home.com>
To: Keith Owens <kaos@ocs.com.au>
Subject: Re: Linux Kernel Debuggers, KDB or KGDB?
Date: Wed, 2 May 2001 16:06:15 -0500
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <18223.988679810@kao2.melbourne.sgi.com>
In-Reply-To: <18223.988679810@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Message-Id: <01050216532701.00700@CB57534-A>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Apr 2001, Keith Owens wrote:
> On Mon, 30 Apr 2001 16:17:22 -0500, 
> Paul J Albrecht <pjalbrecht@home.com> wrote:
> >Where can I find an analysis of the relative strengths and weaknesses of KDB
> >and KGDB for kernel debug? Has the linux community come to any consensus
> >regarding the utility one or the other?
> 
> kdb is a really low level debugger which understands the kernel
> structures.  It does its utmost to stop all kernel activity while it is
> running and to use as few kernel services as possible so it can run
> even when the kernel is dead.  It (currently) has no source level
> debugging.
> 

I'd like to know more about your plans to enhance KDB with source level debug
capability. What sort of compiler debug output would be supported? STABs or
DWARF?  Both? What hardware platforms would be supported? What about gui
support?

KDB is console debugger, i.e., it doesn't support a remote serial protocol so
I don't understand how source level debug would work. Would you have to boot
an unstripped kernel executable whenever you wanted to debug?

KGDB is better because it's a source level debugger and because you get a
graphical interface, Data Display Debugger (DDD), for free when you use gdb.

KGDB is better because it's more platform agnostic than KDB. The only
architecture dependent part in the kernel is the gdb stub which is small and
well defined.

> kgdb relies on gdb so you loose the knowledge of kernel
internals (no, > I am *not* going to teach gdb about kernel stacks, out of line
lock > code etc.).  kgdb has more of a dependency on a working kernel.  It
> provides source level debugging, although stack backtrace tends not to
> work unless you compile the kernel with frame pointers.
> 

I don't know what you mean when you say "loose knowledge of kernel internals"
with KGDB ... I'd rather develop a set of standard gdb user defined commands to
expose kernel internals than hard code them in the linux kernel.

As for stack frame analysis, both debuggers have problems with backtrace if the
kernel is compiled without CONFIG_FRAME_POINTER option. Whether the problem is
fixed in gdb for KGDB users or the kernel for KDB users is immaterial in
choosing one debugger over the other.

-- 
Paul J Albrecht
pjalbrecht@home.com
