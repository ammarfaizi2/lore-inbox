Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292282AbSBTU2e>; Wed, 20 Feb 2002 15:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292283AbSBTU22>; Wed, 20 Feb 2002 15:28:28 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:17646 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S292282AbSBTU1x>; Wed, 20 Feb 2002 15:27:53 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Miles Lane <miles@megapathdsl.net>
Date: Thu, 21 Feb 2002 07:27:15 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15476.1699.209321.808094@notabene.cse.unsw.edu.au>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.5 -- filesystems.c:30: In function `sys_nfsservctl':
	dereferencing pointer to incomplete type
In-Reply-To: message from Miles Lane on  February 20
In-Reply-To: <1014228802.6910.29.camel@turbulence.megapathdsl.net>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  February 20, miles@megapathdsl.net wrote:
> This has been reported by someone else, but the .config 
> information was not included in the report.  Hopefully, 
> this will help.
> 
> Here you go:
....
> 
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=2 -march=athlon   
> -DKBUILD_BASENAME=filesystems  -DEXPORT_SYMTAB -c filesystems.c
> filesystems.c: In function `sys_nfsservctl':
> filesystems.c:30: dereferencing pointer to incomplete type
> filesystems.c:30: dereferencing pointer to incomplete type
...

Opps, my mistake.

Please try this.

NeilBrown



--- ./include/linux/nfsd/interface.h	2002/02/18 22:58:10	1.3
+++ ./include/linux/nfsd/interface.h	2002/02/20 20:25:55
@@ -138,7 +138,8 @@
 
 
 
-#ifdef CONFIG_NFSD_MODULE
+#ifndef CONFIG_NFSD
+#ifdef CONFIG_MODULE
 
 extern struct nfsd_linkage {
 	long (*do_nfsservctl)(int cmd, void *argp, void *resp);
@@ -155,13 +156,11 @@
 # define nfsd_find_fh_dentry (nfsd_linkage->find_fh_dentry)
 
 #else
-# ifndef CONFIG_NFSD
 #  define nfsd_find_fh_dentry(a,b,c,d,e) *((char*)0)=0
 /* filesystems can use "#ifndef NO_CONFIG_NFSD" to exclude code that is only needed
  * by knfsd
  */
 #  define NO_CONFIG_NFSD
-# endif
 #endif
 
 #endif /* LINUX_NFSD_INTERFACE_H */
