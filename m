Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264021AbTIILio (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 07:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264031AbTIILin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 07:38:43 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:58562 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264021AbTIILim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 07:38:42 -0400
Date: Tue, 9 Sep 2003 13:38:31 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.6 patch] fix nfs4xdr.c compile warning
Message-ID: <20030909113831.GN14800@fs.tum.de>
References: <Pine.LNX.4.44.0309081319380.1666-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309081319380.1666-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 01:32:05PM -0700, Linus Torvalds wrote:
>...
> Summary of changes from v2.6.0-test4 to v2.6.0-test5
> ============================================
>...
> Neil Brown:
>...
>   o fix in NFSv4 server for bad sequence id errors
>...

This produces the following compile warning:

<--  snip  -->

...
  CC      fs/nfsd/nfs4xdr.o
fs/nfsd/nfs4xdr.c: In function `nfsd4_encode_open':
fs/nfsd/nfs4xdr.c:1773: warning: `return' with a value, in function returning void
...

<--  snip  -->


The following patch tries to fix it:

--- linux-2.6.0-test5-mm1/fs/nfsd/nfs4xdr.c.old	2003-09-09 13:34:36.000000000 +0200
+++ linux-2.6.0-test5-mm1/fs/nfsd/nfs4xdr.c	2003-09-09 13:36:03.000000000 +0200
@@ -1709,7 +1709,7 @@
 }
 
 
-static void
+static int
 nfsd4_encode_open(struct nfsd4_compoundres *resp, int nfserr, struct nfsd4_open *open)
 {
 	ENCODE_HEAD;



BTW:
Shouldn't the return values of nfsd4_encode_open{,_confirm,_downgrade} 
be checked in the switch in nfsd4_encode_operation?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

