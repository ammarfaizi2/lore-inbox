Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263139AbUCMRfp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 12:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263140AbUCMRfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 12:35:45 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:61156 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263139AbUCMRev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 12:34:51 -0500
Date: Sat, 13 Mar 2004 18:34:44 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: neilb@cse.unsw.edu.au
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net, davem@redhat.com,
       sparclinux@vger.kernel.org, ak@suse.de, discuss@x86-64.org,
       gniibe@m17n.org, kkojima@rr.iij4u.or.jp, linux-sh@m17n.org
Subject: modular nfsd requires kernel changes on sh, sparc64, x86_64
Message-ID: <20040313173444.GX14833@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling and inserting a module into the currently running kernel 
should work without needing a reboot.

For nfsd this seems to work everywhere except on the sh, sparc64 
and x86_64 architectures where adding the nfsd module changes 
non-modular kernel code (checked in 2.6.4-mm1):


arch/sh/kernel/entry.S:

<--  snip  -->

...
#if !defined(CONFIG_NFSD) && !defined(CONFIG_NFSD_MODULE)
#define sys_nfsservctl          sys_ni_syscall
#endif
...

<--  snip  -->


arch/x86_64/ia32/sys_ia32.c:

<--  snip  -->

...
#if defined(CONFIG_NFSD) || defined(CONFIG_NFSD_MODULE)
/* Stuff for NFS server syscalls... */
struct nfsctl_svc32 {
        u16                     svc32_port;
        s32                     svc32_nthreads;
};

struct nfsctl_client32 {
...

<--  snip  -->


arch/sparc64/kernel/sys_sparc32.c:

<--   snip  -->

...
#if defined(CONFIG_NFSD) || defined(CONFIG_NFSD_MODULE)
/* Stuff for NFS server syscalls... */
struct nfsctl_svc32 {
        u16                     svc32_port;
        s32                     svc32_nthreads;
};

struct nfsctl_client32 {
...

<--  snip  -->





cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

