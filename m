Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbUL1Jmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbUL1Jmo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 04:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbUL1Jmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 04:42:44 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:7307
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261178AbUL1Jmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 04:42:42 -0500
Subject: Re: VM fixes [4/4]
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Rik van Riel <riel@redhat.com>
Cc: Andrea Arcangeli <andrea@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0412270837001.19240@chimarrao.boston.redhat.com>
References: <20041224174156.GE13747@dualathlon.random>
	 <Pine.LNX.4.61.0412270837001.19240@chimarrao.boston.redhat.com>
Content-Type: text/plain
Date: Tue, 28 Dec 2004 10:42:40 +0100
Message-Id: <1104226960.27708.321.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-27 at 08:38 -0500, Rik van Riel wrote:
> On Fri, 24 Dec 2004, Andrea Arcangeli wrote:
> 
> > --- x/mm/oom_kill.c.orig	2004-12-24 17:53:50.807536152 +0100
> > +++ x/mm/oom_kill.c	2004-12-24 18:01:19.903263224 +0100
> > @@ -45,18 +45,30 @@
> > unsigned long badness(struct task_struct *p, unsigned long uptime)
> > {
> 
> > 	/*
> > +	 * Processes which fork a lot of child processes are likely
> > +	 * a good choice. We add the vmsize of the childs if they
> > +	 * have an own mm. This prevents forking servers to flood the
> > +	 * machine with an endless amount of childs
> > +	 */
> 
> I'm not sure about this one.  You'll end up killing the
> parent httpd and sshd, instead of letting them hang around
> so the system can recover by itself after the memory use
> spike is over.

The selection is adding the child VM size, but the killer itself kills a
child process first, so the parent is not the one which is killed in the
first place.

tglx


