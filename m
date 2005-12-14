Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965102AbVLNXlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965102AbVLNXlo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 18:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965103AbVLNXln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 18:41:43 -0500
Received: from rtr.ca ([64.26.128.89]:62417 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S965102AbVLNXll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 18:41:41 -0500
Message-ID: <43A0ADB0.1060205@rtr.ca>
Date: Wed, 14 Dec 2005 18:41:36 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Brad Barnett <bahb@l8r.net>
Cc: Erik Meitner <e.spambo1.meitner@willystreet.coop>,
       linux-kernel@vger.kernel.org
Subject: Re: Megaraid abort errors
References: <dnq3qj$hu5$1@sea.gmane.org> <20051214183113.309ac575@be.back.l8r.net>
In-Reply-To: <20051214183113.309ac575@be.back.l8r.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, there's this bug (patch below) in the megaraid driver,
but it only affects certain architectures.

* * *

The SCSI megaraid drive goes to great effort to kmap
the scatterlist buffer (if used), but then uses the
wrong pointer when copying to it afterward.

Signed-off-by:  Mark Lord <lkml@rtr.ca>



--- linux-2.6.15-rc5/drivers/scsi/megaraid.c.orig	2005-12-04 00:10:42.000000000 -0500
+++ linux/drivers/scsi/megaraid.c	2005-12-07 17:41:30.000000000 -0500
@@ -664,7 +664,7 @@
  					sg->offset;
  			} else
  				buf = cmd->request_buffer;
-			memset(cmd->request_buffer, 0, cmd->cmnd[4]);
+			memset(buf, 0, cmd->cmnd[4]);
  			if (cmd->use_sg) {
  				struct scatterlist *sg;

