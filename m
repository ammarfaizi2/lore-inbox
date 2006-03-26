Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWCZOkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWCZOkr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 09:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWCZOkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 09:40:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:61677 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750778AbWCZOkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 09:40:46 -0500
Subject: Re: [RFC][PATCH 1/2] Create initial kernel ABI
	header	infrastructure
From: Arjan van de Ven <arjan@infradead.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: linux-kernel@vger.kernel.org, nix@esperi.org.uk, rob@landley.net,
       mmazur@kernel.pl, llh-discuss@lists.pld-linux.org
In-Reply-To: <A6491D09-3BCF-4742-A367-DCE717898446@mac.com>
References: <200603141619.36609.mmazur@kernel.pl>
	 <200603231811.26546.mmazur@kernel.pl>
	 <DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com>
	 <200603241623.49861.rob@landley.net> <878xqzpl8g.fsf@hades.wkstn.nix>
	 <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com>
	 <20060326065205.d691539c.mrmacman_g4@mac.com>
	 <20060326065416.93d5ce68.mrmacman_g4@mac.com>
	 <1143376351.3064.9.camel@laptopd505.fenrus.org>
	 <A6491D09-3BCF-4742-A367-DCE717898446@mac.com>
Content-Type: text/plain
Date: Sun, 26 Mar 2006 16:39:28 +0200
Message-Id: <1143383968.3064.16.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> According to the various standards all symbols beginning with __ are  
> reserved for "The Implementation", including the compiler, the  
> standard library, the kernel, etc.  In order to avoid clashing with  
> any/all of those, I picked the __KABI_ and __kabi_ prefixes for  
> uniqueness.  In theory I could just use __, but there are problems  
> with that too.  For example, note how the current compiler.h files  
> redefine __always_inline to mean something kinda different.

well... the "problem" is there today, and... it's not much of a problem
if at all; there's just a few simple rules to keep it that way which
seem to wkr.

And your __alway_inline example.. that's something that really is kernel
internal and shouldn't be exposed to userland. 


I think the "problem" really is not there if
1) we only use __ symbols like we do today for non-structs
2) avoid including kernel headers in kernel headers as far as possible.
   This means, that if an application wants to use MTD struct 
   "struct mtd_foo" it will have to include the MTD header, but that
   he otherwise never gets it. Eg all such symbols are in a "Yes I
   really want it" header.
3) keep the userspace exposed stuff as small as reasonable. Your
   __always_inline example doesn't make that cut. A struct used as
   ioctl of a subsystem/driver in the header specially for that 
   subsystem/driver does.



