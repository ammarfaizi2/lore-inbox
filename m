Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbTKZSUO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 13:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264265AbTKZSUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 13:20:14 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:59266
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S264231AbTKZSUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 13:20:10 -0500
Date: Wed, 26 Nov 2003 13:18:48 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Vince <fuzzy77@free.fr>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [kernel panic @ reboot] 2.6.0-test10-mm1
In-Reply-To: <3FC4E8C8.4070902@free.fr>
Message-ID: <Pine.LNX.4.58.0311261305020.1683@montezuma.fsmlabs.com>
References: <3FC4DA17.4000608@free.fr> <Pine.LNX.4.58.0311261213510.1683@montezuma.fsmlabs.com>
 <3FC4E42A.40906@free.fr> <Pine.LNX.4.58.0311261240210.1683@montezuma.fsmlabs.com>
 <3FC4E8C8.4070902@free.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Nov 2003, Vince wrote:

> > *groan* do you have a PDA?
> >
>
> Nope. I could probably borrow a laptop to a friend but am not excited at
> the idea of having to setup some serial console thing (I do not even
> have a serial cable). Dump to floppy/swap/disk would be much easier in
> my case... if it could me made to work, of course ;-)

Those oopses looked rather spurious, i'm not sure what help those other
methods would be here. Try applying the following patch and be sure to
have access to the console. You may have to hand transcribe...

Index: linux-2.6.0-test10-mm1-bochs/arch/i386/kernel/traps.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test10-mm1/arch/i386/kernel/traps.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 traps.c
--- linux-2.6.0-test10-mm1-bochs/arch/i386/kernel/traps.c	26 Nov 2003 05:28:50 -0000	1.1.1.1
+++ linux-2.6.0-test10-mm1-bochs/arch/i386/kernel/traps.c	26 Nov 2003 18:17:37 -0000
@@ -329,6 +329,10 @@ void die(const char * str, struct pt_reg
 	if (in_interrupt())
 		panic("Fatal exception in interrupt");

+	local_irq_disable();
+	while (1)
+		__asm__ __volatile__("hlt");
+
 	if (panic_on_oops) {
 		printk(KERN_EMERG "Fatal exception: panic in 5 seconds\n");
 		set_current_state(TASK_UNINTERRUPTIBLE);
