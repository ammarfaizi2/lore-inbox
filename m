Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263338AbTEOBZR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 21:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263441AbTEOBZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 21:25:17 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:30403 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263338AbTEOBZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 21:25:15 -0400
Date: Wed, 14 May 2003 18:39:25 -0700
From: Andrew Morton <akpm@digeo.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: ch@murgatroid.com, inaky.perez-gonzalez@intel.com, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.68 FUTEX support should be optional
Message-Id: <20030514183925.67a538fc.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0305141827200.28093-100000@home.transmeta.com>
References: <20030514182526.36823e2b.akpm@digeo.com>
	<Pine.LNX.4.44.0305141827200.28093-100000@home.transmeta.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 May 2003 01:37:59.0227 (UTC) FILETIME=[9DD098B0:01C31A82]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> wrote:
>
> Yes. We can make tit a CONFIG option, and then force it to always be "y" 
>  in the .config file. And then the people who really know and really care 
>  can turn the "y" to a "n".


I did it the below way.  Or are you suggesting that a manual edit of
.config should be required?   It may not get tested at all that way?



--- 25/init/Kconfig~CONFIG_FUTEX	Wed May 14 12:43:16 2003
+++ 25-akpm/init/Kconfig	Wed May 14 13:06:15 2003
@@ -108,8 +108,17 @@ config LOG_BUF_SHIFT
 		     13 =>  8 KB
 		     12 =>  4 KB
 
+menu "Size reduced kernel"
+
+config FUTEX
+	bool "Futex support"
+	default y
+	---help---
+	Say Y if you want support for Fast Userspace Mutexes (Futexes).
+	WARNING: disabling futex support will probably cause glibc to fail.
 endmenu
 
+endmenu
 
 menu "Loadable module support"
 


