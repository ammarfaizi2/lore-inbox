Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbTE2Pgc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 11:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbTE2Pgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 11:36:32 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:10210 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP id S262303AbTE2Pgb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 11:36:31 -0400
Date: Thu, 29 May 2003 08:49:48 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: ismail donmez <voidcartman@yahoo.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>,
       GNU C Library <libc-alpha@sources.redhat.com>
Subject: Re: Recent binutils releases and linux kernel 2.5.69+
Message-ID: <20030529084948.A30796@lucon.org>
References: <20030529074448.A29931@lucon.org> <20030529150446.99966.qmail@web41011.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030529150446.99966.qmail@web41011.mail.yahoo.com>; from voidcartman@yahoo.com on Thu, May 29, 2003 at 08:04:46AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a kernel issue and should be fixed in kernel unless we want
to do something in <sys/sysctl.h>.


H.J.
---
--- include/linux/sysctl.h.user	2003-05-29 07:36:51.000000000 -0700
+++ include/linux/sysctl.h	2003-05-29 08:47:21.000000000 -0700
@@ -28,6 +28,11 @@
 #include <linux/types.h>
 #include <linux/list.h>
 
+#ifdefine __KERNEL__
+#undef __user
+#define __user
+#endif
+
 struct file;
 
 #define CTL_MAXNAME 10		/* how many path components do we allow in a
On Thu, May 29, 2003 at 08:04:46AM -0700, ismail donmez wrote:
> 
> --- "H. J. Lu" <hjl@lucon.org> wrote:
> > What is the problem? Does linux/sysctl.h include
> > linux/compiler.h?
> No it doesnt include it directly. It includes
> linux/kernel.h and linux/kernel.h does a trick like
> 
> #ifdef __KERNEL__
> .......
> #include <linux/compiler.h>
> 
> So we never get __user defined.
> 
> > Does your compiler define __CHECKER__?
> > 
> No.
> 
> Would it be too bad to a trick like
> 
> #include <linux/version.h>
> #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,70)
> #define __user
> #endif
> 
> What do you think?
> 
> Regards,
> /ismail
> 
> =====
> Microsoft Windows: made for the internet
> The Internet: made for UNIX
> 
> __________________________________
> Do you Yahoo!?
> Yahoo! Calendar - Free online calendar with sync to Outlook(TM).
> http://calendar.yahoo.com
