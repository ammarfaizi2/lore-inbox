Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265395AbUGSS3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265395AbUGSS3e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 14:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265477AbUGSS3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 14:29:34 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:9470 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265395AbUGSS3a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 14:29:30 -0400
Date: Mon, 19 Jul 2004 14:29:25 -0400
From: "George G. Davis" <gdavis@mvista.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow `make O=<obj> {cscope,tags}` to work
Message-ID: <20040719182925.GC1890@mvista.com>
References: <20040719171759.GA1890@mvista.com> <20040719192430.GA7522@mars.ravnborg.org> <20040719173654.GB1890@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040719173654.GB1890@mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2004 at 01:36:54PM -0400, George G. Davis wrote:
> On Mon, Jul 19, 2004 at 09:24:30PM +0200, sam@ravnborg.org wrote:
> > On Mon, Jul 19, 2004 at 01:17:59PM -0400, George G. Davis wrote:
> 
> <snip>
> 
> > >  endef
> > >  
> > > -quiet_cmd_cscope-file = FILELST cscope.files
> > > -      cmd_cscope-file = $(all-sources) > cscope.files
> > > +quiet_cmd_cscope-file = FILELST $(obj)/cscope.files
> > > +      cmd_cscope-file = $(all-sources) > $(obj)/cscope.files
> > The $(obj) in this line should not be needed. Current directory
> > defaults to $(obj) equals $(objtree) when executing make cscope.
> 
> Yep, I got carried away there, Thanks. Should I resubmit a revised patch?

Ok, after clutzing about with bk fix, etc., here's the revised patch:

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/07/19 14:24:28-04:00 gdavis@davisg.ne.client2.attbi.com 
#   Makefile:
#     Allow `make O=<obj> {cscope,tags}` to work
# 
# Makefile
#   2004/07/19 14:17:25-04:00 gdavis@davisg.ne.client2.attbi.com +6 -6
#   Allow `make O=<obj> {cscope,tags}` to work
# 
diff -Nru a/Makefile b/Makefile
--- a/Makefile	2004-07-19 14:24:43 -04:00
+++ b/Makefile	2004-07-19 14:24:43 -04:00
@@ -1009,19 +1009,19 @@
 # ---------------------------------------------------------------------------
 
 define all-sources
-	( find . $(RCS_FIND_IGNORE) \
+	( find $(srctree) $(RCS_FIND_IGNORE) \
 	       \( -name include -o -name arch \) -prune -o \
 	       -name '*.[chS]' -print; \
-	  find arch/$(ARCH) $(RCS_FIND_IGNORE) \
+	  find $(srctree)/arch/$(ARCH) $(RCS_FIND_IGNORE) \
 	       -name '*.[chS]' -print; \
-	  find security/selinux/include $(RCS_FIND_IGNORE) \
+	  find $(srctree)/security/selinux/include $(RCS_FIND_IGNORE) \
 	       -name '*.[chS]' -print; \
-	  find include $(RCS_FIND_IGNORE) \
+	  find $(srctree)/include $(RCS_FIND_IGNORE) \
 	       \( -name config -o -name 'asm-*' \) -prune \
 	       -o -name '*.[chS]' -print; \
-	  find include/asm-$(ARCH) $(RCS_FIND_IGNORE) \
+	  find $(srctree)/include/asm-$(ARCH) $(RCS_FIND_IGNORE) \
 	       -name '*.[chS]' -print; \
-	  find include/asm-generic $(RCS_FIND_IGNORE) \
+	  find $(srctree)/include/asm-generic $(RCS_FIND_IGNORE) \
 	       -name '*.[chS]' -print )
 endef
 

--
Regards,
George
