Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136821AbRECOmh>; Thu, 3 May 2001 10:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136822AbRECOm3>; Thu, 3 May 2001 10:42:29 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:13709 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S136821AbRECOmN>; Thu, 3 May 2001 10:42:13 -0400
Message-ID: <3AF16F32.A10EB093@veritas.com>
Date: Thu, 03 May 2001 15:46:10 +0100
From: "Amit S. Kale" <akale@veritas.com>
Organization: Veritas Software (India)
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Paul J Albrecht <pjalbrecht@home.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Debuggers, KDB or KGDB?
In-Reply-To: <5003.988844635@ocs3.ocs-net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Wed, 2 May 2001 16:06:15 -0500,
> Paul J Albrecht <pjalbrecht@home.com> wrote:
> >I'd like to know more about your plans to enhance KDB with source level debug
> >capability.
> 
> Use a combination of gdb and kdb.  kdb to support kernel internals, gdb
> to take the kdb output and add source level data.  It needs two
> machines, one that is running to support gdb, the second machine is
> being debugged, with a serial console between them.

This is how solaris ksld (kernel source level debugger
works). solaris dbx connects to a kernel stub which
serves as kadb (solaris assembly level debugger) as
well as a debugger stub.

> The problem will be stopping gdb from making assumptions about the
> machine being debugged.  Instead of changing gdb code, use a gdb
> wrapper program to intercept user commands and gdb serial protocol and
> convert them to kdb commands.

I am not sure if kdb provides access to kernel threads
in a form that can be conveniently by a wrapper
program.

Interested people can check whether all features of kgdb
(http://kgdb.sourceforge.net/) are available in convenient
form in kdb.

The logic of holding slave cpus (the cpu in the debugger
is the master while others are slaves) is different in kdb
and kgdb. Handling of nmi-watchdog too is different.

> 
> >Would you have to boot an unstripped kernel executable whenever you
> >wanted to debug?
> 
> Boot, no.  But the machine running gdb will need an copy of the
> unstripped vmlinux and module objects to get the debug information.

Plus all the sources.

All this is required by gdb. In theory gdb could do well
with just source code and symbol information only, though
for lack of a symbol information requesting packet in
the gdb remote protocol, gdb can't get symbol information
directly from the stub.

There is some effort in gdb world to allow a stub to query
gdb for symbol information. Probably the reverse can also
be added. Need someone good understanding of gdb to do
that.

It's because of these reasons that kgdb module debugging setup
is combersome.

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Amit Kale
Veritas Software ( http://www.veritas.com )
