Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263251AbTDGFEA (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 01:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263259AbTDGFEA (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 01:04:00 -0400
Received: from rj.SGI.COM ([192.82.208.96]:31955 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S263251AbTDGFD7 (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 01:03:59 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: correct to set -nostdinc and then include <stdarg.h> ? 
In-reply-to: Your message of "Mon, 07 Apr 2003 00:41:22 -0400."
             <3E910172.8030406@nortelnetworks.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 07 Apr 2003 15:15:12 +1000
Message-ID: <23076.1049692512@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Apr 2003 00:41:22 -0400, 
Chris Friesen <cfriesen@nortelnetworks.com> wrote:
>
>I was trying to compile 2.5.66 with gcc 3.2.2.  It dies as soon as it tries to 
>compile init/main.c because it is unable to find "stdarg.h" which is included by 
>"include/linux/kernel.h".

Try this:

Index: 66.1/Makefile
--- 66.1/Makefile Tue, 25 Mar 2003 11:23:27 +1100 kaos (linux-2.5/I/d/12_Makefile 1.45.1.4.1.59 444)
+++ 66.1(w)/Makefile Mon, 07 Apr 2003 15:13:54 +1000 kaos (linux-2.5/I/d/12_Makefile 1.45.1.4.1.59 444)
@@ -177,7 +177,7 @@ LDFLAGS_MODULE  = -r
 CFLAGS_KERNEL	=
 AFLAGS_KERNEL	=
 
-NOSTDINC_FLAGS  = -nostdinc -iwithprefix include
+NOSTDINC_FLAGS  = -nostdinc $(shell LANG=C $(CC) -print-search-dirs | sed -ne 's/install: \(.*\)/-I \1include/gp')
 
 CPPFLAGS	:= -D__KERNEL__ -Iinclude
 CFLAGS 		:= $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \

