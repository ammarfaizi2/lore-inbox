Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313419AbSFEHvf>; Wed, 5 Jun 2002 03:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313421AbSFEHve>; Wed, 5 Jun 2002 03:51:34 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:24327 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S313419AbSFEHve>; Wed, 5 Jun 2002 03:51:34 -0400
Message-ID: <3CFDC3F7.30C42775@zip.com.au>
Date: Wed, 05 Jun 2002 00:55:35 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kwijibo@zianet.com
CC: Klaus Dittrich <kladit@t-online.de>, linux-kernel@vger.kernel.org
Subject: Re: xosview
In-Reply-To: <200206050607.g556721s005527@df1tlpc.local.here> <3CFDC063.3090800@zianet.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kwijibo@zianet.com wrote:
> 
> I believe it is xosview that needs to change and not
> the kernel.  Mine worked with pre8 however, my move
> to pre10 broke it.
> 

It's the gunk in /proc/stat which broke it.  Some
accidentally-included debug stuff.

--- linux-2.4.19-pre9/fs/proc/proc_misc.c	Tue May 28 17:23:37 2002
+++ linux-mnm/fs/proc/proc_misc.c	Tue Jun  4 23:25:12 2002
@@ -322,7 +322,7 @@ static int kstat_read_proc(char *page, c
 #if !defined(CONFIG_ARCH_S390)
 	for (i = 0 ; i < NR_IRQS ; i++)
 		proc_sprintf(page, &off, &len,
-			     " %u", kstat_irqs(i) + 1000000000);
+			     " %u", kstat_irqs(i));
 #endif
 
 	proc_sprintf(page, &off, &len, "\ndisk_io: ");

-
