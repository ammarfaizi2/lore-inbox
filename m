Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265109AbUGGN2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265109AbUGGN2G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 09:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265115AbUGGN2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 09:28:06 -0400
Received: from colossus.systems.pipex.net ([62.241.160.73]:52886 "EHLO
	colossus.systems.pipex.net") by vger.kernel.org with ESMTP
	id S265109AbUGGN2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 09:28:00 -0400
Date: Wed, 7 Jul 2004 14:26:41 +0100 (BST)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: tigran@einstein.homenet
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@redhat.com>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: question about /proc/<PID>/mem in 2.4
In-Reply-To: <Pine.LNX.4.44.0407071444300.26475-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0407071424250.2972-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the address solar@openwall.dot.com bounced back and on some mailing list
"Solar Designer" set his email address to be solar@false,com which I
assume is false...

Ok, maybe this guy, whoever he or she is, is reading linux-kernel messages
and will respond eventually :)

Many thanks to everyone who responded to my questions.

Kind regards
Tigran

On Wed, 7 Jul 2004, Tigran Aivazian wrote:

> On Tue, 6 Jul 2004, Alan Cox wrote:
> 
> > On Tue, Jul 06, 2004 at 02:08:04PM +0100, Tigran Aivazian wrote:
> > > > This code was added to stop the ptrace/kmod vulnerabilities. I do not 
> > > > fully understand the issues around tsk->is_dumpable and the fix itself,
> > > > but I agree on that the checks here could be relaxed for the super user.
> > 
> > is_dumpable tells you various things in 2.4, including whether the
> > curent memory image is valid, and as a race preventor for ptrace during
> > exec of setuid apps. You should probably talk to Solar Designer about
> > the whole design of the dump/suid race fixing work rather than me.
> > 
> > We also had to deal with another nasty case which could be fixed by grabbing
> > the mm at open time (which then opens a resource attack bug).
> > 
> > Consider what happens if your setuid app reads stdin
> > 
> > 	setuidapp < /proc/self/mem
> > 
> > (No idea how 2.6 deals with these but if its got better backportable ways
> >  that *actually work* it might make sense).
> 
> Hello,
> 
> Ok, I followed the advice of Alan Cox and looked up "Solar Designer" on 
> google.
> 
> So, my questions (to Solar Designer) are:
> 
> 1. what exactly are the details of the setuid race Alan Cox is referring
> to above? I have 0 (zero) doubts in the validity of Alan's words and
> always trust him, but it doesn't imply that I always understand him, and
> so would appreciate a clarification.
> 
> 2. are you sure that there is no way to fix the above race without
> preventing even the superuser access to /proc/<PID>/mem of 
> any process?
> 
> More specifically (to save you time re-reading this thread) I am referring 
> to the code in fs/proc/base.c:mem_read():
> 
>         if (!MAY_PTRACE(task) || !may_ptrace_attach(task))
>                 return -ESRCH;
> 
> and also the same check on return from access_process_vm(), which I 
> suggested to relax a little, by allowing CAP_SYS_PTRACE user (or 
> CAP_SYS_RAWIO perhaps?) to access /proc/<PID>/mem of any task without any 
> hindrance.
> 
> Btw, the second check looks like an obvious race to me. I.e. if this
> condition can change between the check in the beginning of mem_read() and
> return from access_process_vm() then what is to stop it from changing just
> after this second check and return from mem_read()?
> 
> Therefore, the code in mem_read() does look broken to me, but instead of 
> "re-inventing the wheel" and trying to fix it "from scratch" I would like 
> to get a fair knowledge of the history/reasons for these changes, please.
> 
> Kind regards
> Tigran
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

