Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbTETSVI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 14:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263865AbTETSVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 14:21:08 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:51468 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263861AbTETSVG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 14:21:06 -0400
Date: Tue, 20 May 2003 20:34:03 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Brian Gerst <bgerst@didntduck.org>, Sam Ravnborg <sam@ravnborg.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Update fs Makefiles
Message-ID: <20030520183403.GA1151@mars.ravnborg.org>
Mail-Followup-To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Brian Gerst <bgerst@didntduck.org>, Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <3EC952E9.9080201@quark.didntduck.org> <Pine.LNX.4.44.0305200940130.24017-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305200940130.24017-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 20, 2003 at 09:47:22AM -0500, Kai Germaschewski wrote:
> 
> OTOH, 2.4 does only support "-objs", so people may get confused anyway, 
> and annoyed about having two different Makefiles to maintain in 2.4 and 
> 2.5. Then again, the Makefiles between 2.4 and 2.5 have other differences 
> already, and since they're small and rarely changing, maintaining two sets 
> isn't so much of a pain.

When we shifted syntax for the kernel configuration people di
not complain about compatibility with 2.4. Why not?
Because it is trivial to maintain two simple files with different
namings:
Config.in for 2.4
Kconfig for 2.5

For the Makefiles we have seen a slow shift in syntax, with more and
more being deprecated. So it is becoming a bit annoying to
maintain 2.4 and 2.5 compatibility in the same file.

Idea:
In 2.5 introduce a new default filename for kbuild Makefiles:

	Kmakefile

Then a driver would have: 
2.4	Config.help, Config.in and Makefile
2.5	Kconfig and Kmakefile

This would also allow us to do some simplification of the top-level
Makefile by moving the last steps of building vmlinux out to a seperate
Kmakefile - but this is added bonus, the real driver for this change
would be less hassle for 2.4/2.5 compatbility.

Comments?

	Sam

The patch is trivial.

===== scripts/Makefile.build 1.36 vs edited =====
--- 1.36/scripts/Makefile.build	Thu May  8 22:34:28 2003
+++ edited/scripts/Makefile.build	Tue May 20 20:31:33 2003
@@ -11,7 +11,7 @@
 include .config
 endif
 
-include $(obj)/Makefile
+include $(if $(wildcard $(obj)/Kmakefile),$(obj)/Kmakefile,$(obj)/Makefile)
 
 include scripts/Makefile.lib
 
