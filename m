Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264211AbUEMOBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264211AbUEMOBO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 10:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264210AbUEMOBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 10:01:14 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:54262 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264213AbUEMOBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 10:01:08 -0400
Date: Thu, 13 May 2004 16:01:02 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: 2.6.6-mm2: bk-driver-core-module-fix.patch no longer required
Message-ID: <20040513140102.GE22202@fs.tum.de>
References: <20040513032736.40651f8e.akpm@osdl.org> <200405131542.23710.ornati@fastwebnet.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405131542.23710.ornati@fastwebnet.it>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2004 at 03:42:23PM +0200, Paolo Ornati wrote:
> On Thursday 13 May 2004 12:27, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6/2.6.6
> >-mm2/
> 
>   CC      kernel/module.o
> kernel/module.c:730: error: redefinition of `add_attribute'
> kernel/module.c:382: error: `add_attribute' previously defined here
> kernel/module.c:382: warning: `add_attribute' defined but not used
> make[1]: *** [kernel/module.o] Error 1
> make: *** [kernel] Error 2

bk-driver-core-module-fix.patch is no longer required (a different fix 
is in bk-driver-core.patch).

Simply _revert_ the patch below.

> bye
> 
> -- 
> 	Paolo Ornati

cu
Adrian




--- 25/kernel/module.c~bk-driver-core-module-fix	2004-05-10 04:47:54.697175440 -0700
+++ 25-akpm/kernel/module.c	2004-05-10 04:47:54.701174832 -0700
@@ -726,6 +726,12 @@ static inline int sysfs_unload_setup(str
 {
 	return 0;
 }
+
+static int add_attribute(struct module *mod, struct kernel_param *kp)
+{
+	return 0;
+}
+
 #endif /* CONFIG_MODULE_UNLOAD */
 
 #ifdef CONFIG_OBSOLETE_MODPARM

_
