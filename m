Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbUCGQNg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 11:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbUCGQNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 11:13:36 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10944 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262190AbUCGQNa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 11:13:30 -0500
Message-ID: <404B4A1D.80107@pobox.com>
Date: Sun, 07 Mar 2004 11:13:17 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: wrlk@riede.org
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] remove dead ATAPI multi-lun support (used for ide-scsi)
References: <200402202247.02345.bzolnier@elka.pw.edu.pl> <20040307134905.GK29509@serve.riede.org>
In-Reply-To: <20040307134905.GK29509@serve.riede.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willem Riede wrote:
> On 2004.02.20 16:47, Bartlomiej Zolnierkiewicz wrote:
> 
>>[IDE] remove dead ATAPI multi-lun support (used for ide-scsi)
>>
>>ChangeSet@1.889.69.2 03-01-23 14:51:03-05:00  adam@yggdrasil.com
>>|  The following changes to ide-scsi.c are a recovery of the
>>| changes that I had in ide-scsi.c in the stock kernel's before
>>| Martin Dalecki's IDE tree was reverted and a few other changes.
>>...
>>
>>broke it.
>>
>>Before this change drive->id->last_id & 0x7 was used as shost->max_lun
>>and "hdXlun=" kernel parameter could be used to override it.
>>
>>It was needed probably only for some rare ATAPI PD-CD drives
>>(http://www.geocrawler.com/archives/3/58/1999/11/50/2877161/).
>>
>>However it was far from optimal:
>>- people played with "hdXlun=" and then complained about multiple instances
>>  of the same device (most ATAPI drives respond to each LUN)
>>- probably some devices return 7 not 0 in id->last_id (=> 7 x same device)
>>
>>This patch cleans things up, multi-lun will be fixed if needed in ide-scsi.
>>I think that this may work but can't verify it:
>>
>>	if (id->last_lun && id->last_lun != 7)
>>		shost->max_lun = id->last_lun + 1;
>>	else
>>		shost->max_lun = 1;
> 
> 
> I have verified that this works with my PD/CD drive, the patch to ide-scsi.c
> that I suggest (against linux-2.6.4-rc1-mm2) is below.


I have a multi-LUN ATAPI CD changer here...

	Jeff



