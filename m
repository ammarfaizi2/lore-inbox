Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262757AbVBYRUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262757AbVBYRUD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 12:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262755AbVBYRUC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 12:20:02 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:51160 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S262760AbVBYRTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 12:19:42 -0500
Date: Fri, 25 Feb 2005 18:19:11 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: aq <aquynh@gmail.com>
cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Jay Lan <jlan@engr.sgi.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Erich Focht <efocht@hpce.nec.com>
Subject: Re: [PATCH 2.6.11-rc4-mm1] connector: Add a fork connector
In-Reply-To: <9cde8bff050225085479761ef4@mail.gmail.com>
Message-ID: <Pine.LNX.4.53.0502251814230.1039@gockel.physik3.uni-rostock.de>
References: <1109240677.1738.196.camel@frecb000711.frec.bull.fr>
 <9cde8bff050225085479761ef4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +#ifdef CONFIG_FORK_CONNECTOR
[...]
> > +static inline void fork_connector(pid_t parent, pid_t child)
> > +{
[...]
> > +}
> > +#else
> > +static inline void fork_connector(pid_t parent, pid_t child)
> > +{
> > +       return;
> > +}
> > +#endif
[...]
> > @@ -1238,6 +1281,8 @@ long do_fork(unsigned long clone_flags,
> >                         if (unlikely (current->ptrace & PT_TRACE_VFORK_DONE))
> >                                 ptrace_notify ((PTRACE_EVENT_VFORK_DONE << 8) | SIGTRAP);
> >                 }
> > +
> > +               fork_connector(current->pid, p->pid);
> >         } else {
> >                 free_pidmap(pid);
> >                 pid = PTR_ERR(p);

> Guillaume, I see that you are trying to discover if the kernel has
> CONFIG_FORK_CONNECTOR defined or not. In case CONFIG_FORK_CONNECTOR is
> not defined, you will call a "dummy" fork_connector (which just call
> "return"). But why you dont move the checking to where you call
> fork_connector? In this case, if CONFIG_FORK_CONNECTOR is not defined,
> nothing called, and of course you dont need a "dummy" fork_connector
> like in the above code.
> 
> Just try something like this: 
> 
>  +#ifdef CONFIG_FORK_CONNECTOR
>  +
>  +               fork_connector(current->pid, p->pid);
> #endif

No, Guillaume did it right. Don't litter the code with useless #ifdefs
that turn one simple line of code into three for no good.
The dummy routine is optimized away by the compiler anyways.

Only the name "fork_connector()" might be discussed...

Tim 
