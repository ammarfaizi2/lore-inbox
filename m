Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267710AbSLGCYo>; Fri, 6 Dec 2002 21:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267708AbSLGCYn>; Fri, 6 Dec 2002 21:24:43 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:50674 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S267707AbSLGCYm>;
	Fri, 6 Dec 2002 21:24:42 -0500
Message-ID: <3DF15C0F.AA512B57@mvista.com>
Date: Fri, 06 Dec 2002 18:25:19 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Jim Houston <jim.houston@ccur.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
       "David S. Miller" <davem@redhat.com>, ak@muc.de, davidm@hpl.hp.com,
       schwidefsky@de.ibm.com, ralf@gnu.org, willy@debian.org
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
References: <Pine.LNX.4.44.0212061450330.1101-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------F22A0451E4D90F96CEF6B33F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------F22A0451E4D90F96CEF6B33F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> 
> On Fri, 6 Dec 2002, Jim Houston wrote:
> >
> > I know it would be a few extra lines of assembly code but it would be
> > nice if the restart routine had the original arguments.
> 
> It's not even extra code on x86, since we don't stomp on any of the
> arguments, and they will all have the same values when returning. So on
> x86, we could see the arguments by just adding parameters to the
> sys_restart_syscall() function.
> 

Would you consider this small change?
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
--------------F22A0451E4D90F96CEF6B33F
Content-Type: text/plain; charset=us-ascii;
 name="reg_sug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="reg_sug.patch"

--- linux-2.5.50-bk4-hrposix/arch/i386/kernel/signal.c	Fri Dec  6 18:17:06 2002
+++ linux/arch/i386/kernel/singnal.c	Fri Dec  6 18:20:05 2002
@@ -507,8 +507,8 @@
 		/* If so, check system call restarting.. */
 		switch (regs->eax) {
                        case -ERESTART_RESTARTBLOCK:
-                               current_thread_info()->restart_block.fn = do_no_restart_syscall;
 			case -ERESTARTNOHAND:
+                               current_thread_info()->restart_block.fn = do_no_restart_syscall;
 				regs->eax = -EINTR;
 				break;
 


--------------F22A0451E4D90F96CEF6B33F--

