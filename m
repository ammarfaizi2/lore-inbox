Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292835AbSBZVuD>; Tue, 26 Feb 2002 16:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293070AbSBZVtx>; Tue, 26 Feb 2002 16:49:53 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:27558 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S292835AbSBZVtq>; Tue, 26 Feb 2002 16:49:46 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: jt@hpl.hp.com
Date: Wed, 27 Feb 2002 08:50:11 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15484.787.973914.508508@notabene.cse.unsw.edu.au>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.5 ERROR] Can't compile without NFS
In-Reply-To: message from Jean Tourrilhes on Tuesday February 26
In-Reply-To: <20020226120459.A17913@bougret.hpl.hp.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday February 26, jt@bougret.hpl.hp.com wrote:
> make[2]: Entering directory `/usr/src/kernel-source-2.5/fs'
> gcc -D__KERNEL__ -I/usr/src/kernel-source-2.5/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686   -DKBUILD_BASENAME=filesystems  -DEXPORT_SYMTAB -c filesystems.c
> filesystems.c: In function `sys_nfsservctl':
> filesystems.c:30: dereferencing pointer to incomplete type
> filesystems.c:30: dereferencing pointer to incomplete type
> filesystems.c:30: warning: value computed is not used
....

Yeh... sorry 'bout that.

Patch sent to Linus, but didn't make it into 2.5.6-pre1.



--- ./include/linux/nfsd/interface.h	2002/02/20 21:58:11	1.1
+++ ./include/linux/nfsd/interface.h	2002/02/20 23:35:19	1.2
@@ -12,13 +12,15 @@
 
 #include <linux/config.h>
 
-#ifdef CONFIG_NFSD_MODULE
+#ifndef CONFIG_NFSD
+#ifdef CONFIG_MODULES
 
 extern struct nfsd_linkage {
 	long (*do_nfsservctl)(int cmd, void *argp, void *resp);
 	struct module *owner;
 } * nfsd_linkage;
 
+#endif
 #endif
 
 #endif /* LINUX_NFSD_INTERFACE_H */
