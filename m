Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137044AbREKEx6>; Fri, 11 May 2001 00:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137045AbREKExs>; Fri, 11 May 2001 00:53:48 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:58722 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S137044AbREKExm>; Fri, 11 May 2001 00:53:42 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Moses McKnight <m_mcknight@surfbest.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.4-ac6 compile error in plip.c 
In-Reply-To: Your message of "Thu, 10 May 2001 08:46:43 EST."
             <3AFA9BC3.1060207@surfbest.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 11 May 2001 14:53:09 +1000
Message-ID: <2514.989556789@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 May 2001 08:46:43 -0500, 
Moses McKnight <m_mcknight@surfbest.net> wrote:
>Hi, I get the following error trying to compile 2.4.4-ac6 using gcc 
>2.95.4 (debian package).
>
>plip.c:1412: __setup_str_plip_setup causes a section type conflict

The first __initdata is marked as const, the second is not, a section
cannot contain both const and non-const data.  Against 2.4.4-ac6.

Index: 4.16/drivers/net/plip.c
--- 4.16/drivers/net/plip.c Thu, 26 Apr 2001 12:38:49 +1000 kaos (linux-2.4/l/c/23_plip.c 1.2.1.3 644)
+++ 4.16(w)/drivers/net/plip.c Fri, 11 May 2001 14:50:39 +1000 kaos (linux-2.4/l/c/23_plip.c 1.2.1.3 644)
@@ -120,7 +120,7 @@
 
 #include <linux/parport.h>
 
-static const char version[] __initdata =
+static char version[] __initdata =
 	KERN_INFO "NET3 PLIP version 2.4-parport gniibe@mri.co.jp\n";
 
 /* Maximum number of devices to support. */

