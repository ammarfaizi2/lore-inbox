Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316194AbSE3MC2>; Thu, 30 May 2002 08:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316342AbSE3MC1>; Thu, 30 May 2002 08:02:27 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:35345 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S316194AbSE3MCY>; Thu, 30 May 2002 08:02:24 -0400
Message-ID: <3CF61542.6000500@loewe-komp.de>
Date: Thu, 30 May 2002 14:04:18 +0200
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.19-pre8 fs/nfs/nfsroot.c - in_ntoa
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Somehow a call to in_ntoa went into the kernel.
With that you can't linke the kernel, when CONFIG_ROOT_NFS=y
is on.



fs/fs.o: In function `root_nfs_getport':
fs/fs.o(.text.init+0x10e1): undefined reference to `in_ntoa'
make: *** [vmlinux] Fehler 1



--- fs/nfs/nfsroot.c.orig       Thu May 30 13:58:30 2002
+++ fs/nfs/nfsroot.c    Thu May 30 13:59:01 2002
@@ -343,8 +343,8 @@
  {
         struct sockaddr_in sin;

-       printk(KERN_NOTICE "Looking up port of RPC %d/%d on %s\n",
-               program, version, in_ntoa(servaddr));
+       printk(KERN_NOTICE "Looking up port of RPC %d/%d on 0x%X\n",
+               program, version, servaddr);
         set_sockaddr(&sin, servaddr, 0);
         return rpc_getport_external(&sin, program, version, proto);
  }

