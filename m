Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269719AbUJMOTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269719AbUJMOTQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 10:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269724AbUJMOTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 10:19:16 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:26889 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S269719AbUJMOTI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 10:19:08 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [2.6 patch] fix block/cciss.c with PROC_FS=n
Date: Wed, 13 Oct 2004 09:18:59 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF107DBFEC5@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6 patch] fix block/cciss.c with PROC_FS=n
Thread-Index: AcSwnFFUD2JsAg4YQxiYc8HHA4jhTAAjc7CA
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: "Adrian Bunk" <bunk@stusta.de>, "Andrew Morton" <akpm@osdl.org>,
       "Linus Torvalds" <torvalds@osdl.org>
Cc: "ISS StorageDev" <iss_storagedev@hp.com>,
       <Cciss-discuss@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 13 Oct 2004 14:19:01.0517 (UTC) FILETIME=[9639DBD0:01C4B12F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Adrian Bunk [mailto:bunk@stusta.de]
> 
> I got the following compile error in both 2.6.9-rc4 and 2.6.9-rc4-mm1 
> when compiling with CONFIG_PROC_FS=n:
> 
> 
> <--  snip  -->
> 
> ...
>   LD      .tmp_vmlinux1
> kernel/built-in.o(.text+0x1d42b): In function 
> `crash_create_proc_entry':
> : undefined reference to `proc_vmcore'
> drivers/built-in.o(.text+0x234eb8): In function `cciss_init_one':
> : undefined reference to `cciss_scsi_setup'
> drivers/built-in.o(.text+0x235173): In function `cciss_remove_one':
> : undefined reference to `cciss_unregister_scsi'
> make: *** [.tmp_vmlinux1] Error 1
> 
> <--  snip  -->
> 
> 
> The patch below fixes this issue.
> 
> 
> I don't know whether this might qualify it for 2.6.9:
> - it fixes the only CONFIG_PROC_FS=n compile error I found in 
> 2.6.9-rc4
> - it has obviously no effect in the CONFIG_PROC_FS=y case
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.9-rc4-mm1-full/drivers/block/cciss.c.old	
> 2004-10-12 20:36:33.000000000 +0200
> +++ linux-2.6.9-rc4-mm1-full/drivers/block/cciss.c	
> 2004-10-12 20:37:16.000000000 +0200
> @@ -185,10 +185,11 @@
>          }
>          return c;
>  }
> -#ifdef CONFIG_PROC_FS
>  
>  #include "cciss_scsi.c"		/* For SCSI tape support */
>  
> +#ifdef CONFIG_PROC_FS
> +
>  /*
>   * Report information about this controller.
>   */

This looks OK.

mikem

> 
