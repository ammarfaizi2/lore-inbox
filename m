Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261840AbREYUuE>; Fri, 25 May 2001 16:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbREYUty>; Fri, 25 May 2001 16:49:54 -0400
Received: from mailgate.indstate.edu ([139.102.15.118]:39057 "EHLO
	mailgate.indstate.edu") by vger.kernel.org with ESMTP
	id <S261840AbREYUtu>; Fri, 25 May 2001 16:49:50 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rich Baum <richbaum@acm.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, richbaum@acm.org (Rich Baum)
Subject: Re: [PATCH] warning fixes for 2.4.5pre5
Date: Fri, 25 May 2001 15:47:29 -0500
X-Mailer: KMail [version 1.2.1]
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <E153KAG-0006k7-00@the-village.bc.nu>
In-Reply-To: <E153KAG-0006k7-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <8860416539B@coral.indstate.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 May 2001 11:10 am, Alan Cox wrote:
> > This patch has been tested and the code does compile.
> >
> > Rich
> >
> > diff -urN -X /linux/dontdiff linux/arch/i386/math-emu/fpu_trig.c
> > rb/arch/i386/math-emu/fpu_trig.c
> > --- linux/arch/i386/math-emu/fpu_trig.c	Fri Apr  6 12:42:47 2001
> > +++ rb/arch/i386/math-emu/fpu_trig.c	Tue May 22 16:44:57 2001
> > @@ -1543,6 +1543,7 @@
> >  	  EXCEPTION(EX_INTERNAL | 0x116);
> >  	  return;
> >  #endif /* PARANOID */
> > +	  return;
>
> This seems to be a change in behaviour. Have you done a glibc fpu test on
> the changes ?

I used objdump on the fpu_trig.o files in both trees and they do differ.  
When I use break instead of return in my tree the two files are the same.  
Here is a revised patch that fixes the warning and produces the same assembly 
code code as the version in Linus' tree.

 
diff -urN -X /linux/dontdiff linux/arch/i386/math-emu/fpu_trig.c
rb/arch/i386/math-emu/fpu_trig.c
--- linux/arch/i386/math-emu/fpu_trig.c	Fri Apr  6 12:42:47 2001
+++ rb/arch/i386/math-emu/fpu_trig.c	Tue May 22 16:44:57 2001
@@ -1543,6 +1543,7 @@
 	  EXCEPTION(EX_INTERNAL | 0x116);
 	  return;
 #endif /* PARANOID */
+	  break;
