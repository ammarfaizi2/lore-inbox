Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbTEDVgr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 17:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbTEDVgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 17:36:47 -0400
Received: from [12.47.58.20] ([12.47.58.20]:28238 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S261785AbTEDVgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 17:36:46 -0400
Date: Sun, 4 May 2003 14:50:38 -0700
From: Andrew Morton <akpm@digeo.com>
To: azarah@gentoo.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5] Update sk98lin driver
Message-Id: <20030504145038.5b0495b5.akpm@digeo.com>
In-Reply-To: <1052073847.4478.18.camel@nosferatu.lan>
References: <1052073847.4478.18.camel@nosferatu.lan>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 May 2003 21:49:08.0026 (UTC) FILETIME=[FD4019A0:01C31286]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schlemmer <azarah@gentoo.org> wrote:
>
> Hi
> 
> I have a 3Com 3c940 gigabit LOM, that is basically a
> SysKonnect chipset card.  Here are later drivers that
> do support it:
> 
>   ftp://ftp.asus.com.tw/pub/ASUS/lan/3com/3c940/041_Linux.zip
> 
> The current one in the 2.5 tree was last updated for newer
> chipsets in 2001, while the new was updated February this
> year.
> 
> Anyhow, I got the new to compile, and fixed the few irqreturn_t
> calls, and some other 2.5 changes I knew about.
> 
> Now the problem is that if I try to load it, I get this:
> 
> -----------------------------------------
> sk98lin: Unknown symbol __udivdi3
> -----------------------------------------
> 
> Meaning it linked with libgcc_s.so.  Any ideas why ?
> 

This was the fix for the in-kernel driver, so it'll presumably
fix the updated driver.


diff -puN drivers/net/sk98lin/h/skgepnm2.h~sk98-build-fix drivers/net/sk98lin/h/skgepnm2.h
--- 25/drivers/net/sk98lin/h/skgepnm2.h~sk98-build-fix	Thu Mar  6 16:18:07 2003
+++ 25-akpm/drivers/net/sk98lin/h/skgepnm2.h	Thu Mar  6 16:18:07 2003
@@ -341,7 +341,7 @@ typedef struct s_PnmiStatAddr {
 #if SK_TICKS_PER_SEC == 100
 #define SK_PNMI_HUNDREDS_SEC(t)	(t)
 #else
-#define SK_PNMI_HUNDREDS_SEC(t)	(((t) * 100) / (SK_TICKS_PER_SEC))
+#define SK_PNMI_HUNDREDS_SEC(t)	((((long)t) * 100) / (SK_TICKS_PER_SEC))
 #endif
 
 /*

_

