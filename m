Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316364AbSFEUkm>; Wed, 5 Jun 2002 16:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316390AbSFEUkm>; Wed, 5 Jun 2002 16:40:42 -0400
Received: from ns.suse.de ([213.95.15.193]:7690 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316364AbSFEUkk>;
	Wed, 5 Jun 2002 16:40:40 -0400
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [RFC] 4KB stack + irq stack for x86
In-Reply-To: <20020604225539.F9111@redhat.com.suse.lists.linux.kernel> <Pine.LNX.4.44.0206050820100.2941-100000@home.transmeta.com.suse.lists.linux.kernel> <20020605144357.A4697@redhat.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 05 Jun 2002 22:40:39 +0200
Message-ID: <p73vg8xcvco.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise <bcrl@redhat.com> writes:

> On Wed, Jun 05, 2002 at 08:33:13AM -0700, Linus Torvalds wrote:
> > So, as far as I can tell, we now get a nasty aliasing issue on
> > "current_thread_info()->flags", and information like NEED_RESCHED and
> > SIGPENDING end up being set in the wrong place. They get set on the
> > _interrupt_ thread_info, not the "process native" thread_info.
> > 
> > Or did I miss some subtlety?
> 
> Ah, you're right.  If anyone uses current_thread_info from IRQ context 
> it will set the flags in the wrong structure.  However, it actually 
> works because nobody does that currently: all of the _thread_flag users 

preemptive kernels do use current_thread_info() for every spinlock.
this required me to change its implementation on x86-64 from stack
arithmetic to access the base register. 

-Andi

