Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264689AbUEEVzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264689AbUEEVzj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 17:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264813AbUEEVzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 17:55:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30368 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264689AbUEEVzg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 17:55:36 -0400
Date: Wed, 5 May 2004 15:35:58 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Carson Gaspar <carson@taltos.org>
Cc: Marco Fais <marco.fais@abbeynet.it>, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at page_alloc.c:98 -- compiling with distcc
Message-ID: <20040505183558.GB1350@logos.cnet>
References: <406D3E8F.20902@abbeynet.it> <20040504010714.GA8028@logos.cnet> <765880000.1083774300@taltos.ny.ficc.gs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <765880000.1083774300@taltos.ny.ficc.gs.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2004 at 12:25:00PM -0400, Carson Gaspar wrote:
> --On Monday, May 03, 2004 22:07:14 -0300 Marcelo Tosatti 
> <marcelo.tosatti@cyclades.com> wrote:
> 
> >On Fri, Apr 02, 2004 at 12:21:03PM +0200, Marco Fais wrote:
> >>Hi!
> >>
> >>
> >>[1.] Kernel panic while using distcc
> >>
> >>[2.] I have 5-6 development linux systems that we use without problem
> >>under a normal development workload. Trying distcc for speeding up
> >>compilation, we have a fully reproducible kernel panic in a very short
> >>time (seconds after compilation start). The kernel panic happens *only*
> >>when the systems are "remotely controlled" (the distcc daemon is
> >>receiving source files from remote systems, compile and send back
> >>compiled objects). When compiling with distcc the local system doesn't
> >>show any kernel panic, while the same system used as a "remote compiler
> >>system" dies very quickly.
> >>
> >>[3.] Keywords: distcc BUG page_alloc.c
> >
> >Marco, Carson,
> >
> >Can you please try to reproduce this distcc generated oops using
> >2.4.27-pre2?
> 
> I'd love to. However 2.4.27-pre2 broke the tg3 driver. tg3.c contains 
> WARN_ON(1). Sadly, WARN_ON doesn't exist in 2.4.x, so depmod correctly 
> complains about an unresolved symbol.
> 
> I'm beginning to wonder if anyone actually builds these pre releases... I 
> mean, I know the tg3 driver is really obscure, and only used by 2 people, 
> but...

I just commited a fix to the BK tree. 

Can you please apply this.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1385  -> 1.1386 
#	include/linux/kernel.h	1.22    -> 1.23   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/05/05	m.c.p@kernel.linux-systeme.com	1.1386
# [PATCH] copy WARN_ON() definition from 2.6
# 
# --------------------------------------------
#
diff -Nru a/include/linux/kernel.h b/include/linux/kernel.h
--- a/include/linux/kernel.h	Wed May  5 15:35:31 2004
+++ b/include/linux/kernel.h	Wed May  5 15:35:31 2004
@@ -196,4 +196,11 @@
 
 #define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
 
+#define WARN_ON(condition) do { \
+	if (unlikely((condition)!=0)) { \
+		printk("Badness in %s at %s:%d\n", __FUNCTION__, __FILE__, __LINE__); \
+		dump_stack(); \
+	} \
+} while (0)
+
 #endif /* _LINUX_KERNEL_H */
