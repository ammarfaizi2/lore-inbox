Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280959AbRKORf0>; Thu, 15 Nov 2001 12:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280961AbRKORfG>; Thu, 15 Nov 2001 12:35:06 -0500
Received: from gnu.in-berlin.de ([192.109.42.4]:1802 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S280960AbRKORfE>;
	Thu, 15 Nov 2001 12:35:04 -0500
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: kiobuf / vm bug
Date: 15 Nov 2001 17:32:00 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrn9v7v0g.7hc.kraxel@bytesex.org>
In-Reply-To: <20011115175531.A7068@bytesex.org>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 1005845520 7725 127.0.0.1 (15 Nov 2001 17:32:00 GMT)
User-Agent: slrn/0.9.7.1 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr wrote:
>    Hi,
>  
>  I think I have found a kiobuf-related bug in the VM of recent linux
>  kernels.  2.4.13 is fine, 2.4.14-pre1 doesn't boot my machine,
>  2.4.14-pre2 + newer kernels are broken.

[ ... ]

ok, the patch below (suggested by Andrea) fixes it.

  Gerd

--------------------- cut here -----------------
--- 2.4.15-pre4/mm/memory.c~	Tue Nov 13 10:52:01 2001
+++ 2.4.15-pre4/mm/memory.c	Thu Nov 15 18:24:16 2001
@@ -588,7 +588,7 @@
 		if (map) {
 			if (iobuf->locked)
 				UnlockPage(map);
-			__free_page(map);
+			page_cache_release(map);
 		}
 	}
 	
