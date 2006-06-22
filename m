Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161236AbWFVTqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161236AbWFVTqU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 15:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161239AbWFVTqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 15:46:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13218 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161236AbWFVTqS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 15:46:18 -0400
Date: Thu, 22 Jun 2006 15:46:15 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: jejb@steeleye.com
Subject: kmalloc argument switcheroo in recent 53c700 change.
Message-ID: <20060622194615.GA15895@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	jejb@steeleye.com
References: <200606211900.k5LJ0Yqq028827@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606211900.k5LJ0Yqq028827@hera.kernel.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 07:00:34PM +0000, Linux Kernel wrote:
 > commit 67d59dfdeb21df2c16dcd478b66177e91178ecd0
 > tree ae85703651d81740f4a6cd398f9dd4d6aabe6a2f
 > parent 6db874fbdbedba5e15e76cc03b42f52ea70338c0
 > author James Bottomley <James.Bottomley@steeleye.com> Wed, 14 Jun 2006 07:31:19 -0500
 > committer James Bottomley <jejb@mulgrave.il.steeleye.com> Tue, 20 Jun 2006 05:34:01 -0500
 > 
 > [SCSI] 53c700: remove reliance on deprecated cmnd fields
 >  ...
 >  
 > +	SDp->hostdata = kmalloc(GFP_KERNEL, sizeof(struct NCR_700_sense));
 > +
 > +	if (!SDp->hostdata)
 > +		return -ENOMEM;

"I'll take reversed arguments for $100 please Alex".

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6/drivers/scsi/53c700.c~	2006-06-22 15:43:42.000000000 -0400
+++ linux-2.6/drivers/scsi/53c700.c	2006-06-22 15:44:14.000000000 -0400
@@ -2044,7 +2044,7 @@ NCR_700_slave_configure(struct scsi_devi
 	struct NCR_700_Host_Parameters *hostdata = 
 		(struct NCR_700_Host_Parameters *)SDp->host->hostdata[0];
 
-	SDp->hostdata = kmalloc(GFP_KERNEL, sizeof(struct NCR_700_sense));
+	SDp->hostdata = kmalloc(sizeof(struct NCR_700_sense), GFP_KERNEL);
 
 	if (!SDp->hostdata)
 		return -ENOMEM;

-- 
http://www.codemonkey.org.uk
