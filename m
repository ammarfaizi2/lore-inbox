Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbUACPaW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 10:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263478AbUACPaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 10:30:22 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:42762 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263475AbUACPaT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 10:30:19 -0500
Date: Sat, 3 Jan 2004 16:41:58 +0100
To: Libor Vanek <libor@conet.cz>
Cc: Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: Syscall table AKA hijacking syscalls
Message-ID: <20040103154158.GB5531@hh.idb.hist.no>
References: <3FF56B1C.1040308@conet.cz> <20040102233542.GW28023@krispykreme> <3FF602C9.4080100@conet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FF602C9.4080100@conet.cz>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 03, 2004 at 12:46:17AM +0100, Libor Vanek wrote:
> >>I'm writing some project which needs to hijack some syscalls in VFS 
> >>layer. AFAIK in 2.6 is this "not-wanted" solution (even that there are 
> >>some very nasty ways of doing it - see 
> >>http://mail.nl.linux.org/kernelnewbies/2002-12/msg00266.html )
> >
> >
> >And it will fail miserably on many non x86 architectures for
> >various reasons:
> >
> >1. ppc64 and ia64 use function descriptors
> >2. sparc64 uses a 32bit call out table
> >
> >In short its not only an awful hack, its horribly non portable :)
> 
> But in short you always get some syscall from userspace and have some table 
> with function vectors assigned to each syscall, don't you?
> 
> So you can have something like 
> "append_this_function_before_syscall_sys_open" and 
> "append_this_function_after_syscall_sys_open" which would be platform 
> independent but will have platform dependent implementation.

Why bother overriding syscalls?
If you want a different sys_open, just modify/rewrite it.  Then you get a kernel
that works your way without touching the syscall table (or other implementation of it) 
at all.

Of course this sort of rewrite cannot be acitvated/deactivated by loading/unloading
a module.  But that isn't necessary, use a writeable flag in /proc instead.

i.e.:
sys_open(...) 
{
  if (activated_in_proc) my_sys_open(...); else standard_sys_open(...);
}

Helge Hafting
