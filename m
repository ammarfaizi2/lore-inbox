Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135221AbRDLUXY>; Thu, 12 Apr 2001 16:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135311AbRDLUXS>; Thu, 12 Apr 2001 16:23:18 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:1199 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S135214AbRDLUW0>; Thu, 12 Apr 2001 16:22:26 -0400
Message-ID: <3AD60D7F.1682DC7C@uow.edu.au>
Date: Thu, 12 Apr 2001 13:18:07 -0700
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18-0.22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Rod Stewart <stewart@dystopia.lab43.org>, linux-kernel@vger.kernel.org,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: 8139too: defunct threads
In-Reply-To: <3AD5F9FE.9A49374D@uow.edu.au> from "Andrew Morton" at Apr 12, 2001 11:54:54 AM <E14nmpr-0001KH-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > <slaps head> swapper doesn't know how to reap children, and
> > AFAIK there's no way for a kernel thread to fully clean itself
> > up.  This is always done by the parent.
> 
> Make daemonize() move threads with parent 0 to parent 1

Reparenting would require diving inside this lot:

        /* 
         * pointers to (original) parent process, youngest child, younger sibling,
         * older sibling, respectively.  (p->father can be replaced with 
         * p->p_pptr->pid)
         */
        struct task_struct *p_opptr, *p_pptr, *p_cptr, *p_ysptr, *p_osptr;
        struct list_head thread_group;

plus maybe rewriting pgrps, sessions, gids, etc.  Challenging.

Plus it would mean that the kernel requires, for its
correct operation, that process "1" is a child reaper.
Is this a good thing?
