Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317181AbSFFVCj>; Thu, 6 Jun 2002 17:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317187AbSFFVCh>; Thu, 6 Jun 2002 17:02:37 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:49240 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S317181AbSFFVB1>; Thu, 6 Jun 2002 17:01:27 -0400
Date: Thu, 6 Jun 2002 16:01:27 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200206062101.QAA15457@tomcat.admin.navo.hpc.mil>
To: kaih@khms.westfalen.de (Kai Henningsen), linux-kernel@vger.kernel.org
Subject: Re: If you want kbuild 2.5, tell Linus
cc: linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kaih@khms.westfalen.de (Kai Henningsen):
> 
> phillips@bonn-fries.net (Daniel Phillips)  wrote on 03.06.02 in <E17Esc6-0000v9-00@starship>:
> 
> > Linus has already indicated his position, I guess you were busy writing
> > the post so you didn't notice:
> >
> >   http://marc.theaimsgroup.com/?l=linux-kernel&m=102304528224527&w=2
> >
> > Plus you've got helpers, how could the situation be better?
> 
> I fail to see how this is supposed to work, and I guess so does Keith.
> 
> Kai (a different Kai!) does not seem to want to integrate the core part of  
> kbuild2.5. He seems to want to only pick the low-hanging fruits and make  
> unsupported (and unbelievable) noises about the rest.
> 
> And Linus seems to want to ignore the fact that the core portion of  
> kbuild2.5 is, by its very nature, not something that can be merged  
> "gradually" - just like ALSA, or a new architecture, can't meaningfully be  
> merged "gradually". (And he *also* said that he wasn't interested in  
> pseudo-gradually, i.e. getting the stuff in parts but still making a big  
> exchange.)
> 
> Frankly, I see *absolutely no way* how the current Kai-Linus "merge" can  
> possibly end with something even remotely like Keith's kbuild2.5. Unless  
> Linus changes his approach radically.
> 
> If I were Keith, I'd be rather upset, too.

How about the following approach, which MAY not be practical:

1. Name all of the new Makefiles Makefile.k2.5
2. Create a small wrapper script to define make as "make -f Makefile.k2.5"
   or just define MAKE as make -f Makefile.k2.5 in the top level Makefile.k2.5

Put the kbuild2.5 specific tools in a directory reserved for kbuild2.5
tools.

This should allow both build procedures to reside side by side. Use one
or the other, but don't mix them  (don't build the kernel using one,
then build the modules using the other, though that MIGHT work, it doesn't
have to). It may be necessary to have disjoint configure file names.

To switch between them should take a "make clean", then rename the wrapper
script. Dependant tools should reside in different directories to prevent
name collision. Common tools wouldn't change.

After everyone is happy with the new build procedures, the older one
could be retired. A clean-up patch could then rename the Makefiles and
fix any final targets, though I would favor just leaving that the same
as a pattern for future kbuild evoultion/revolution.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
