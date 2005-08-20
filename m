Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932786AbVHTTDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932786AbVHTTDh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 15:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932796AbVHTTDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 15:03:36 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:17931 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932793AbVHTTDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 15:03:11 -0400
Date: Sat, 20 Aug 2005 21:03:09 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [-mm patch] net/core/sysctl_net_core.c: fix PROC_FS=n compile
Message-ID: <20050820190309.GB3615@stusta.de>
References: <20050819043331.7bc1f9a9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050819043331.7bc1f9a9.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 04:33:31AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.13-rc5-mm1:
>...
>  git-net.patch
>...
>  Subsystem trees
>...

This breaks the compilation with CONFIG_PROC_FS=n:

<--  snip  -->

...
  CC      net/core/sysctl_net_core.o
net/core/sysctl_net_core.c:50: error: 'sysctl_wmem_default' undeclared here (not in a function)
net/core/sysctl_net_core.c:58: error: 'sysctl_rmem_default' undeclared here (not in a function)
make[2]: *** [net/core/sysctl_net_core.o] Error 1

<--  snip  -->


The fix is simple.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc6-mm1-full/include/net/sock.h.old	2005-08-20 15:39:23.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/net/sock.h	2005-08-20 15:39:39.000000000 +0200
@@ -1372,9 +1372,7 @@
 extern int sysctl_optmem_max;
 #endif
 
-#ifdef CONFIG_PROC_FS
 extern __u32 sysctl_wmem_default;
 extern __u32 sysctl_rmem_default;
-#endif
 
 #endif	/* _SOCK_H */

