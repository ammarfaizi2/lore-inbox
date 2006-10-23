Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbWJWBbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbWJWBbZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 21:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbWJWBbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 21:31:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:9642 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751051AbWJWBbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 21:31:24 -0400
From: Andi Kleen <ak@suse.de>
To: Matthew Wilcox <matthew@wil.cx>
Subject: Re: dealing with excessive includes
Date: Mon, 23 Oct 2006 03:31:16 +0200
User-Agent: KMail/1.9.5
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Randy Dunlap <rdunlap@xenotime.net>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
References: <20061018091944.GA5343@martell.zuzino.mipt.ru> <200610230242.58647.ak@suse.de> <20061023010812.GE25210@parisc-linux.org>
In-Reply-To: <20061023010812.GE25210@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610230331.16573.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 October 2006 03:08, Matthew Wilcox wrote:
> On Mon, Oct 23, 2006 at 02:42:58AM +0200, Andi Kleen wrote:
> > 
> > > /*+
> > >  * Provides: struct sched
> > >  * Provides: total_forks, nr_threads, process_counts, nr_processes()
> > >  * Provides: nr_running(), nr_uninterruptible(), nr_active(), nr_iowait(), weighted_cpuload()
> > >  */
> > 
> > That's ugly.  If it needs that i don't think it's a good idea.
> > We really want standard C, not some Linux dialect.
> 
> Um, that's a comment.  It's standard C.

If you require it to do something it isn't a comment anymore -- it would become
a language extension.

> 
> Here's the problem.  If a file needs canonicalize_irq(), it should
> include <linux/interrupt.h> (which eventually ends up including
> asm/irq,h), and not <asm/irq.h> (where it's defined).
> If a file needs add_wait_queue(), it should include <linux/wait.h>
> (where it's defined) and not <linux/fs.h> (which directly includes
> linux/wait.h>.
> 
> Please define an algorithm which distinguishes the two cases.

Needs are inside {} or in a macro definition
So if the identifier happens after #define or inside {} assume the symbol
is needed from somewhere else, otherwise it is declared here.

That is likely not 100% foolproof, but should be good enough and
the mismatches can be resolved by hand.

-Andi
