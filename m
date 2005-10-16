Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751311AbVJPISt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbVJPISt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 04:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbVJPISt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 04:18:49 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:5334 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751311AbVJPISs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 04:18:48 -0400
Date: Sun, 16 Oct 2005 04:18:35 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.14-rc4-rt6, depmod
In-Reply-To: <1129442512.7978.3.camel@cmn3.stanford.edu>
Message-ID: <Pine.LNX.4.58.0510160417090.2328@localhost.localdomain>
References: <1129442512.7978.3.camel@cmn3.stanford.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 15 Oct 2005, Fernando Lopez-Lezcano wrote:

>
> WARNING: /lib/modules/2.6.13-0.13.rrt.rhfc4.ccrmasmp/kernel/drivers/input/gameport/gameport.ko needs unknown symbol i8253_lock
> WARNING: /lib/modules/2.6.13-0.13.rrt.rhfc4.ccrmasmp/kernel/drivers/input/joystick/analog.ko needs unknown symbol i8253_lock
>

And this patch should get this part to compile.

-- Steve

Index: linux-2.6.14-rc4-rt6/arch/i386/kernel/i8253.c
===================================================================
--- linux-2.6.14-rc4-rt6.orig/arch/i386/kernel/i8253.c	2005-10-16 04:12:44.000000000 -0400
+++ linux-2.6.14-rc4-rt6/arch/i386/kernel/i8253.c	2005-10-16 04:16:07.000000000 -0400
@@ -14,6 +14,7 @@
 #include "io_ports.h"

 DEFINE_RAW_SPINLOCK(i8253_lock);
+EXPORT_SYMBOL(i8253_lock);

 static void init_pit_timer(int mode)
 {
