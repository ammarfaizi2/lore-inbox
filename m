Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbVKRBlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbVKRBlE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 20:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbVKRBlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 20:41:04 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:60165 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932224AbVKRBlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 20:41:03 -0500
Date: Fri, 18 Nov 2005 02:41:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, George Anzinger <george@mvista.com>
Cc: linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>
Subject: [-mm patch] kernel/signal.c: fix compile warning
Message-ID: <20051118014102.GL11494@stusta.de>
References: <20051117111807.6d4b0535.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051117111807.6d4b0535.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 11:18:07AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.14-mm2:
>...
> +sigaction-should-clear-all-signals-on-sig_ign-not-just.patch
> 
>  Signal code fix
>...


Patches get bonus points when they don't introduce new compile 
warnings...

<--  snip  -->

...
  CC      kernel/signal.o
kernel/signal.c: In function 'rm_from_queue_full':
kernel/signal.c:638: warning: control may reach end of non-void function 'sigisemptyset' being inlined
...

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-rc1-mm1-full/include/linux/signal.h.old	2005-11-18 00:47:49.000000000 +0100
+++ linux-2.6.15-rc1-mm1-full/include/linux/signal.h	2005-11-18 00:52:13.000000000 +0100
@@ -102,6 +102,7 @@
 		return set->sig[0] == 0;
 	default:
 		_NSIG_WORDS_is_unsupported_size();
+		return 0;
 	}
 }
 

