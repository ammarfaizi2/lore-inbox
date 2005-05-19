Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVESSRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVESSRP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 14:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVESSRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 14:17:15 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:62687 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261202AbVESSQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 14:16:22 -0400
Date: Thu, 19 May 2005 11:16:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.12-rc4] Add EXPORT_SYMBOL for hotplug_path
Message-ID: <20050519181620.GL3771@smtp.west.cox.net>
References: <20050519164323.GK3771@smtp.west.cox.net> <1116524429.6027.55.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116524429.6027.55.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2005 at 07:40:29PM +0200, Arjan van de Ven wrote:
> On Thu, 2005-05-19 at 09:43 -0700, Tom Rini wrote:
> > If CONFIG_INPUT is set as a module, it will not load as hotplug_path is
> > not a defined symbol.  Trivial fix is to EXPORT_SYMBOL hotplug_path.
> 
> shouldn't this be a _GPL export since it's quite internal to linux...

Doesn't matter to me.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

Index: lib/kobject_uevent.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/lib/kobject_uevent.c  (mode:100644)
+++ uncommitted/lib/kobject_uevent.c  (mode:100644)
@@ -21,6 +21,7 @@
 #include <linux/string.h>
 #include <linux/kobject_uevent.h>
 #include <linux/kobject.h>
+#include <linux/module.h>
 #include <net/sock.h>
 
 #define BUFFER_SIZE	1024	/* buffer for the hotplug env */
@@ -178,6 +179,7 @@
 
 #ifdef CONFIG_HOTPLUG
 char hotplug_path[HOTPLUG_PATH_LEN] = "/sbin/hotplug";
+EXPORT_SYMBOL_GPL(hotplug_path);
 u64 hotplug_seqnum;
 static DEFINE_SPINLOCK(sequence_lock);
 

-- 
Tom Rini
http://gate.crashing.org/~trini/
