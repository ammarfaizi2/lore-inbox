Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262543AbVESPC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbVESPC7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 11:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262548AbVESPCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 11:02:39 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:64969 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262543AbVESPAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 11:00:16 -0400
Subject: Re: Illegal use of reserved word in system.h
From: Steven Rostedt <rostedt@goodmis.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org,
       "Gilbert, John" <JGG@dolby.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Adrian Bunk <bunk@stusta.de>, Arjan van de Ven <arjan@infradead.org>,
       linux-os@analogic.com
In-Reply-To: <Pine.LNX.4.61L.0505191532120.10681@blysk.ds.pg.gda.pl>
References: <2692A548B75777458914AC89297DD7DA08B0866F@bronze.dolby.net>
	 <20050518195337.GX5112@stusta.de>
	 <6EA08D88-7C67-48ED-A9EF-FEAAB92D8B8F@mac.com>
	 <20050519112840.GE5112@stusta.de>
	 <Pine.LNX.4.61.0505190734110.29439@chaos.analogic.com>
	 <1116505655.6027.45.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61L.0505191342460.10681@blysk.ds.pg.gda.pl>
	 <Pine.LNX.4.61.0505190853310.29611@chaos.analogic.com>
	 <jeacmr5mzk.fsf@sykes.suse.de>
	 <1116512140.15866.42.camel@localhost.localdomain>
	 <Pine.LNX.4.61L.0505191532120.10681@blysk.ds.pg.gda.pl>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 19 May 2005 10:59:40 -0400
Message-Id: <1116514780.27471.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-19 at 15:43 +0100, Maciej W. Rozycki wrote:
> On Thu, 19 May 2005, Steven Rostedt wrote:
> 
> > > See create_elf_tables.  The aux table comes after the environment.
> > 
> > As I stated earlier, the page size passed in there is ELF_EXEC_PAGESIZE
> > which may not be the same as PAGE_SIZE.
> 
>  Well, AT_PAGESZ is specified as "system page size".  If we pass something 
> else, then it's asking for troubles.  What comes from AT_PAGESZ is used by 
> userland for stuff like masking arguments for mmap() and mprotect() so 
> it'd better be the right value.

Well, they probably are the same, but then what's the reason for the
lines in binfmt_elf.c:

#if ELF_EXEC_PAGESIZE > PAGE_SIZE
# define ELF_MIN_ALIGN	ELF_EXEC_PAGESIZE
#else
# define ELF_MIN_ALIGN	PAGE_SIZE
#endif


This looks to me that ELF_EXEC_PAGESIZE and PAGE_SIZE may not be the
same. And what's passed to AT_PAGESZ is ELF_EXEC_PAGESIZE.  In mips (as
your email address shows you are interested in) ELF_EXEC_PAGESIZE is
simply defined as PAGE_SIZE.  But in intel i386, it is defined as 4096,
which coincidentally is the same as PAGE_SIZE but there's no guarantee
that this will be the same, unless who ever changes PAGE_SIZE also
remembers to change ELF_EXEC_PAGESIZE.

In arm26 the PAGE_SIZE is configurable (16k or 32k) but the
ELF_EXEC_PAGESIZE stays as 32k.  So is this a bug?

-- Steve
 

