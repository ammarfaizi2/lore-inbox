Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLEX5J>; Tue, 5 Dec 2000 18:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129210AbQLEX5A>; Tue, 5 Dec 2000 18:57:00 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:15366 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130399AbQLEX4X>; Tue, 5 Dec 2000 18:56:23 -0500
Date: Tue, 5 Dec 2000 17:25:38 -0600
To: mkloppstech@freenet.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: test12-pre5 does not compile
Message-ID: <20001205172538.I6567@cadcamlab.org>
In-Reply-To: <200012052311.AAA06477@john.epistle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200012052311.AAA06477@john.epistle>; from mkloppstech@freenet.de on Wed, Dec 06, 2000 at 12:11:23AM +0100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[mkloppstech@freenet.de]
> dummy.c: In function `dummy_init_module':
> dummy.c:103: invalid type argument of `->'

Known bug.  They say the fix is in Linus's patch queue.

--- include/linux/module.h~	Tue Dec  5 00:53:23 2000
+++ include/linux/module.h	Tue Dec  5 17:24:47 2000
@@ -345,7 +345,7 @@
 #endif /* MODULE */
 
 #ifdef CONFIG_MODULES
-#define SET_MODULE_OWNER(some_struct) do { some_struct->owner = THIS_MODULE; } while (0)
+#define SET_MODULE_OWNER(some_struct) do { (some_struct)->owner = THIS_MODULE; } while (0)
 #else
 #define SET_MODULE_OWNER(some_struct) do { } while (0)
 #endif
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
