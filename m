Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbVFMVtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVFMVtp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 17:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbVFMVsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 17:48:09 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:18570 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261458AbVFMVrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 17:47:00 -0400
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Gregoire Favre <gregoire.favre@gmail.com>
Cc: dino@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050613213307.GA8534@gmail.com>
References: <20050530160147.GD14351@gmail.com>
	 <1117477040.4913.12.camel@mulgrave> <20050530190716.GA9239@gmail.com>
	 <1118081857.5045.49.camel@mulgrave> <20050607085710.GB9230@gmail.com>
	 <1118590709.4967.6.camel@mulgrave> <20050613145000.GA12057@gmail.com>
	 <1118674783.5079.9.camel@mulgrave> <20050613183719.GA8653@gmail.com>
	 <1118695847.5079.41.camel@mulgrave>  <20050613213307.GA8534@gmail.com>
Content-Type: text/plain
Date: Mon, 13 Jun 2005 16:46:31 -0500
Message-Id: <1118699191.5079.49.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-13 at 23:33 +0200, Gregoire Favre wrote:
> On Mon, Jun 13, 2005 at 03:50:47PM -0500, James Bottomley wrote:
> I was really sure I should work and I booted it without the console
> switch to log on my palm, so I miss the beginning of the log, I hope
> this dmesg is enough (yes, this time it booted perfectly, thank you very
> much) :-)
> 
> I wonder if the speed read for my first controller with U2 and U160
> drive are right ?

No ... unfortunately there's a precedence bug in the u160 code ...

Try the attached (on top of everything else).

Thanks,

James

diff -u b/drivers/scsi/aic7xxx/aic7xxx_osm.c b/drivers/scsi/aic7xxx/aic7xxx_osm.c
--- b/drivers/scsi/aic7xxx/aic7xxx_osm.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c
@@ -640,7 +640,7 @@
 		}
 	    
 		if ((ahc->features & AHC_ULTRA2) != 0) {
-			scsirate = (flags & CFXFER) | ultra ? 0x8 : 0;
+			scsirate = (flags & CFXFER) | (ultra ? 0x8 : 0);
 			dev_printk(KERN_ERR, &starget->dev, "ULTRA2, flags 0x%x\n", flags);
 		} else {
 			scsirate = (flags & CFXFER) << 4;


