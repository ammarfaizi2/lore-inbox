Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbWJTMcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbWJTMcf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 08:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbWJTMcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 08:32:35 -0400
Received: from ns1.suse.de ([195.135.220.2]:21639 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751629AbWJTMcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 08:32:35 -0400
Date: Fri, 20 Oct 2006 14:32:33 +0200
From: Marcus Meissner <meissner@suse.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       arjan@linux.intel.com
Subject: Re: [PATCH] binfmt_elf: randomize PIE binaries (2nd try)
Message-ID: <20061020123233.GA10093@suse.de>
References: <20061020115527.GB14448@suse.de> <9a8748490610200520j6d708a52p2f90effd4b8893d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490610200520j6d708a52p2f90effd4b8893d9@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 02:20:31PM +0200, Jesper Juhl wrote:
> On 20/10/06, Marcus Meissner <meissner@suse.de> wrote:
> >Randomizes -pie compiled binaries from PAGE_SIZE up to
> >ELF_ET_DYN_BASE.
> >
> >0 -> PAGE_SIZE is excluded to allow NULL ptr accesses
> >to fail.
> >
> >Signed-off-by: Marcus Meissner <meissner@suse.de>
> >
> >----
> > binfmt_elf.c |    8 +++++++-
> > 1 file changed, 7 insertions(+), 1 deletion(-)
> >
> >--- linux-2.6.18/fs/binfmt_elf.c.xx     2006-10-20 10:42:03.000000000 +0200
> >+++ linux-2.6.18/fs/binfmt_elf.c        2006-10-20 10:51:27.000000000 +0200
> >@@ -856,7 +856,13 @@
> >                         * default mmap base, as well as whatever program 
> >                         they
> >                         * might try to exec.  This is because the brk will
> >                         * follow the loader, and is not movable.  */
> >-                       load_bias = ELF_PAGESTART(ELF_ET_DYN_BASE - vaddr);
> >+                       if (current->flags & PF_RANDOMIZE)
> >+                               load_bias = randomize_range(PAGE_SIZE,
> >+                                                           
> >ELF_ET_DYN_BASE,
> >+                                                           0);
> 
> How about putting the two lines above on one line?  ^^^^^

My editor said it would end at column 80. Starting from 0 it would col 79
actually, but I did not want to risk it.

Ciao, Marcus
