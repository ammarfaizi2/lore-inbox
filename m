Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278510AbRJPDZa>; Mon, 15 Oct 2001 23:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278508AbRJPDZK>; Mon, 15 Oct 2001 23:25:10 -0400
Received: from cti06.citenet.net ([206.123.38.70]:43277 "EHLO
	cti06.citenet.net") by vger.kernel.org with ESMTP
	id <S278076AbRJPDZG>; Mon, 15 Oct 2001 23:25:06 -0400
From: Jacques Gelinas <jack@solucorp.qc.ca>
Date: Mon, 15 Oct 2001 21:51:51 -0500
To: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: re: re: Re: Announce: many virtual servers on a single box
X-mailer: tlmpmail 0.1
Message-ID: <20011015215151.7f22bbebdea7@remtk.solucorp.qc.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2001 17:22:43 -0500, James Sutherland wrote

> > But there is no need to open a crackme vserver. Install it on your machine,
> > build a vserver.
>
> The question, I think, was would YOU give out root access on vservers on
> YOUR box, and be confident people wouldn't be able to escape? :-)

Yes this is the goal. At the office we have many developpers doing various
projects. They often have to setup special demos and those demos must be
located in our dmz. So until now, we could not give them root password. This
was kind of annoying (It is always annoying to refuse the root password to
a friend). Now we can do it.

But I suspect many ASP will use this. For now to make the box really robust
we need to enhance the schedular (some fairness) and make the user
resource global to a vserver. For now, you can limit a process (ulimit) and the
number of process a user can start, but you have little control over total
limits used by a user or vserver (right ?, maybe 2.4 has something in this area
I have missed)

> > > You might want to announce this on bugtraq. [And give solar designer
> > > root account, he might be more creative ;)].
> >
> > You don't understand the issue. Anyone can create his own vserver. The
> > system call controlling this are very simple. It is not a "try to
> > crack my machine" contest. Anyone can create a vserver and test it.
>
> But can you crack your way OUT of the vserver - how confident are you in
> the isolation provided?

Highly. Bug pending.

The concept is both very simple and sound


	security ID to isolate processes (an integer)

	chroot to isolate the files

	capabilities to lower the ability of root (I had to enhance that
	a little with the capability ceiling)

	set_ipv4root to tie all processes in a vserver to one IP.

The "bug pending" means that I may have forgotten one place in the kernel.
For example, when I implemented the new_s_context, I patchs the kill system
call in few places, then later I realized the ptrace syscall was an issue. I added
a one line test there. I may have forgotten one check.

The same applies to capabilities. When we moved from suser() to capable() we may
have forgotten something. Since capabilities are not that much used, some place
may be missing. For example /proc/sys was writtable by root and not protected
by any capabilities.

But the changes in the kernel a trivial. This is why I am posting here to
get some review.

---------------------------------------------------------
Jacques Gelinas <jack@solucorp.qc.ca>
vserver: run general purpose virtual servers on one box, full speed!
http://www.solucorp.qc.ca/miscprj/s_context.hc
