Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266835AbUHaTps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266835AbUHaTps (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 15:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269035AbUHaTmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 15:42:54 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:59975 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S266835AbUHaTjh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 15:39:37 -0400
Date: Tue, 31 Aug 2004 21:41:35 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc1-mm2
Message-ID: <20040831194135.GB19724@mars.ravnborg.org>
Mail-Followup-To: Gene Heskett <gene.heskett@verizon.net>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20040830235426.441f5b51.akpm@osdl.org> <200408311454.48673.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408311454.48673.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 02:54:48PM -0400, Gene Heskett wrote:
> make modules_install
> /usr/src/linux-2.6.9-rc1-mm2/scripts/Makefile.modinst:24: target 
> `fs/nls/nls_koi8-r.ko' given more than once in the same rule.
> /usr/src/linux-2.6.9-rc1-mm2/scripts/Makefile.modinst:24: target 
> `fs/nls/nls_koi8-ru.ko' given more than once in the same rule.
> /usr/src/linux-2.6.9-rc1-mm2/scripts/Makefile.modinst:24: target 
> `fs/nls/nls_koi8-u.ko' given more than once in the same rule.

Thanks!
Know issue (reported off-list) - can be fixed with below patch.

	Sam

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/31 21:36:26+02:00 sam@mars.ravnborg.org 
#   kbuild: Fix modules_install
#   
#   modules_install failed for modules with 'ko' in their name.
#   Fixes this.
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# scripts/Makefile.modinst
#   2004/08/31 21:36:09+02:00 sam@mars.ravnborg.org +1 -1
#   Fix installing of modules with ko in their name - do not find too many filenames in $(MODVERDIR)
# 
diff -Nru a/scripts/Makefile.modinst b/scripts/Makefile.modinst
--- a/scripts/Makefile.modinst	2004-08-31 21:40:31 +02:00
+++ b/scripts/Makefile.modinst	2004-08-31 21:40:31 +02:00
@@ -9,7 +9,7 @@
 
 #
 
-__modules := $(sort $(shell grep -h .ko /dev/null $(wildcard $(MODVERDIR)/*.mod)))
+__modules := $(sort $(shell grep -h '\.ko' /dev/null $(wildcard $(MODVERDIR)/*.mod)))
 modules := $(patsubst %.o,%.ko,$(wildcard $(__modules:.ko=.o)))
 
 .PHONY: $(modules)
