Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264810AbUEKQKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264810AbUEKQKk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 12:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264811AbUEKQKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 12:10:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40350 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264810AbUEKQKa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 12:10:30 -0400
Message-ID: <40A0FAE9.90900@pobox.com>
Date: Tue, 11 May 2004 12:10:17 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Kurt Garloff <garloff@suse.de>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Format Unit can take many hours
References: <20040511114936.GI4828@tpkurt.garloff.de> <20040511122037.GG1906@suse.de>
In-Reply-To: <20040511122037.GG1906@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Tue, May 11 2004, Kurt Garloff wrote:
> 
>>Hi,
>>
>>the timeout for FORMAT_UNIT should be much longer; I've seen 8hrs
>>already (75Gig). I've increased the timeout from 2hrs to 12hrs.
>>
>>Regards,
>>-- 
>>Kurt Garloff  <garloff@suse.de>                            Cologne, DE 
>>SUSE LINUX AG, Nuernberg, DE                          SUSE Labs (Head)
> 
> 
>>--- linux-2.6.5.orig/drivers/scsi/scsi_ioctl.c	2004-04-04 05:38:20.000000000 +0200
>>+++ linux-2.6.5/drivers/scsi/scsi_ioctl.c	2004-05-11 08:59:12.837421215 +0200
>>@@ -26,12 +26,12 @@
>> #include "scsi_logging.h"
>> 
>> #define NORMAL_RETRIES			5
>>-#define IOCTL_NORMAL_TIMEOUT			(10 * HZ)
>>-#define FORMAT_UNIT_TIMEOUT		(2 * 60 * 60 * HZ)
>>+#define IOCTL_NORMAL_TIMEOUT		(10 * HZ)
>>+#define FORMAT_UNIT_TIMEOUT		(12 * 60 * 60 * HZ)
>> #define START_STOP_TIMEOUT		(60 * HZ)
>> #define MOVE_MEDIUM_TIMEOUT		(5 * 60 * HZ)
>> #define READ_ELEMENT_STATUS_TIMEOUT	(5 * 60 * HZ)
>>-#define READ_DEFECT_DATA_TIMEOUT	(60 * HZ )  /* ZIP-250 on parallel port takes as long! */
>>+#define READ_DEFECT_DATA_TIMEOUT	(60 * HZ)  /* ZIP-250 on parallel port takes as long! */
>> 
>> #define MAX_BUF PAGE_SIZE
> 
> 
> block/scsi_ioctl.c should likely receive similar treatment then.


This timeout is dependent on media size, I should think...

Is there any reason to think that this timeout will _not_ be continually 
patched in the future, as larger and larger sizes are used?

	Jeff



