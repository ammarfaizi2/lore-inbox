Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318143AbSIJVFG>; Tue, 10 Sep 2002 17:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318130AbSIJVFG>; Tue, 10 Sep 2002 17:05:06 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:27405 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S318143AbSIJVFC>;
	Tue, 10 Sep 2002 17:05:02 -0400
Date: Tue, 10 Sep 2002 23:09:45 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] scripts: Removed mrproper targets, they are now handled automagically 5/6
Message-ID: <20020910230945.E18386@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20020910225530.A17094@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020910225530.A17094@mars.ravnborg.org>; from sam@ravnborg.org on Tue, Sep 10, 2002 at 10:55:30PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removed mrproper targets from scripts/Makefile and scripts/lxdialog/Makefile
The new clean: and mrproper: handling will delete the files in question.

For lxdialog added a few files that could be left if build were stopped
unexpected.

	Sam

diff -Nru a/scripts/Makefile b/scripts/Makefile
--- a/scripts/Makefile	Tue Sep 10 22:38:01 2002
+++ b/scripts/Makefile	Tue Sep 10 22:38:01 2002
@@ -9,6 +9,8 @@
 # conmakehash:	 Create arrays for initializing the kernel console tables
 # tkparse: 	 Used by xconfig
 
+clean    := kconfig.tk
+
 all: fixdep split-include docproc conmakehash __chmod
 
 # The following temporary rule will make sure that people's
@@ -57,9 +59,4 @@
 $(obj)/split-include $(obj)/docproc $(addprefix $(obj)/,$(tkparse-objs)) \
 $(obj)/conmakehash lxdialog: $(obj)/fixdep
 
-mrproper:
-	@echo 'Making mrproper (scripts)'
-	@rm -f $(tkparse-objs) $(obj)/kconfig.tk
-	@rm -f core $(host-progs)
-	@$(MAKE) -C lxdialog mrproper
 
diff -Nru a/scripts/lxdialog/Makefile b/scripts/lxdialog/Makefile
--- a/scripts/lxdialog/Makefile	Tue Sep 10 22:38:01 2002
+++ b/scripts/lxdialog/Makefile	Tue Sep 10 22:38:01 2002
@@ -15,8 +15,12 @@
 endif
 endif
 
-host-progs := lxdialog
+# Files removed during make clean
+clean := a.out lxtemp.c
 
+# Host executable
+host-progs := lxdialog
+# Additional object files for lxdialog
 lxdialog-objs := checklist.o menubox.o textbox.o yesno.o inputbox.o \
 		 util.o lxdialog.o msgbox.o
 
@@ -39,5 +43,3 @@
 		exit 1 ;\
 	fi
 
-mrproper:
-	@rm -f core $(host-progs) $(lxdialog-objs) ncurses
