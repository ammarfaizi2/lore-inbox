Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbVETMXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVETMXl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 08:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbVETMXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 08:23:41 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:26886 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261439AbVETMXW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 08:23:22 -0400
Date: Fri, 20 May 2005 13:23:21 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org,
       "Gilbert, John" <JGG@dolby.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Adrian Bunk <bunk@stusta.de>, Arjan van de Ven <arjan@infradead.org>,
       linux-os@analogic.com
Subject: Re: Illegal use of reserved word in system.h
In-Reply-To: <1116514780.27471.8.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61L.0505191622060.10681@blysk.ds.pg.gda.pl>
References: <2692A548B75777458914AC89297DD7DA08B0866F@bronze.dolby.net> 
 <20050518195337.GX5112@stusta.de>  <6EA08D88-7C67-48ED-A9EF-FEAAB92D8B8F@mac.com>
  <20050519112840.GE5112@stusta.de>  <Pine.LNX.4.61.0505190734110.29439@chaos.analogic.com>
  <1116505655.6027.45.camel@laptopd505.fenrus.org> 
 <Pine.LNX.4.61L.0505191342460.10681@blysk.ds.pg.gda.pl> 
 <Pine.LNX.4.61.0505190853310.29611@chaos.analogic.com>  <jeacmr5mzk.fsf@sykes.suse.de>
  <1116512140.15866.42.camel@localhost.localdomain> 
 <Pine.LNX.4.61L.0505191532120.10681@blysk.ds.pg.gda.pl>
 <1116514780.27471.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2005, Steven Rostedt wrote:

> Well, they probably are the same, but then what's the reason for the
> lines in binfmt_elf.c:
> 
> #if ELF_EXEC_PAGESIZE > PAGE_SIZE
> # define ELF_MIN_ALIGN	ELF_EXEC_PAGESIZE
> #else
> # define ELF_MIN_ALIGN	PAGE_SIZE
> #endif
> 
> 
> This looks to me that ELF_EXEC_PAGESIZE and PAGE_SIZE may not be the
> same. And what's passed to AT_PAGESZ is ELF_EXEC_PAGESIZE.  In mips (as
> your email address shows you are interested in) ELF_EXEC_PAGESIZE is
> simply defined as PAGE_SIZE.  But in intel i386, it is defined as 4096,

 And for MIPS PAGE_SIZE is also variable (currently one of: 4k, 16k, 64k).

> which coincidentally is the same as PAGE_SIZE but there's no guarantee
> that this will be the same, unless who ever changes PAGE_SIZE also
> remembers to change ELF_EXEC_PAGESIZE.

 That's the maintainer's problem.

> In arm26 the PAGE_SIZE is configurable (16k or 32k) but the
> ELF_EXEC_PAGESIZE stays as 32k.  So is this a bug?

 I guess so.  Unless these smaller pages are always handled in pairs by 
Linux.  That would be a legitimate case of ELF_EXEC_PAGESIZE != PAGE_SIZE.

  Maciej
