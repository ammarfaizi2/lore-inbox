Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbVBBU2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbVBBU2v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 15:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbVBBUY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 15:24:57 -0500
Received: from linux.us.dell.com ([143.166.224.162]:38883 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S262586AbVBBUU4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 15:20:56 -0500
Date: Wed, 2 Feb 2005 14:19:14 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Vasily Averin <vvs@sw.ru>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrey Melnikov <temnota+kernel@kmv.ru>, linux-kernel@vger.kernel.org,
       Atul Mukker <Atul.Mukker@lsil.com>,
       Sreenivas Bagalkote <Sreenivas.Bagalkote@lsil.com>
Subject: Re: [PATCH] Prevent NMI oopser
Message-ID: <20050202201914.GC18763@lists.us.dell.com>
References: <41F5FC96.2010103@sw.ru> <20050131231752.GA17126@logos.cnet> <42011EFA.10109@sw.ru> <20050202190626.GB18763@lists.us.dell.com> <42012ACC.4090806@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42012ACC.4090806@sw.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 10:32:28PM +0300, Vasily Averin wrote:
> >As a hack, one could #define inline /*nothing*/ in megaraid2.h to
> >avoid this, but it would be nice if the functions could all get
> >reordered such that inlining works properly, and the need for function
> >declarations in megaraid2.h would disappear completely.
> 
> 
> Could you fix it by additional patch? Or you going to prepare a new one?

Here's the hack patch (will apply after yours).

Signed-off-by: Matt Domsch <Matt_Domsch@dell.com>

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

===== drivers/scsi/megaraid2.h 1.6 vs edited =====
--- 1.6/drivers/scsi/megaraid2.h	2005-02-02 13:48:22 -06:00
+++ edited/drivers/scsi/megaraid2.h	2005-02-02 13:55:42 -06:00
@@ -5,6 +5,18 @@
 #include <linux/spinlock.h>
 
 
+/* This is an ugly hack, but gets around the fact that earlier
+ * versions of gcc ignores the inline specification when
+ * the function definition comes after function use (thereby
+ * not inlining the code), and newer gcc fails to compile the
+ * code.  This should be removed once the functions are properly
+ * ordered in megaraid2.c, and the function declarations removed
+ * in megaraid2.h.
+ */
+#undef inline
+#define inline /*nothing*/
+
+
 #define MEGARAID_VERSION	\
 	"v2.10.8.2 (Release Date: Mon Jul 26 12:15:51 EDT 2004)\n"
 
