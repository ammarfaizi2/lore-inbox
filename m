Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262590AbVAKBgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262590AbVAKBgd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 20:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbVAKBgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 20:36:00 -0500
Received: from ozlabs.org ([203.10.76.45]:33999 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262689AbVAKBdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 20:33:16 -0500
Subject: Re: issue in the kernel parsing with multiple arguments
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Godse, Radheka" <radheka.godse@intel.com>
Cc: "Tantilov, Emil S" <emil.s.tantilov@intel.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A84708A8E225@orsmsx401.amr.corp.intel.com>
References: <F760B14C9561B941B89469F59BA3A84708A8E225@orsmsx401.amr.corp.intel.com>
Content-Type: text/plain
Date: Mon, 10 Jan 2005 14:10:22 +1100
Message-Id: <1105326622.22093.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-07 at 16:31 -0800, Godse, Radheka wrote:
> Rusty,
> 
> We observed a problem when loading a kernel module that accepts
> multiple arguments for single parameter. The issue happens when the
> number of the arguments exceeds the limit of the parameter.

Thanks, I've enclosed a fix for the direct problem.

Name: Catch module parameter parsing failures
Status: Tested on 2.6.10-bk12
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Radheka Godse <radheka.godse@intel.com> pointed out that parameter
parsing failures allow a module still to be loaded.  Trivial fix.

Index: linux-2.6.10-bk12-Misc/kernel/module.c
===================================================================
--- linux-2.6.10-bk12-Misc.orig/kernel/module.c	2005-01-10 13:11:54.000000000 +1100
+++ linux-2.6.10-bk12-Misc/kernel/module.c	2005-01-10 13:55:15.839488248 +1100
@@ -1706,6 +1706,9 @@
 				 / sizeof(struct kernel_param),
 				 NULL);
 	}
+	if (err < 0)
+		goto arch_cleanup;
+
 	err = mod_sysfs_setup(mod, 
 			      (struct kernel_param *)
 			      sechdrs[setupindex].sh_addr,

-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

