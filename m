Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932500AbVISRFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbVISRFP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 13:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbVISRFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 13:05:15 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:62078 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S932502AbVISRFO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 13:05:14 -0400
Date: Mon, 19 Sep 2005 19:06:20 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Help by KConfig expansion
Message-ID: <20050919170620.GA7720@mars.ravnborg.org>
References: <Pine.LNX.4.61.0509170333040.3743@scrub.home> <20050919165735.13962.qmail@web51009.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050919165735.13962.qmail@web51009.mail.yahoo.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I tryed to do this. I saw how the attribute "comment"
> is definded in the zconf.l and zconf.y, and definded
> the the attribute "autorule" exactly the same way. But
> it still don't work. Even though I changed the
> zconf.tab.c_shipped as well but it still dont work.

You need to generate the source using bison.
You must understand that zconf.l is an input file for flex.
Likewise zconf.y is input for bison.

See scripts/kconfig/Makefile for how to generate the files.

	Sam


Or even simpler - apply following patch:

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -129,9 +129,9 @@ HOSTCFLAGS_gconf.o	= `pkg-config gtk+-2.
 
 $(obj)/conf.o $(obj)/mconf.o $(obj)/qconf.o $(obj)/gconf.o $(obj)/kxgettext: $(obj)/zconf.tab.h
 
-$(obj)/zconf.tab.h: $(src)/zconf.tab.h_shipped
-$(obj)/zconf.tab.c: $(src)/zconf.tab.c_shipped
-$(obj)/lex.zconf.c: $(src)/lex.zconf.c_shipped
+#$(obj)/zconf.tab.h: $(src)/zconf.tab.h_shipped
+#$(obj)/zconf.tab.c: $(src)/zconf.tab.c_shipped
+#$(obj)/lex.zconf.c: $(src)/lex.zconf.c_shipped
 
 $(obj)/qconf.o: $(obj)/.tmp_qtcheck
 
@@ -212,7 +212,7 @@ $(obj)/lkc_defs.h: $(src)/lkc_proto.h
 # The following requires flex/bison
 # By default we use the _shipped versions, uncomment the following line if
 # you are modifying the flex/bison src.
-# LKC_GENPARSER := 1
+LKC_GENPARSER := 1
 
 ifdef LKC_GENPARSER
 

