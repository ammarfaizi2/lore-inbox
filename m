Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbTH3XcA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 19:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbTH3Xb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 19:31:26 -0400
Received: from aneto.able.es ([212.97.163.22]:48258 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S262231AbTH3XbX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 19:31:23 -0400
Date: Sun, 31 Aug 2003 01:31:20 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Marcelo Tosatti <marcelo@parcelfarce.linux.theplanet.co.uk>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] check_gcc for i386
Message-ID: <20030830233120.GC20429@werewolf.able.es>
References: <Pine.LNX.4.44.0308301957440.20117-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.44.0308301957440.20117-100000@logos.cnet>; from marcelo@parcelfarce.linux.theplanet.co.uk on Sun, Aug 31, 2003 at 00:58:10 +0200
X-Mailer: Balsa 2.0.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 08.31, Marcelo Tosatti wrote:
> 
> 
> On Sun, 31 Aug 2003, J.A. Magallon wrote:
> 
> > 
> > On 08.30, Marcelo Tosatti wrote:
> > > 
> > > Hello,
> > > 
> > > Here goes -pre2. It contains an USB update, PPC merge, m68k merge, IDE
> > > changes from Alan, network drivers update from Jeff, amongst other fixes
> > > and updates.
> > > 
> > 
> > New try...
> > Plz, could you include this on your queue ?
> > 
> > --- linux-2.4.21-bp1/arch/i386/Makefile.orig	2003-06-18 23:40:25.000000000 +0200
> > +++ linux-2.4.21-bp1/arch/i386/Makefile	2003-06-18 23:59:25.000000000 +0200
> > @@ -53,11 +53,11 @@
> >  endif
> >  
> >  ifdef CONFIG_MPENTIUMIII
> > -CFLAGS += -march=i686
> > +CFLAGS += $(call check_gcc,-march=pentium3,-march=i686)
> >  endif
> >  
> >  ifdef CONFIG_MPENTIUM4
> > -CFLAGS += -march=i686
> > +CFLAGS += $(call check_gcc,-march=pentium4,-march=i686)
> >  endif
> >  
> >  ifdef CONFIG_MK6
> 
> OK, I forgot what that does. Can you please explain in detail what 
> check_gcc does. 
> 
> 

arch/i386/Makefile:

check_gcc = $(shell if $(CC) $(1) -S -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)

So

$(call check_gcc,-march=pentium3,-march=i686)

checks if gcc supports -march=pentium3 and returns it, if not it returns the
fallbask (-march=i686). So it changes i686 to pentium3 if supported by the
compiler. Same for P4. It will help in instruction scheduling and so on.

I will also answer here to Andre...

> 
> This can be a potentially harmful change, suddenly exposing compiler 
> bugs and other compiler related problems in the kernel code we have not 
> yet seen. On one side, these bugs _should_ get fixed, on the other side, 
> we might not find them all before release. Also, the pentium3 and 
> pentium4 options have been known to compile for example bad SSE code in 
> some gcc versions, something that's giving me a feeling those gcc 
> options may be a little immature to use for a stable kernel series.
> 

Testing till now:
- Myself ;), on PIII and P4, and also on PII (with additional patch I
  would like to submit if this goes in...), all the gccs in mandrake
  since 2.96, I think, to 3.3.1
- Some people apart from me is using it and I have not received any
  complaint about this.
- My -jam patchset has survived benchmarks of rwhron@earthlink.net,
  see http://home.earthlink.net/~rwhron/kernel/bigbox.html.
. It is in 2.6 and nobody has showed any problem.
- We are still in early -pre, so its time to chase bugs...;)

Any question/comment ?

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-1mdk))
