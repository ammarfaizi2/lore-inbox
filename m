Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267423AbUHJEPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267423AbUHJEPZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 00:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267422AbUHJEPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 00:15:16 -0400
Received: from ms-smtp-03-qfe0.socal.rr.com ([66.75.162.135]:53423 "EHLO
	ms-smtp-03-eri0.socal.rr.com") by vger.kernel.org with ESMTP
	id S267417AbUHJEPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 00:15:02 -0400
Date: Mon, 9 Aug 2004 13:58:39 -0700
From: Andrew Vasquez <praka@pobox.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: 2.6.8-rc3-mm2:  Debug: sleeping function called from invalid context at mm/mempool.c:197
Message-ID: <20040809205839.GA1439@praka.san.rr.com>
Mail-Followup-To: Andrew Vasquez <praka@pobox.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <B179AE41C1147041AA1121F44614F0B0DD03A6@AVEXCH02.qlogic.org> <411813F0.9020602@us.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <411813F0.9020602@us.ibm.com>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.4.21-202-athlon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, 09 Aug 2004, Janet Morgan wrote:

> Andrew Vasquez wrote:
> 
> >
> >This allocation should be done with GFP_ATOMIC flags.  The attached 
> >patch should apply cleanly to any recent kernel
> >
> > 
> >
> 
> and seems to work fine.
> 

James,


I hope this patch can make it before 2.6.8, please apply.



Thanks,
Andrew Vasquez

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mpool_alloc.diff"

===== drivers/scsi/qla2xxx/qla_os.c 1.39 vs edited =====
--- 1.39/drivers/scsi/qla2xxx/qla_os.c	2004-07-12 09:54:49 -07:00
+++ edited/drivers/scsi/qla2xxx/qla_os.c	2004-08-09 16:48:29 -07:00
@@ -3590,7 +3590,7 @@
 {
 	srb_t *sp;
 
-	sp = mempool_alloc(ha->srb_mempool, GFP_KERNEL);
+	sp = mempool_alloc(ha->srb_mempool, GFP_ATOMIC);
 	if (sp)
 		atomic_set(&sp->ref_count, 1);
 	return (sp);

--tThc/1wpZn/ma/RB--
