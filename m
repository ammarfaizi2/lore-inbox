Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbUKBW10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbUKBW10 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 17:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbUKBWX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 17:23:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:10642 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262002AbUKBWOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 17:14:31 -0500
Date: Tue, 2 Nov 2004 14:18:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: peterc@gelato.unsw.edu.au, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IA64 build broken... cond_syscall()... Fixes?
Message-Id: <20041102141830.5958d188.akpm@osdl.org>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F02510E27@scsmsx401.amr.corp.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02510E27@scsmsx401.amr.corp.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Luck, Tony" <tony.luck@intel.com> wrote:
>
> 
> >Andrew> Shouldn't we just bite the bullet and hoist all that
> >Andrew> cond_syscall stuff out into its own .c file?
> >
> >OK.  Patch appended.
> >
> >Signed-off-by: Peter Chubb <peterc@gelato.unsw.edu.au>
> >
> 
> Acked-by: Tony Luck
> 
> No surprise that Peter's fix works for me since I'm building
> ia64 systems too.

yup.  It needed a fixlet for other platforms.  I'll scoot it along to Linus
today.

--- 25/kernel/sys_ni.c~sys_ni-fix	2004-11-01 23:17:15.324673272 -0800
+++ 25-akpm/kernel/sys_ni.c	2004-11-01 23:17:36.497454520 -0800
@@ -1,6 +1,9 @@
-#include <asm/unistd.h>
+
+#include <linux/linkage.h>
 #include <linux/errno.h>
 
+#include <asm/unistd.h>
+
 /*
  * Non-implemented system calls get redirected here.
  */
_

