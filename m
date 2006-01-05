Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWAEXCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWAEXCy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWAEXCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:02:54 -0500
Received: from xproxy.gmail.com ([66.249.82.201]:22139 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932188AbWAEXCx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:02:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=pS8Rea6Di0JN0w4x2RUWx53buhWes7XojKM5qKmrQVmVuzmopYjlL399nhT7Epy803gFBIxq+ZCCuPY9NkL3WqsTnJGJVX9P6dW5WjSUlbXlNW6URuZnVpP4cWokDV/QGRvpNXbr3eU24J8NQDxLeZHXHDOh/gMV4IlTEjWPnTY=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Fix compile warning about mark_rodata_ro in 2.6.15-mm1  (was: Re: 2.6.15-mm1)
Date: Fri, 6 Jan 2006 00:02:49 +0100
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Jesper Juhl <jesper.juhl@gmail.com>
References: <20060105062249.4bc94697.akpm@osdl.org>
In-Reply-To: <20060105062249.4bc94697.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200601060002.49569.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 January 2006 15:22, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15/2.6.15-mm1/
> 
I hit a small compile warning with 2.6.15-mm1 : 

 init/main.c: In function `init':
 init/main.c:714: warning: implicit declaration of function `mark_rodata_ro'

Here's a patch.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

--- linux-2.6.15-mm1-orig/init/main.c	2006-01-05 18:15:43.000000000 +0100
+++ linux-2.6.15-mm1/init/main.c	2006-01-05 23:57:12.000000000 +0100
@@ -53,6 +53,7 @@
 #include <asm/bugs.h>
 #include <asm/setup.h>
 #include <asm/sections.h>
+#include <asm/cacheflush.h>
 
 /*
  * This is one of the first .c files built. Error out early

