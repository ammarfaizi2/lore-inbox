Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267696AbUIOXZB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267696AbUIOXZB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 19:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267725AbUIOXVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 19:21:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:1696 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267696AbUIOXRn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 19:17:43 -0400
Date: Wed, 15 Sep 2004 16:21:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: =?ISO-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] Oops with kernel 2.6.9-rc2
Message-Id: <20040915162126.2899b2f7.akpm@osdl.org>
In-Reply-To: <20040915160143.GA4874@ime.usp.br>
References: <20040915160143.GA4874@ime.usp.br>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogério Brito <rbrito@ime.usp.br> wrote:
>
> Yesterday night, I was running my own self compiled kernel 2.6.9-rc2,
> without any patches applied and, while I had my computer left unattended
> for some moments, I saw that it generated two Oopsen in a row.

Were you using a cdrom at that time?   If so, this will probably fix it:

--- 25/fs/isofs/rock.c~rock-fix	2004-09-10 01:47:00.135392480 -0700
+++ 25-akpm/fs/isofs/rock.c	2004-09-10 01:47:00.139391872 -0700
@@ -62,7 +62,7 @@
 }                                     
 
 #define MAYBE_CONTINUE(LABEL,DEV) \
-  {if (buffer) kfree(buffer); \
+  {if (buffer) { kfree(buffer); buffer = NULL; } \
   if (cont_extent){ \
     int block, offset, offset1; \
     struct buffer_head * pbh; \
_

