Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbVIMTdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbVIMTdO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 15:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932681AbVIMTdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 15:33:14 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:27337 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932656AbVIMTdM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 15:33:12 -0400
Subject: Re: [PATCH] Permanently fix kernel configuration include mess
From: Josh Boyer <jdub@us.ibm.com>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Joern Engel <joern@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <4327242B.5050806@didntduck.org>
References: <20050913135622.GA30675@phoenix.infradead.org>
	 <20050913150825.A23643@flint.arm.linux.org.uk>
	 <20050913155012.C23643@flint.arm.linux.org.uk>
	 <20050913165954.GA31461@phoenix.infradead.org>
	 <20050913190409.B26494@flint.arm.linux.org.uk>
	 <4327242B.5050806@didntduck.org>
Content-Type: text/plain
Date: Tue, 13 Sep 2005 14:33:04 -0500
Message-Id: <1126639985.3209.9.camel@windu.rchland.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-13 at 15:10 -0400, Brian Gerst wrote:
> Russell King wrote:
> > On Tue, Sep 13, 2005 at 05:59:54PM +0100, Joern Engel wrote:
> > 
> >>On Tue, 13 September 2005 15:50:12 +0100, Russell King wrote:
> >>
> >>>Subject: [KBUILD] Permanently fix kernel configuration include mess.
> >>>
> >>>Include autoconf.h into every kernel compilation via the gcc
> >>>command line using -imacros.  This ensures that we have the
> >>>kernel configuration included from the start, rather than
> >>>relying on each file having #include <linux/config.h> as
> >>>appropriate.  History has shown that this is something which
> >>>is difficult to get right.
> >>>
> >>>Since we now include the kernel configuration automatically,
> >>>make configcheck becomes meaningless, so remove it.
> >>>
> >>>Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> >>
> >>If it helps:
> >>Signed-off-by: Joern Engel <joern@wh.fh-wedel.de>
> > 
> > 
> > Might help more if I copied (or sent this to) akpm. 8)
> > 
> > diff --git a/Makefile b/Makefile
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -346,7 +346,8 @@ AFLAGS_KERNEL	=
> >  # Use LINUXINCLUDE when you must reference the include/ directory.
> >  # Needed to be compatible with the O= option
> >  LINUXINCLUDE    := -Iinclude \
> > -                   $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include)
> > +                   $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include) \
> > +		   -imacros include/linux/autoconf.h
> >  
> >  CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
> >  
> > @@ -1247,11 +1248,6 @@ tags: FORCE
> >  # Scripts to check various things for consistency
> >  # ---------------------------------------------------------------------------
> >  
> > -configcheck:
> > -	find * $(RCS_FIND_IGNORE) \
> > -		-name '*.[hcS]' -type f -print | sort \
> > -		| xargs $(PERL) -w scripts/checkconfig.pl
> > -
> >  includecheck:
> >  	find * $(RCS_FIND_IGNORE) \
> >  		-name '*.[hcS]' -type f -print | sort \
> > 
> > 
> 
> The patch should also remove the checkconfig.pl script.

That could probably be done in a later cleanup patch that removes all
"#include <linux/config.h>" statements as well.  Sounds like a job for
the kernel janitors project.

josh

