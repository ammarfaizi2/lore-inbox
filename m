Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264321AbSIQQii>; Tue, 17 Sep 2002 12:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264323AbSIQQii>; Tue, 17 Sep 2002 12:38:38 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:3851 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S264321AbSIQQih>;
	Tue, 17 Sep 2002 12:38:37 -0400
Date: Tue, 17 Sep 2002 18:42:18 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.35 make race?
Message-ID: <20020917184218.A3625@mars.ravnborg.org>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	linux-kernel@vger.kernel.org
References: <20020917073459.C07F72C1F1@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020917073459.C07F72C1F1@lists.samba.org>; from rusty@rustcorp.com.au on Tue, Sep 17, 2002 at 05:33:45PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2002 at 05:33:45PM +1000, Rusty Russell wrote:
> Hi Kai,
> 
> 	First make -j3 on a 2-way SMP box fails.  The second one
> succeeds.  I think a dependency is missing?

Yep, "if_changed_dep" uses fixdep, so a dependency to scripts is needed.
Added echo_target as well, so the result file is printed as well.
 

===== Makefile 1.297 vs edited =====
--- 1.297/Makefile	Mon Sep 16 02:45:07 2002
+++ edited/Makefile	Tue Sep 17 18:38:37 2002
@@ -323,7 +323,7 @@
 
 AFLAGS_vmlinux.lds.o += -P -C -U$(ARCH)
 
-arch/$(ARCH)/vmlinux.lds.s: arch/$(ARCH)/vmlinux.lds.S FORCE
+arch/$(ARCH)/vmlinux.lds.s: arch/$(ARCH)/vmlinux.lds.S scripts FORCE
 	$(call if_changed_dep,as_s_S)
 
 targets += arch/$(ARCH)/vmlinux.lds.s
@@ -788,6 +788,7 @@
 
 # FIXME Should go into a make.lib or something 
 # ===========================================================================
+echo_target = $(RELDIR)/$@
 
 a_flags = -Wp,-MD,$(depfile) $(AFLAGS) $(NOSTDINC_FLAGS) \
 	  $(modkern_aflags) $(EXTRA_AFLAGS) $(AFLAGS_$(*F).o)
