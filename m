Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbUBYTit (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 14:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbUBYTir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 14:38:47 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:57494 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261277AbUBYThl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 14:37:41 -0500
Date: Wed, 25 Feb 2004 21:39:27 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: "James H. Cloos Jr." <cloos@jhcloos.com>, linux-kernel@vger.kernel.org
Subject: Re: make help ARCH=xx fun
Message-ID: <20040225203927.GA2763@mars.ravnborg.org>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	"James H. Cloos Jr." <cloos@jhcloos.com>,
	linux-kernel@vger.kernel.org
References: <m3y8qwv78e.fsf@lugabout.jhcloos.org> <20040222095021.GB2266@mars.ravnborg.org> <20040224215548.GF1052@smtp.west.cox.net> <20040225190049.GB2474@mars.ravnborg.org> <20040225180858.GW1052@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040225180858.GW1052@smtp.west.cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > I will try to come up with a patch the uses a file named
> > arch/$(ARCH)/configs/index.txt
> 
> The 'issue' with configs/index.txt, I'll wager, is that for every new
> board, that's one more file to modify (and thus possibly conflict on).

What about the following patch.
This adds the support to the top-level Makefile, enabling this for all
_defconfig users.
I used 'printf' to get proper alignment. Otherwise arm for example
looked really ugly.
Is printf generally supported?

	Sam



===== Makefile 1.456 vs edited =====
--- 1.456/Makefile	Sun Feb 15 03:42:40 2004
+++ edited/Makefile	Wed Feb 25 21:34:34 2004
@@ -889,6 +889,9 @@
 # Brief documentation of the typical targets used
 # ---------------------------------------------------------------------------
 
+boards := $(wildcard $(srctree)/arch/$(ARCH)/configs/*_defconfig)
+boards := $(notdir $(boards))
+
 help:
 	@echo  'Cleaning targets:'
 	@echo  '  clean		  - remove most generated files but keep the config'
@@ -914,6 +917,11 @@
 	@$(if $(archhelp),$(archhelp),\
 		echo '  No architecture specific help defined for $(ARCH)')
 	@echo  ''
+	@$(if $(boards), \
+		$(foreach b, $(boards), \
+		printf " %24s - Build for %s\\n" $(b) $(b);) \
+		echo '')
+	
 	@echo  '  make V=0|1 [targets] 0 => quiet build (default), 1 => verbose build'
 	@echo  '  make O=dir [targets] Locate all output files in "dir", including .config'
 	@echo  '  make C=1   [targets] Check all c source with checker tool'
