Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263119AbUB0VMw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 16:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263136AbUB0VMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 16:12:52 -0500
Received: from adsl-216-103-111-100.dsl.snfc21.pacbell.net ([216.103.111.100]:36754
	"EHLO www.piet.net") by vger.kernel.org with ESMTP id S263119AbUB0VKq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 16:10:46 -0500
Subject: Re: kgdb support in vanilla 2.6.2
From: Piet Delaney <piet@www.piet.net>
To: George Anzinger <george@mvista.com>
Cc: Andi Kleen <ak@suse.de>, "Amit S. Kale" <amitkale@emsyssoft.com>,
       akpm@osdl.org, pavel@ucw.cz, linux-kernel@vger.kernel.org,
       piggy@timesys.com, trini@kernel.crashing.org, piet <piet@www.piet.net>
In-Reply-To: <40295388.5080901@mvista.com>
References: <20040204230133.GA8702@elf.ucw.cz.suse.lists.linux.kernel>	<20040204155452.4
	9c1eba8.akpm@osdl.org.suse.lists.linux.kernel>	<p73n07ykyop.fsf@verdi.suse.d
	 e>	<200402052320.04393.amitkale@emsyssoft.com>
	<20040206032054.3fd7db8d.ak@suse.de>  <40295388.5080901@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Feb 2004 13:09:11 -0800
Message-Id: <1077916151.3291.133.camel@www.piet.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-02-10 at 13:56, George Anzinger wrote:

I thought I'd poke around an AMD64 with etherbased kgdb on 2.6.*.
I just picked up a used AMD64 K8D Master-F MS-9131 and thought I'd
install Fedora Core 1 test1 and the latest kernel from kernel.org.

It Might be interesting to try out a SuSE release also, I was wondering
if 9.0 from linuxiso.org might be best.

Last I worked with your kgdb patch for 2.6 Andrew's mm patch had the
latest code; Is that still the case?

-piet

> Andi Kleen wrote:
> > On Thu, 5 Feb 2004 23:20:04 +0530
> > "Amit S. Kale" <amitkale@emsyssoft.com> wrote:
> > 
> > 
> >>On Thursday 05 Feb 2004 8:41 am, Andi Kleen wrote:
> >>
> >>>Andrew Morton <akpm@osdl.org> writes:
> >>>
> >>>>need to take a look at such things and really convice ourselves that
> >>>>they're worthwhile.  Personally, I'd only be interested in the basic
> >>>>stub.
> >>>
> >>>What I found always extremly ugly in the i386 stub was that it uses
> >>>magic globals to talk to the page fault handler. For the x86-64
> >>>version I replaced that by just using __get/__put_user in the memory
> >>>accesses, which is much cleaner. I would suggest doing that for i386
> >>>too.
> >>
> >>May be I am missing something obvious. When debugging a page fault handler if 
> >>kgdb accesses an swapped-out user page doesn't it deadlock when trying to 
> >>hold mm semaphore?
> > 
> > 
> > Modern i386 kernels don't grab the mm semaphore when the access is >= TASK_SIZE
> > and the access came from kernel space (actually I see x86-64 still does, but that's 
> > a bug, will fix). You could only see a deadlock when using user addresses
> > and you already hold the mm semaphore for writing (normal read lock is ok). 
> > Just don't do that. 
> > 
> > 
> > 
> >>George has coded cfi directives i386 too. He can use them to backtrace past 
> >>irqs stack.
> > 
> > 
> > Problem is that he did it without binutils support. I don't think that's a good
> > idea because it makes the code basically unmaintainable for normal souls
> > (it's like writing assembly code directly in hex) 
> 
> Well, bin utils, at this time, makes it even worse in that it does not support 
> the expression syntax.  Also, it is not asm but dwarf2 and it is written in, 
> IMHO, useful macros (not hex :)
> 
> 
> 
> -- 
> George Anzinger   george@mvista.com
> High-res-timers:  http://sourceforge.net/projects/high-res-timers/
> Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
piet@www.piet.net

