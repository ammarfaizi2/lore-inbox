Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbWJWBIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWJWBIP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 21:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbWJWBIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 21:08:15 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:40859 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1750984AbWJWBIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 21:08:14 -0400
Date: Sun, 22 Oct 2006 19:08:12 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Andi Kleen <ak@suse.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Randy Dunlap <rdunlap@xenotime.net>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: dealing with excessive includes
Message-ID: <20061023010812.GE25210@parisc-linux.org>
References: <20061018091944.GA5343@martell.zuzino.mipt.ru> <Pine.LNX.4.62.0610221956380.29899@pademelon.sonytel.be> <20061023003111.GD25210@parisc-linux.org> <200610230242.58647.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610230242.58647.ak@suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2006 at 02:42:58AM +0200, Andi Kleen wrote:
> 
> > /*+
> >  * Provides: struct sched
> >  * Provides: total_forks, nr_threads, process_counts, nr_processes()
> >  * Provides: nr_running(), nr_uninterruptible(), nr_active(), nr_iowait(), weighted_cpuload()
> >  */
> 
> That's ugly.  If it needs that i don't think it's a good idea.
> We really want standard C, not some Linux dialect.

Um, that's a comment.  It's standard C.

> In theory it is even to do it automated without comments
> just based on the referenced symbols, except if stuff is hidden in macros 
> (but then the include defining the macro should have the right includes
> anyways). Another issue would be different name spaces - if there is both
> typedef foo and struct foo and nested local foo a script might have a little trouble 
> distingushing them, but i suspect that won't be a big issue.

Sorry, I assumed you'd've spent some time thinking about the problem.

Here's the problem.  If a file needs canonicalize_irq(), it should
include <linux/interrupt.h> (which eventually ends up including
asm/irq,h), and not <asm/irq.h> (where it's defined).
If a file needs add_wait_queue(), it should include <linux/wait.h>
(where it's defined) and not <linux/fs.h> (which directly includes
linux/wait.h>.

Please define an algorithm which distinguishes the two cases.
