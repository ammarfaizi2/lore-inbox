Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030448AbVIIUOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030448AbVIIUOm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 16:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030450AbVIIUOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 16:14:41 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:39109 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030448AbVIIUOk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 16:14:40 -0400
Date: Fri, 9 Sep 2005 21:14:35 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: sam@ravnborg.org, Luben Tuikov <luben_tuikov@adaptec.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 2.6.13 1/20] aic94xx: Makefile
Message-ID: <20050909201435.GB9623@ZenIV.linux.org.uk>
References: <4321E335.5010805@adaptec.com> <20050909201834.GA24521@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050909201834.GA24521@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2005 at 12:18:34AM +0400, Alexey Dobriyan wrote:
> On Fri, Sep 09, 2005 at 03:32:05PM -0400, Luben Tuikov wrote:
> > --- linux-2.6.13-orig/drivers/scsi/aic94xx/Makefile
> > +++ linux-2.6.13/drivers/scsi/aic94xx/Makefile
> 
> > +CHECK = sparse -Wbitwise
> 
> 	make C=1 CHECK="sparse -Wbitwise"
> or
> 	make C=1
Or patch below and use make C=1 CF=-Wbitwise...

Allows to add to sparse arguments without mutilating makefiles - just
pass CF=<arguments> and they will be added to CHECKFLAGS.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-git7-kconfig/Makefile RC13-git7-CHECKFLAGS/Makefile
--- RC13-git7-kconfig/Makefile	2005-09-07 13:54:44.000000000 -0400
+++ RC13-git7-CHECKFLAGS/Makefile	2005-09-07 13:54:46.000000000 -0400
@@ -333,7 +333,7 @@
 PERL		= perl
 CHECK		= sparse
 
-CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__
+CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ $(CF)
 MODFLAGS	= -DMODULE
 CFLAGS_MODULE   = $(MODFLAGS)
 AFLAGS_MODULE   = $(MODFLAGS)
