Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263420AbTKATPP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 14:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263430AbTKATPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 14:15:15 -0500
Received: from ns.suse.de ([195.135.220.2]:28807 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263420AbTKATPL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 14:15:11 -0500
Date: Sat, 1 Nov 2003 20:14:46 +0100
From: Andi Kleen <ak@suse.de>
To: <matze@camline.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Oops in __is_prefetch with 2.6.0-test9-bk4 at boot
 time with Athlon XP 1800+
Message-Id: <20031101201446.513ce9b6.ak@suse.de>
In-Reply-To: <Pine.LNX.4.33.0311010655490.29382-200000@homer2.camline.com>
References: <Pine.LNX.4.33.0311010655490.29382-200000@homer2.camline.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Nov 2003 07:01:38 +0100 (MET)
<matze@camline.com> wrote:

> Andi, it seems that you are the right person for this. It looks like my athlon
> dies in the __get_user call in __is_prefetch at boot up when bash is used as
> init process (look in [2.] for more details).
> 
> Just ask for any additional information.

Does it go away when you apply the following patch?

I need your config, but the complete config (without the comments dropped) 
and without the attachment converted to CR-LF line endings. I just spent several minutes
debugging the extremly cryptic error message from Kconfig you get for that.

Most likely something is reordering the exception table, breaking __get_user.

-Andi

diff -u linux-test9bk4/include/linux/init.h-o linux-test9bk4/include/linux/init.h
--- linux-test9bk4/include/linux/init.h-o	2003-09-28 10:53:23.000000000 +0200
+++ linux-test9bk4/include/linux/init.h	2003-11-01 22:10:21.000000000 +0100
@@ -40,15 +40,15 @@
 
 /* These are for everybody (although not all archs will actually
    discard it in modules) */
-#define __init		__attribute__ ((__section__ (".init.text")))
+#define __init		
 #define __initdata	__attribute__ ((__section__ (".init.data")))
 #define __exitdata	__attribute__ ((__section__(".exit.data")))
-#define __exit_call	__attribute_used__ __attribute__ ((__section__ (".exitcall.exit")))
+#define __exit_call	
 
 #ifdef MODULE
 #define __exit		__attribute__ ((__section__(".exit.text")))
 #else
-#define __exit		__attribute_used__ __attribute__ ((__section__(".exit.text")))
+#define __exit		
 #endif
 
 /* For assembly routines */


