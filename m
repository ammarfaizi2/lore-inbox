Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268144AbTBYNO4>; Tue, 25 Feb 2003 08:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268145AbTBYNO4>; Tue, 25 Feb 2003 08:14:56 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:20618 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S268144AbTBYNOz>;
	Tue, 25 Feb 2003 08:14:55 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15963.28297.698245.741314@gargle.gargle.HOWL>
Date: Tue, 25 Feb 2003 14:24:25 +0100
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Stelian Pop <stelian@popies.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: modutils: FATAL: Error running install... 
In-Reply-To: <20030225012823.8C09A2C54A@lists.samba.org>
References: <20030224172734.C29439@deep-space-9.dsnet>
	<20030225012823.8C09A2C54A@lists.samba.org>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell writes:
 > In message <20030224172734.C29439@deep-space-9.dsnet> you write:
 > > ===== kernel/kmod.c 1.24 vs edited =====
 > > --- 1.24/kernel/kmod.c	Mon Feb 24 04:18:09 2003
 > > +++ edited/kernel/kmod.c	Mon Feb 24 17:19:39 2003
 > > @@ -154,6 +154,7 @@
 > >  
 > >  	/* Unblock all signals. */
 > >  	flush_signals(current);
 > > +	current->sighand->action[SIGCHLD-1].sa.sa_handler = SIG_DFL;
 > >  	spin_lock_irq(&current->sighand->siglock);
 > >  	flush_signal_handlers(current);
 > >  	sigemptyset(&current->blocked);
 > 
 > Is there really no cleaner way that this?

Linus cleaned it up in 2.5.63 -- he added a flag to flush_signal_handlers().
