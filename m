Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316666AbSFCH2d>; Mon, 3 Jun 2002 03:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317296AbSFCH2d>; Mon, 3 Jun 2002 03:28:33 -0400
Received: from h-64-105-136-78.SNVACAID.covad.net ([64.105.136.78]:1993 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S316666AbSFCH2c>; Mon, 3 Jun 2002 03:28:32 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 3 Jun 2002 00:28:18 -0700
Message-Id: <200206030728.AAA22488@adam.yggdrasil.com>
To: torvalds@transmeta.com
Subject: Trivial patch: linux-2.5.20/Rules.make cleanup
Cc: kaos@ocs.com.au, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	There is a stupid make rule in linux-2.5.20/Rules.make
that uses the "@" prefix to disable command echoing, uses that
for a command to echo the command it is going to run, and the
uses the "@" prefix again to execute the same command with.
The following patch replaces those two lines with one
that just executes the command in the normal way, which "make"
will echo anyhow.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."


--- linux-2.5.20/Rules.make	2002-06-02 18:44:47.000000000 -0700
+++ linux/Rules.make	2002-06-02 23:39:37.000000000 -0700
@@ -315,8 +315,7 @@
 		 $(GENKSYMS) $(genksyms_smp_prefix) -k $(VERSION).$(PATCHLEVEL).$(SUBLEVEL) > $@.tmp
 
 $(MODINCL)/$(MODPREFIX)%.ver: %.c FORCE
-	@echo $(cmd_create_ver)
-	@$(cmd_create_ver)
+	$(cmd_create_ver)
 	@if [ -r $@ ] && cmp -s $@ $@.tmp; then \
 	  echo $@ is unchanged; rm -f $@.tmp; \
 	else \

