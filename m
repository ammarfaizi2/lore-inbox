Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265365AbUAZWHZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 17:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265376AbUAZWHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 17:07:24 -0500
Received: from fed1mtao05.cox.net ([68.6.19.126]:31694 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S265365AbUAZWHF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 17:07:05 -0500
Date: Mon, 26 Jan 2004 15:06:51 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: George Anzinger <george@mvista.com>
Cc: "Amit S. Kale" <amitkale@emsyssoft.com>,
       Powerpc Linux <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>
Subject: Re: PPC KGDB changes and some help?
Message-ID: <20040126220651.GE32525@stop.crashing.org>
References: <200401212223.13347.amitkale@emsyssoft.com> <20040121184217.GU13454@stop.crashing.org> <20040121192128.GV13454@stop.crashing.org> <20040121192230.GW13454@stop.crashing.org> <20040122174416.GJ15271@stop.crashing.org> <20040122180555.GK15271@stop.crashing.org> <20040123224605.GC15271@stop.crashing.org> <4011B07F.5060409@mvista.com> <20040126204631.GB32525@stop.crashing.org> <40158A88.7070007@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40158A88.7070007@mvista.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 26, 2004 at 01:45:44PM -0800, George Anzinger wrote:

> Tom Rini wrote:
> >
> >>There is a real danger of passing signal info back to gdb as it will want 
> >>to try to deliver the signal which is a non-compute in most kgdbs in the 
> >>field.  I did put code in the mm-kgdb to do just this, but usually the 
> >>arrival of such a signal (other than SIGTRAP) is the end of the kernel.  
> >>All that is left is to read the tea leaves.
> >
> >
> >The gdb I've been testing this with knows better than to try and send a
> >singal back, so that's not a worry.  The motivation behind doing this
> >however is along the lines of "if it ain't broke, don't remove it".  The
> >original stub was getting all of this information correctly, so why stop
> >doing it?
> >
> You sure.  If so what gdb?  And how does it know?  I suppose you could tell 
> it with a script, but then what if one forgets?

GNU gdb 6.0 (MontaVista 6.0-8.0.4.0300532 2003-12-24)
Copyright 2003 Free Software Foundation, Inc.
[snip]

[New Thread 289]

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 289]
0x00000000 in ?? ()
(gdb) c
Continuing.
Can't send signals to this remote system.  SIGSEGV not sent.

Noting that 0x0 is correct as the code that triggered this was:
static void (*dummy)(struct pt_regs *regs);
int drop_kgdb(void) {
        struct pt_regs regs;
        memset(&regs, 0, sizeof(regs));
        dummy(&regs);

        return 0;
}
module_init(drop_kgdb);

-- 
Tom Rini
http://gate.crashing.org/~trini/
