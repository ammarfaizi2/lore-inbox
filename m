Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262973AbVHEPwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262973AbVHEPwB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 11:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263054AbVHEPDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 11:03:12 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:29390 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262481AbVHEPBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 11:01:46 -0400
Subject: Re: [Bugme-new] [Bug 5003] New: Problem with symbios driver on
	recent	-mm trees
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       bugme-daemon@kernel-bugs.osdl.org
In-Reply-To: <179280000.1123252564@[10.10.2.4]>
References: <135040000.1123216397@[10.10.2.4]>
	 <20050804233927.2d3abb16.akpm@osdl.org> <1123251892.5003.6.camel@mulgrave>
	 <179280000.1123252564@[10.10.2.4]>
Content-Type: text/plain
Date: Fri, 05 Aug 2005 10:01:26 -0500
Message-Id: <1123254086.5003.10.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-05 at 07:36 -0700, Martin J. Bligh wrote:
> Howcome it works on all mainline kernels, and not -mm then? ;-)
> Did we fix an error path to detect failures, maybe?

Well, OK, it might be something to do with your drives trying to
negotiate IU and QAS.  Support for this was added to the sym2 driver but
never verified (because no-one seemed to have drives that could do it).

The attached should stop the driver from negotiating these two
parameters, if you could try it (it will produce complaints about static
functions defined but not used, but you can ignore them).

James

diff --git a/drivers/scsi/sym53c8xx_2/sym_glue.c b/drivers/scsi/sym53c8xx_2/sym_glue.c
--- a/drivers/scsi/sym53c8xx_2/sym_glue.c
+++ b/drivers/scsi/sym53c8xx_2/sym_glue.c
@@ -2122,10 +2122,12 @@ static struct spi_function_template sym2
 	.show_width	= 1,
 	.set_dt		= sym2_set_dt,
 	.show_dt	= 1,
+#if 0
 	.set_iu		= sym2_set_iu,
 	.show_iu	= 1,
 	.set_qas	= sym2_set_qas,
 	.show_qas	= 1,
+#endif
 	.get_signalling	= sym2_get_signalling,
 };
 


