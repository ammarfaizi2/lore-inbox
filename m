Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbVCaRRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbVCaRRe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 12:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbVCaRRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 12:17:34 -0500
Received: from sarvega.com ([161.58.151.164]:61712 "EHLO sarvega.com")
	by vger.kernel.org with ESMTP id S261573AbVCaRRX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 12:17:23 -0500
Date: Thu, 31 Mar 2005 11:10:44 -0600
From: John Lash <jkl@sarvega.com>
To: Tejun Heo <htejun@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       mage@adamant.ua
Subject: Re: sata_sil Mod15Write quirk workaround patch for vanilla kernel
 avaialble.
Message-ID: <20050331111044.4a3672cd@homer.sarvega.com>
In-Reply-To: <424C10C3.9080102@gmail.com>
References: <424C10C3.9080102@gmail.com>
X-Mailer: Sylpheed-Claws 1.0.0cvs28 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Apr 2005 00:01:23 +0900
Tejun Heo <htejun@gmail.com> wrote:

> 
>  Hello, guys.
> 
>  I  generated m16w workaround patch for 2.6.11.6 (by just removing two
> lines :-) and set up a page regarding m15w quirk and the workaournd.
> I'm planning on updating m15w patch against the vanilla tree until it
> gets into the mainline so that impatient users can try out and it gets
> more testing.
> 
>  http://home-tj.org/m15w
> 
>  Thanks.
> 
> -- 
> tejun
> 

Tejun,

I applied the patch to a clean 2.6.11.6 kernel and got an unresolved
symbol error for "ATA_TFLAG_LBA". I tried changing that to "ATA_TFLAG_LBA48" and
it compiles and runs.

So far, no problems. Thanks a lot for the patch.

--john

diff -ru format
-----

linux-2.6.11.6-sata_sil/drivers/scsi/sata_sil.c ---
linux-2.6.11.6/drivers/scsi/sata_sil.c      2005-03-31 10:58:59.000000000 -0600
+++ linux-2.6.11.6-sata_sil/drivers/scsi/sata_sil.c     2005-03-31
11:05:00.000000000 -0600 @@ -280,7 +280,7 @@ {
        u64 block = 0;
 
-       BUG_ON(!(tf->flags & ATA_TFLAG_LBA));
+       BUG_ON(!(tf->flags & ATA_TFLAG_LBA48));
 
        block |= (u64)tf->lbal;
        block |= (u64)tf->lbam << 8;
@@ -299,7 +299,7 @@
 static inline void sil_m15w_rewrite_tf (struct ata_taskfile *tf,
                                        u64 block, u16 nsect)
 {
-       BUG_ON(!(tf->flags & ATA_TFLAG_LBA));
+       BUG_ON(!(tf->flags & ATA_TFLAG_LBA48));
 
        tf->nsect = nsect & 0xff;
        tf->lbal = block & 0xff;




