Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263501AbTCNUnK>; Fri, 14 Mar 2003 15:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263503AbTCNUnK>; Fri, 14 Mar 2003 15:43:10 -0500
Received: from packet.digeo.com ([12.110.80.53]:64899 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263501AbTCNUnH>;
	Fri, 14 Mar 2003 15:43:07 -0500
Date: Fri, 14 Mar 2003 12:53:54 -0800
From: Andrew Morton <akpm@digeo.com>
To: Eli Carter <eli.carter@inet.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.64-mm6
Message-Id: <20030314125354.409ca02a.akpm@digeo.com>
In-Reply-To: <3E723DBF.6040304@inet.com>
References: <20030313032615.7ca491d6.akpm@digeo.com>
	<3E723DBF.6040304@inet.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Mar 2003 20:53:50.0549 (UTC) FILETIME=[D0D00850:01C2EA6B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eli Carter <eli.carter@inet.com> wrote:
>
> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.64/2.5.64-mm6/
> [snip]
> > kgdb.patch
> 
> I'm interested in this patch in your tree.

You're brave.

The kgdb patch is pretty nasty-looking code.  I've managed to keep it working
for every kernel since 2.4.0-test10 while avoiding actually looking at it. 
(I turn the monitor off when the patch needs fixing).  Fed it through Lindent
once.

George Anzinger is maintaining another strain of the stub, and that mostly
works OK and has improved features.  But the diff is larger and I once had a
couple of problems with it and need to spend more time testing it.  It's up
to date though.

> (Just to warn you of my 
> biases, I'm currently working with the XScale/ARM arch.)  I've noticed 
> some things about it in an initial look, namely:
> 
> There appears to be some code duplication between hex() and stubhex() in 
> arch/i386/kernel/gdbstub.c.

No surprise there.

> Also, the bulk of gdbstub.c appears to be generic code.  There are a 
> number of functions that have x86 asm in them, but it looks to me on 
> initial viewing, that most of the logic is applicable to other arches. 
> Am I understanding that correctly?
> Right now it looks like an arch would need to provide a way to:
> - reboot the processor
> - implement 'continue at address' and 'step one instruction from address'
> - handle_exeption()
> - printexception()
> - correct_hw_break()
> - regs_to_gdb_regs() and gdb_regs_to_regs()
>      Hmm, there's probably some more to that part...
> The above is just for the gdbstub.c.  I'm still reading the patch. :)
> 
> Would breaking the arch-independent parts out to linux/kernel/gdbstub.c 
> be a reasonable change or is that a dumb question? ;)

That would be a fantastic thing to do.  Note that there are already about ten
kgdb stubs in the shipped kernel at present.  If you can identify exactly
which functions need to be provided by the architecture, pull that out into
struct kgdb_operations, etc then it would make maintenance and addition of
new support much easier.

We might even end up with something we could submit for inclusion without
first having to set up an itwasntmenobodysawmedoit@yahoo.com account.


