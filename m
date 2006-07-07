Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbWGGE24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWGGE24 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 00:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbWGGE24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 00:28:56 -0400
Received: from mail.gmx.de ([213.165.64.21]:8399 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750860AbWGGE24 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 00:28:56 -0400
Cc: linux-kernel@vger.kernel.org, tytso@mit.edu, torvalds@osdl.org,
       drepper@redhat.com, paire@ri.silicomp.fr, eggert@cs.ucla.edu,
       roland@redhat.com, rlove@rlove.org, mtk-lkml@gmx.net
Content-Type: text/plain; charset="iso-8859-1"
Date: Fri, 07 Jul 2006 06:28:54 +0200
From: "Michael Kerrisk" <michael.kerrisk@gmx.net>
In-Reply-To: <44AD599D.70803@colorfullife.com>
Message-ID: <20060707042854.186800@gmx.net>
MIME-Version: 1.0
References: <44A92DC8.9000401@gmx.net> <44AABB31.8060605@colorfullife.com>
 <20060706092328.320300@gmx.net> <44AD599D.70803@colorfullife.com>
Subject: Re: Re: Strange Linux behaviour with blocking syscalls and stop
 signals+SIGCONT
To: Manfred Spraul <manfred@colorfullife.com>, mtk-manpages@gmx.net
X-Authenticated: #2864774
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Von: Manfred Spraul <manfred@colorfullife.com>
> Michael Kerrisk wrote:
> 
> >  
> >
> >>Michael: Could you replace the EINTR in inotify.c with ERESTARTNOHAND? 
> >>That should prevent the kernel from showing the signal to user space.
> >>I'd guess that most instances of EINTR are wrong, except in device 
> >>drivers: It means we return from the syscall, even if the signal 
> >>handler
> >>wants to restart the system call.
> >>    
> >>
> >
> >I'll try patching a kernel to s/EINTR/ERESTARTNOHAND/ in relevant
> >places, and see how that goes.  If it goes well, I'll submit a 
> >patch.
> >
> >  
> >
> 1) I would go further and try ERESTARTSYS: ERESTARTSYS means that the 
> kernel signal handler honors SA_RESTART

Yes, this is a separate but related issue: some system calls
are not restarted by SA_RESTART.  This set of system calls
overlaps with, but is not quite the same as, the set of
system calls that demonstrate the stop+SIGCONT ==> EINTR
strangeness.  I thought to tackle the latter problem
first (since the fix seems easy), and then perhaps
get onto the other one later (it is more likely to
lead to visible ABI changes).

Cheers,

Michael
-- 


Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
