Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbUCQXhg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 18:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbUCQXhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 18:37:36 -0500
Received: from dp.samba.org ([66.70.73.150]:14769 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262191AbUCQXhe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 18:37:34 -0500
Date: Thu, 18 Mar 2004 10:36:57 +1100
From: Anton Blanchard <anton@samba.org>
To: Robert Love <rml@ximian.com>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Linux kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: status of PREEMPT and SMP together?
Message-ID: <20040317233657.GD28212@krispykreme>
References: <4058C37F.8070409@nortelnetworks.com> <1079560828.1435.24.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079560828.1435.24.camel@localhost>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hrm, I thought I sent Anton a patch to fix that.

Sorry, I had planned to send it once Linus got over his deep freeze mode
but forgot. Here it is.

Now that the option is selectable I marked it BROKEN for the moment
since we havent got around to doing the low level exception bits yet...
Do you have a G5 yet? :)

> The comment is out of date.  Technically speaking, the potential
> SMP+PREEMPT races exist on UP+PREEMPT, too.
> 
> Running SMP+PREEMPT on a 4-way here :-)

--

From: Robert Love <rml@ximian.com>

arch/ppc64/Kconfig's entry for CONFIG_PREEMPT is missing the description
after the "bool" statement, so the entry does not show up.

Also, the help description mentions a restriction that is not [any
longer] true.

===== arch/ppc64/Kconfig 1.50 vs edited =====
--- 1.50/arch/ppc64/Kconfig	Sun Mar  7 18:05:28 2004
+++ edited/arch/ppc64/Kconfig	Thu Mar 18 10:33:17 2004
@@ -174,14 +179,12 @@
 	depends on DISCONTIGMEM
 
 config PREEMPT
-	bool
+	bool "Preemptible Kernel"
+	depends on BROKEN
 	help
 	  This option reduces the latency of the kernel when reacting to
 	  real-time or interactive events by allowing a low priority process to
 	  be preempted even if it is in kernel mode executing a system call.
-	  Unfortunately the kernel code has some race conditions if both
-	  CONFIG_SMP and CONFIG_PREEMPT are enabled, so this option is
-	  currently disabled if you are building an SMP kernel.
 
 	  Say Y here if you are building a kernel for a desktop, embedded
 	  or real-time system.  Say N if you are unsure.
