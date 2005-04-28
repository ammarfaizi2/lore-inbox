Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262179AbVD1U7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbVD1U7K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 16:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbVD1U7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 16:59:10 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:29201 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262179AbVD1U7H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 16:59:07 -0400
Date: Thu, 28 Apr 2005 16:48:58 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Chris Wright <chrisw@osdl.org>
Cc: blaisorblade@yahoo.it, akpm@osdl.org, bstroesser@fujitsu-siemens.com,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [patch 1/7] uml: fix syscall table by including $(SUBARCH)'s one, for i386
Message-ID: <20050428204858.GD25451@ccure.user-mode-linux.org>
References: <20050424181909.81B8F33AED@zion> <20050428181053.GQ23013@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050428181053.GQ23013@shell0.pdx.osdl.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 11:10:53AM -0700, Chris Wright wrote:
> * blaisorblade@yahoo.it (blaisorblade@yahoo.it) wrote:
> > 
> > Split the i386 entry.S files into entry.S and syscall_table.S which
> > is included in the previous one (so actually there is no difference between
> > them) and use the syscall_table.S in the UML build, instead of tracking by
> > hand the syscall table changes (which is inherently error-prone).
> 
> Xen can use this as well (it was on my todo list).

Maybe talking out of my ass here, but would it make sense to have the
generic syscalls in asm-generic, in the form of something like:
	SYSCALL(__NR_getpid, sys_getpid)
?

The arch include this into its syscall table, would continue to define
__NR_*, and it would define SYSCALL (but all the syscall tables I've
seen are just arrays of pointers).  This would allow the arches to
automatically get all the generic system calls, and they'd continue to
define on their own any arch-specific things.

				Jeff
