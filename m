Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261532AbSJQRAU>; Thu, 17 Oct 2002 13:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261545AbSJQRAU>; Thu, 17 Oct 2002 13:00:20 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50959 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261532AbSJQRAS>; Thu, 17 Oct 2002 13:00:18 -0400
Date: Thu, 17 Oct 2002 10:08:19 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@infradead.org>
cc: Crispin Cowan <crispin@wirex.com>, Greg KH <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make LSM register functions GPLonly exports
In-Reply-To: <20021017175403.A32516@infradead.org>
Message-ID: <Pine.LNX.4.44.0210170958340.6739-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Note that if this fight ends up being a major issue, I'm just going to 
remove LSM and let the security vendors do their own thing. So far

 - I have not seen a lot of actual usage of the hooks
 - seen a number of people who still worry that the hooks degrade 
   performance in critical areas
 - the worry that people use it for non-GPL'd modules is apparently real, 
   considering Crispin's reply.

I will re-iterate my stance on the GPL and kernel modules:

  There is NOTHING in the kernel license that allows modules to be 
  non-GPL'd. 

  The _only_ thing that allows for non-GPL modules is copyright law, and 
  in particular the "derived work" issue. A vendor who distributes non-GPL 
  modules is _not_ protected by the module interface per se, and should 
  feel very confident that they can show in a court of law that the code 
  is not derived.

  The module interface has NEVER been documented or meant to be a GPL 
  barrier. The COPYING clearly states that the system call layer is such a 
  barrier, so if you do your work in user land you're not in any way 
  beholden to the GPL. The module interfaces are not system calls: there 
  are system calls used to _install_ them, but the actual interfaces are
  not.

  The original binary-only modules were for things that were pre-existing 
  works of code, ie drivers and filesystems ported from other operating 
  systems, which thus could clearly be argued to not be derived works, and 
  the original limited export table also acted somewhat as a barrier to 
  show a level of distance.

In short, Crispin: I'm going to apply the patch, and if you as a copyright 
holder of that file disagree, I will simply remove all of he LSM code from 
the kernel. I think it's very clear that a LSM module is a derived work, 
and thus copyright law and the GPL are not in any way unclear about it. 

If people think they can avoid the GPL by using function pointers, they 
are WRONG. And they have always been wrong.

			Linus

