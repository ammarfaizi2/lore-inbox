Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318212AbSGaNAe>; Wed, 31 Jul 2002 09:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318228AbSGaNAe>; Wed, 31 Jul 2002 09:00:34 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:47372 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S318212AbSGaNAd>;
	Wed, 31 Jul 2002 09:00:33 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Rik van Riel <riel@conectiva.com.br>
Date: Wed, 31 Jul 2002 15:03:12 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: BUG at rmap.c:212
CC: akpm@zip.com.au, <linux-kernel@vger.kernel.org>
X-mailer: Pegasus Mail v3.50
Message-ID: <AD3C93230E@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 Jul 02 at 9:49, Rik van Riel wrote:
> On Wed, 31 Jul 2002, Petr Vandrovec wrote:
> 
> >   yesterday I told (in IDE thread) that BUG at rmap.c:212 is probably
> > already fixed by changeset 520. Unfortunately, it is not, I got it again
> > with BK tree. It happened again when 'ntpd' called exit() upon receiving
> > sigterm.
> 
> Line 212 is   'pte_chain_unlock(page);'   right ?
> 
> What configuration are you running ?  SMP ?  PREEMPT ?  What compiler ?

Nope. On my system (2.5.29-changeset548) it is a BUG() call which was
added by akpm in rmap.c revision 1.5, in his 'Add BUG() on a can't-happen
code path in page_remove_rmap()'. It just added #else BUG() branch
to #ifdef DEBUG_RMAP conditional.

Kernel is SMP, non-preempt, running on UP P4. Compiler is 2.95.4 from
Debian sid.

> >   Stack trace:
> >
> >   page_remove_rmap
> >   zap_pte_range
> >   zap_pmd_range
> >   unmap_page_range
> >   exit_mmap
> >   mmput
> >   do_exit
> >   sys_exit
> >   syscall_call
> >
> > If it is not known bug, I'll rebuild kernel with DEBUG_RMAP.
> > Unfortunately it looks like that machine must have uptime > 12hrs to
> > trigger this. Probably updatedb or some other task must be run to try to
> > swap ntpd out?
> 
> It is not a known bug. In fact I've never seen this one before.

Probably because of your code did not do anything special when
'Not found. This should NEVER happen!' code path triggers. Code in
bitkeeper since 27th July complains. I'm now running with DEBUG_RMAP
set, so I'll see next time.
                                                        Petr Vandrovec
                                                        vandrove@vc.cvut.cz
                                                        
