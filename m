Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292589AbSBTXoH>; Wed, 20 Feb 2002 18:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292588AbSBTXn7>; Wed, 20 Feb 2002 18:43:59 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:46985 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S292582AbSBTXnp>; Wed, 20 Feb 2002 18:43:45 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Robert Love <rml@tech9.net>
Date: Thu, 21 Feb 2002 10:43:33 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15476.13477.917508.854100@notabene.cse.unsw.edu.au>
Cc: Miles Lane <miles@megapathdsl.net>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.5 -- filesystems.c:30: In function `sys_nfsservctl':
	dereferencing pointer to incomplete type
In-Reply-To: message from Robert Love on  February 20
In-Reply-To: <1014228802.6910.29.camel@turbulence.megapathdsl.net>
	<15476.1699.209321.808094@notabene.cse.unsw.edu.au>
	<1014238274.18361.62.camel@phantasy>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  February 20, rml@tech9.net wrote:
> On Wed, 2002-02-20 at 15:27, Neil Brown wrote:
> 
> > Opps, my mistake.
> > 
> > Please try this.
> 
> This does not apply to my include/linux/nfsd/interface.h ?
> 
> In 2.5.5, that file is 24 lines long.  The first hunk applies, but the
> second, at line 155, obviously does not.

Post in haste ... repent at leisure....

I made that patch against my current, heavily patches tree as I though
that the changes to interface.h wouldn't conflict... I was wrong.

The correct patch, which applies against 2.5.5 and compiles with out
errors for several combinationg of CONFIG_MODULES enabled or not, and
CONFIG_NFSD being Y, M, or N, is below.

NeilBrown



 ----------- Diffstat output ------------
 ./include/linux/nfsd/interface.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

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

> 
> 	Robert Love
