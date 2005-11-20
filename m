Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbVKTVs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbVKTVs5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 16:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbVKTVs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 16:48:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23691 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932082AbVKTVs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 16:48:56 -0500
Date: Sun, 20 Nov 2005 16:48:32 -0500
From: Dave Jones <davej@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       kernel list <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [linux-pm] [RFC] userland swsusp
Message-ID: <20051120214832.GC28918@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	kernel list <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Linux-pm mailing list <linux-pm@lists.osdl.org>
References: <20051115212942.GA9828@elf.ucw.cz> <20051115222549.GF17023@redhat.com> <1132342590.25914.86.camel@localhost.localdomain> <20051118211847.GA3881@redhat.com> <20051119234331.GA1952@spitz.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051119234331.GA1952@spitz.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2005 at 11:43:32PM +0000, Pavel Machek wrote:
 > Hi!
 > 
 > >  > > Just for info: If this goes in, Red Hat/Fedora kernels will fork
 > >  > > swsusp development, as this method just will not work there.
 > >  > > (We have a restricted /dev/mem that prevents writes to arbitary
 > >  > >  memory regions, as part of a patchset to prevent rootkits)
 > >  > 
 > >  > Perhaps it is trying to tell you that you should be using SELinux rules
 > >  > not kernel hacks for this purpose ?
 > > 
 > > I don't think selinux can give you the granularity to say
 > > "process can access this bit of the file only", at least not yet.
 > > 
 > > Even if that was capable however, it still doesn't solve the problem.
 > > Pavel's implementation wants to write to arbitary address spaces, which is
 > > what we're trying to prevent. The two are at odds with each other.
 > 
 > I do not think thats a security problem. By definition, suspending code
 > can change arbitrary things in memory -- it could just write image with
 > changes it desires, then resume from it. Whether this code is in kernel
 > or not, it has to be trusted.

Stop thinking about the suspend usage case for a minute.

With your proposed changes, an attacker can scribble over random
bits of /dev/mem without suspending in order to do whatever he wants.

With what we have in-kernel, and a restricted /dev/mem, achieving the
attack you mention is a lot less feasible, as the attacker has no access
to the memory being written out to the suspend partition, even as root.
Even if they did, people tend to notice boxes shutting down pretty quickly
making this a not-very-stealthy attack.

		Dave

