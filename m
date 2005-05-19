Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVESS36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVESS36 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 14:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVESS36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 14:29:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5277 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261164AbVESS3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 14:29:49 -0400
Date: Thu, 19 May 2005 14:29:37 -0400
From: Dave Jones <davej@redhat.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.12-rc4] Add EXPORT_SYMBOL for hotplug_path
Message-ID: <20050519182937.GB31131@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Tom Rini <trini@kernel.crashing.org>,
	Arjan van de Ven <arjan@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050519164323.GK3771@smtp.west.cox.net> <1116524429.6027.55.camel@laptopd505.fenrus.org> <20050519181620.GL3771@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050519181620.GL3771@smtp.west.cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2005 at 11:16:21AM -0700, Tom Rini wrote:
 > On Thu, May 19, 2005 at 07:40:29PM +0200, Arjan van de Ven wrote:
 > > On Thu, 2005-05-19 at 09:43 -0700, Tom Rini wrote:
 > > > If CONFIG_INPUT is set as a module, it will not load as hotplug_path is
 > > > not a defined symbol.  Trivial fix is to EXPORT_SYMBOL hotplug_path.
 > > 
 > > shouldn't this be a _GPL export since it's quite internal to linux...
 > 
 > Doesn't matter to me.
 > 
 > Signed-off-by: Tom Rini <trini@kernel.crashing.org>
 > 
 > Index: lib/kobject_uevent.c
 > ===================================================================
 > --- c7d7a187a2125518e655dfeadffd38156239ffc3/lib/kobject_uevent.c  (mode:100644)
 > +++ uncommitted/lib/kobject_uevent.c  (mode:100644)
 > @@ -21,6 +21,7 @@
 >  #include <linux/string.h>
 >  #include <linux/kobject_uevent.h>
 >  #include <linux/kobject.h>
 > +#include <linux/module.h>
 >  #include <net/sock.h>
 >  
 >  #define BUFFER_SIZE	1024	/* buffer for the hotplug env */
 > @@ -178,6 +179,7 @@
 >  
 >  #ifdef CONFIG_HOTPLUG
 >  char hotplug_path[HOTPLUG_PATH_LEN] = "/sbin/hotplug";
 > +EXPORT_SYMBOL_GPL(hotplug_path);
 >  u64 hotplug_seqnum;
 >  static DEFINE_SPINLOCK(sequence_lock);

ACK, I hit this a few days ago too, and did an identical patch
for the Fedora kernel. In addition, there was also this one..

Signed-off-by: Dave Jones <davejredhat.com>



WARNING:
/usr/src/build/566509-ppc64iseries/install/lib/modules/2.6.11-1.1311_FC4/kernel/drivers/input/input.ko
needs unknown symbol add_input_randomness

--- linux-2.6.11/drivers/char/random.c~	2005-05-14 16:42:24.000000000 -0400
+++ linux-2.6.11/drivers/char/random.c	2005-05-14 16:42:46.000000000 -0400
@@ -646,6 +646,7 @@ extern void add_input_randomness(unsigne
 	add_timer_randomness(&input_timer_state,
 			     (type << 4) ^ code ^ (code >> 4) ^ value);
 }
+EXPORT_SYMBOL_GPL(add_input_randomness);
 
 void add_interrupt_randomness(int irq)
 {



