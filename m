Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbVKTWJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbVKTWJg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 17:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbVKTWJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 17:09:36 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42442 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932100AbVKTWJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 17:09:35 -0500
Date: Sun, 20 Nov 2005 23:09:04 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       kernel list <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [linux-pm] [RFC] userland swsusp
Message-ID: <20051120220904.GB24132@elf.ucw.cz>
References: <20051115212942.GA9828@elf.ucw.cz> <20051115222549.GF17023@redhat.com> <1132342590.25914.86.camel@localhost.localdomain> <20051118211847.GA3881@redhat.com> <20051119234331.GA1952@spitz.ucw.cz> <20051120214832.GC28918@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051120214832.GC28918@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > >  > > Just for info: If this goes in, Red Hat/Fedora kernels will fork
>  > >  > > swsusp development, as this method just will not work there.
>  > >  > > (We have a restricted /dev/mem that prevents writes to arbitary
>  > >  > >  memory regions, as part of a patchset to prevent rootkits)
>  > >  > 
>  > >  > Perhaps it is trying to tell you that you should be using SELinux rules
>  > >  > not kernel hacks for this purpose ?
>  > > 
>  > > I don't think selinux can give you the granularity to say
>  > > "process can access this bit of the file only", at least not yet.
>  > > 
>  > > Even if that was capable however, it still doesn't solve the problem.
>  > > Pavel's implementation wants to write to arbitary address spaces, which is
>  > > what we're trying to prevent. The two are at odds with each other.
>  > 
>  > I do not think thats a security problem. By definition, suspending code
>  > can change arbitrary things in memory -- it could just write image with
>  > changes it desires, then resume from it. Whether this code is in kernel
>  > or not, it has to be trusted.
> 
> Stop thinking about the suspend usage case for a minute.
> 
> With your proposed changes, an attacker can scribble over random
> bits of /dev/mem without suspending in order to do whatever he
> wants.

Well, without my changes, an attacker can scribble over random bits of
memory, too; I was not the one that introduced /dev/mem :-).

> With what we have in-kernel, and a restricted /dev/mem, achieving the
> attack you mention is a lot less feasible, as the attacker has no access
> to the memory being written out to the suspend partition, even as root.
> Even if they did, people tend to notice boxes shutting down pretty quickly
> making this a not-very-stealthy attack.

Can I read somewhere about security model you are using? Would it be
enough to restrict /dev/[k]mem to those people that have right to
update kernel anyway? Or your approach is "noone, absolutely noone has
right to modify running kernel"? [Do you still use loadable modules?]

								Pavel

-- 
Thanks, Sharp!
