Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262273AbVBQIlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbVBQIlY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 03:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262278AbVBQIlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 03:41:24 -0500
Received: from gate.crashing.org ([63.228.1.57]:36256 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262273AbVBQIlU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 03:41:20 -0500
Subject: Re: [PATCH] Fix possible race with 4level-fixup.h
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <421456F1.6090100@yahoo.com.au>
References: <1108624747.5383.52.camel@gaston>
	 <421456F1.6090100@yahoo.com.au>
Content-Type: text/plain
Date: Thu, 17 Feb 2005 19:40:48 +1100
Message-Id: <1108629648.5425.73.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-17 at 19:33 +1100, Nick Piggin wrote:
> Benjamin Herrenschmidt wrote:
> > Hi !
> > 
> > When using 4level-fixup.h, a PMD page may end up beeing freed before the
> > matching PGD entry is cleared due to the way the compatibility macros
> > work. This can cause nasty races on some architectures.
> > 
> > This patch fixes it by defining pud_clear() to be pgd_clear(). That
> > means we'll actually write 0 twice, a small price to pay here,
> > especially seeing how easy it is to convert to the new headers anyway
> > (hint hint, ppc & ppc64 patches as soon as 2.6.11 is out).
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > 
> > Index: linux-work/include/asm-generic/4level-fixup.h
> > ===================================================================
> > --- linux-work.orig/include/asm-generic/4level-fixup.h	2005-01-24 17:09:49.000000000 +1100
> > +++ linux-work/include/asm-generic/4level-fixup.h	2005-02-17 18:10:38.000000000 +1100
> > @@ -24,7 +24,7 @@
> >  #define pud_bad(pud)			0
> >  #define pud_present(pud)		1
> >  #define pud_ERROR(pud)			do { } while (0)
> > -#define pud_clear(pud)			do { } while (0)
> > +#define pud_clear(pud)			pgd_clear((pgd_t *)(pud))
> >  
> 
> Just a small nit - no cast needed here.

Well, do you know ? pud is a pud_t* and the arch is free to implement
pgd_clear as an inline with strong typing no ? 

Ben.


