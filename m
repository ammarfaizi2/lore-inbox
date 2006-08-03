Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbWHCP17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWHCP17 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 11:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbWHCP17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 11:27:59 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:38875 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964791AbWHCP16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 11:27:58 -0400
Subject: Re: Problems with 2.6.17-rt8
From: Steven Rostedt <rostedt@goodmis.org>
To: Robert Crocombe <rcrocomb@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       Bill Huey <billh@gnuppy.monkey.org>
In-Reply-To: <e6babb600608030808x632bd5e8y7dcb991fe229467d@mail.gmail.com>
References: <e6babb600608012231r74470b77x6e7eaeab222ee160@mail.gmail.com>
	 <e6babb600608012237g60d9dfd7ga11b97512240fb7b@mail.gmail.com>
	 <1154541079.25723.8.camel@localhost.localdomain>
	 <e6babb600608030448y7bb0cd34i74f5f632e4caf1b1@mail.gmail.com>
	 <1154615261.32264.6.camel@localhost.localdomain>
	 <e6babb600608030808x632bd5e8y7dcb991fe229467d@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 03 Aug 2006 11:27:39 -0400
Message-Id: <1154618859.32264.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-03 at 08:08 -0700, Robert Crocombe wrote:
> On 8/3/06, Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > Call Trace:
> > >        <ffffffff8047655a>{_raw_spin_lock_irqsave+24}
> > >        <ffffffff8022b272>{__WARN_ON+100}
> > >        <ffffffff802457e4>{debug_rt_mutex_unlock+199}
> > >        <ffffffff804757b7>{rt_lock_slowunlock+25}
> > >        <ffffffff80476301>{__lock_text_start+9}
> >
> > hmm, here we are probably having trouble with the percpu slab locks,
> > that is somewhat of a hack to get slabs working on a per cpu basis.
> >
> > >        <ffffffff80271e93>{kmem_cache_alloc+202}
> >
> > It would also be nice to know exactly where ffffffff80271e93 is.
> 
> >From the System.map file:
> 
> ffffffff80271df5 t gather_stats
> ffffffff80271e98 t get_zonemask
> ffffffff80271f1e T __mpol_equal
> 

Actually, if you compiled with debugging information on, you can use gdb
to get a pretty good location:

$ cd path/to/build/directory
$ gdb vmlinux
GNU gdb 6.3
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "--host=i386-linux --target=x86_64-linux".

(gdb) li *0xffffffff80271e93

That is if your gdb is also compiled for 64 bit.

-- Steve


