Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbVEALFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbVEALFO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 07:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbVEALFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 07:05:14 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:48062 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261590AbVEALFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 07:05:06 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: Jeff Dike <jdike@addtoit.com>
Subject: Factoring out common syscalls into asm-generic (was: Re: [uml-devel] Re: [patch 1/7] uml: fix syscall table by including $(SUBARCH)'s one, for i386
Date: Sun, 1 May 2005 13:15:37 +0200
User-Agent: KMail/1.8
Cc: Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       bstroesser@fujitsu-siemens.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
References: <20050424181909.81B8F33AED@zion> <20050428181053.GQ23013@shell0.pdx.osdl.net> <20050428204858.GD25451@ccure.user-mode-linux.org>
In-Reply-To: <20050428204858.GD25451@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505011315.37583.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 April 2005 22:48, Jeff Dike wrote:
> On Thu, Apr 28, 2005 at 11:10:53AM -0700, Chris Wright wrote:
> > * blaisorblade@yahoo.it (blaisorblade@yahoo.it) wrote:
> > > Split the i386 entry.S files into entry.S and syscall_table.S which
> > > is included in the previous one (so actually there is no difference
> > > between them) and use the syscall_table.S in the UML build, instead of
> > > tracking by hand the syscall table changes (which is inherently
> > > error-prone).
> >
> > Xen can use this as well (it was on my todo list).
>
> Maybe talking out of my ass here, but would it make sense to have the
> generic syscalls in asm-generic, in the form of something like:
> 	SYSCALL(__NR_getpid, sys_getpid)
> ?
>
> The arch include this into its syscall table, would continue to define
> __NR_*, and it would define SYSCALL (but all the syscall tables I've
> seen are just arrays of pointers).  This would allow the arches to
> automatically get all the generic system calls, and they'd continue to
> define on their own any arch-specific things.

The problem is that probably there are little "generic" syscalls. The above 
example is invalid on Alpha, for instance (they have sys_getxpid).

Also, probably, restructuring anything to take advantage of this would be very 
dangerous, error-prone and not rewarding... we (UML) had to do this because 
we had serious maintenance problems, plus the fact that we must *match* other 
syscall tables rather than having our own. Otherwise there's probably no 
reason to rebuild the table.

However, I guess that *new* syscalls are probably often generic, so for them 
there would be a good reason to have some generic idea. Who knows...
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

