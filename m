Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265483AbTFMSSi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 14:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265476AbTFMSQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 14:16:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27860 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265481AbTFMSPc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 14:15:32 -0400
Date: Fri, 13 Jun 2003 19:29:18 +0100
From: Matthew Wilcox <willy@debian.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Matthew Wilcox <willy@debian.org>, Linus Torvalds <torvalds@transmeta.com>,
       Andrew Morton <akpm@zip.com.au>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Consolidate Kconfigs for binfmts
Message-ID: <20030613182918.GC30843@parcelfarce.linux.theplanet.co.uk>
References: <20030613130719.GX30843@parcelfarce.linux.theplanet.co.uk> <Pine.GSO.4.21.0306131523490.13821-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0306131523490.13821-100000@vervain.sonytel.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2003 at 03:24:34PM +0200, Geert Uytterhoeven wrote:
> On Fri, 13 Jun 2003, Matthew Wilcox wrote:
> > +config BINFMT_MISC
> > +	tristate "Kernel support for MISC binaries"
> > +	---help---
> 
> > +	  You must say Y to "/proc file system support" (CONFIG_PROC_FS) to
> > +	  use this part of the kernel.
> 
> You don't want to add an explicit dependency?

I was thinking about this and decided to check it out.  It's actually
not true any more.  binfmt_misc was converted (back in 2.4) to be its
own filesystem.  If binfmt_misc is compiled in or as a module (?!),
procfs creates somewhere for you to mount it (/proc/sys/fs/binfmt_misc)
but there's no need to mount it there.

I note that if you have CONFIG_SYSCTL=n, it will actually silently fail
to create this directory.

#ifdef CONFIG_SYSCTL
        proc_sys_root = proc_mkdir("sys", 0);
#endif
#if defined(CONFIG_BINFMT_MISC) || defined(CONFIG_BINFMT_MISC_MODULE)
        proc_mkdir("sys/fs", 0);
        proc_mkdir("sys/fs/binfmt_misc", 0);
#endif

So I guess I'll remove the bit from the helptext about procfs
and substitute some better words instead.  Maybe I'll update
Documentation/binfmt_misc too.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
