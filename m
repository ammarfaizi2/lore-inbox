Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbTLWQek (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 11:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbTLWQek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 11:34:40 -0500
Received: from mail2-116.ewetel.de ([212.6.122.116]:47346 "EHLO
	mail2.ewetel.de") by vger.kernel.org with ESMTP id S261953AbTLWQei
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 11:34:38 -0500
Date: Tue, 23 Dec 2003 17:34:28 +0100 (CET)
From: Pascal Schmidt <der.eremit@email.de>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-mm1
Message-ID: <Pine.LNX.4.44.0312231732001.926-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 23 Dec 2003 06:20:14 +0100, you wrote in linux.kernel:

>> +atapi-mo-support.patch
>> 
>>  Fix support for ATAPI MO drives (needs updating to reflect the changes 
>>  in mt-ranier-support.patch).
> Since the atapi-mo patch is mine, is there something I need to do?

I figured it out. ;) This small additional patch on top of mm1 is
needed to get MO write support to work.


--- linux-2.6.0-mm1/drivers/cdrom/cdrom.c	Tue Dec 23 17:26:27 2003
+++ linux-2.6.0-mm1-mo/drivers/cdrom/cdrom.c	Tue Dec 23 17:11:50 2003
@@ -708,6 +708,8 @@ static int cdrom_open_write(struct cdrom
 		ret = cdrom_mrw_open_write(cdi);
 	else if (CDROM_CAN(CDC_DVD_RAM))
 		ret = cdrom_dvdram_open_write(cdi);
+	else if (CDROM_CAN(CDC_MO_DRIVE))
+		ret = 0;
 
 	return ret;
 }


-- 
Ciao,
Pascal

