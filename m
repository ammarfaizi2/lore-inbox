Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130167AbRANXox>; Sun, 14 Jan 2001 18:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130875AbRANXoc>; Sun, 14 Jan 2001 18:44:32 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:17175 "EHLO
	amsmta01-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S130167AbRANXoY>; Sun, 14 Jan 2001 18:44:24 -0500
Date: Mon, 15 Jan 2001 01:51:23 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Andi Kleen <ak@suse.de>
cc: Igmar Palsenberg <i.palsenberg@jdimedia.nl>,
        "David S. Miller" <davem@redhat.com>,
        Harald Welte <laforge@gnumonks.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 + iproute2
In-Reply-To: <20010114133140.A23640@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.21.0101150146550.20867-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Using textual strings means you can't use standard functions. An option
> > would be to extend the call so that if the userspace app wants to know
> > what really went wrong he can ask the kernel.
> 
> That will not work. Consider an application that has multiple rtnetlink
> sockets open, which each have own errors.

errno is only valid until a new syscall is done. So I don't see the
problem with multiple sockets, you can only perform one at a time.


> rtnetlink is such a radical interface for unix, adding a few more changes
> for a different error reporting system probably does not make much difference.
> 
> my problem with keeping the textual error messages out of kernel is that
> it means that three entities (kernel module, number table in kernel and 
> external string table) need to be kept in sync. In practice that's usually
> not the case.

I wonder if the glibc keeps it's own copy of the sys_errlist[]. If it has,
that means that we indeed have a problem..
Maybe the kernel could provide errno -> textual mapping, but that sounds
like bloat to me..

An other way is to have some kind of extended error.

> David's /proc/errno_strings would only require keeping kernel table and
> module in sync. 
> Text errors for rtnetlink would localize it to the module itself. 
> I could probably live with David's solution, although I would prefer the full
> way. 

Disadvantage of textual stuff is that you can't do more then print it. 

> -Andi


	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
