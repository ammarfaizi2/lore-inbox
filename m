Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262396AbSJDUOE>; Fri, 4 Oct 2002 16:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262386AbSJDUMX>; Fri, 4 Oct 2002 16:12:23 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:7172 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S262383AbSJDUMQ>;
	Fri, 4 Oct 2002 16:12:16 -0400
Date: Fri, 4 Oct 2002 22:17:08 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       Sam Ravnborg <sam@ravnborg.org>, kbuild-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: RfC: Don't cd into subdirs during kbuild
Message-ID: <20021004221708.A533@mars.ravnborg.org>
Mail-Followup-To: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
	Sam Ravnborg <sam@ravnborg.org>, kbuild-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20021003223054.A31484@mars.ravnborg.org> <Pine.LNX.4.44.0210031536370.24570-100000@chaos.physics.uiowa.edu> <20021004210701.A22726@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021004210701.A22726@mars.ravnborg.org>; from sam@ravnborg.org on Fri, Oct 04, 2002 at 09:07:01PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2002 at 09:07:01PM +0200, Sam Ravnborg wrote:
> On Thu, Oct 03, 2002 at 03:38:22PM -0500, Kai Germaschewski wrote:
> > You must be missing some of the changes (My first push to bkbits was 
> > incomplete, since I did inadvertently edit Makefile without checking it 
> > out, I do that mistake all the time...). It's fixed in the current repo.
> 
> Did a pull from bkbits at 18:30 CET, something like 09:30 pacific I think.

make xconfig is broken.
The following fixes this:

===== scripts/Makefile 1.18 vs edited =====
--- 1.18/scripts/Makefile	Thu Oct  3 20:20:25 2002
+++ edited/scripts/Makefile	Fri Oct  4 22:13:32 2002
@@ -30,6 +30,8 @@
 # but it is not worth the effort to generate the dependencies.
 # The alternative solution to always generate it is fairly fast.
 # FORCE it to remake
+kconfig.tk: $(obj)/kconfig.tk
+
 $(obj)/kconfig.tk: $(srctree)/arch/$(ARCH)/config.in $(obj)/tkparse FORCE
 	@echo '  Generating $@'
 	@(                                                      \
