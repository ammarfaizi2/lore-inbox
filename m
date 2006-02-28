Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbWB1MFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWB1MFW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 07:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbWB1MFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 07:05:22 -0500
Received: from mail.dvmed.net ([216.237.124.58]:45700 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932373AbWB1MFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 07:05:20 -0500
Message-ID: <44043C7D.5090207@pobox.com>
Date: Tue, 28 Feb 2006 07:05:17 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Randy Dunlap <randy_d_dunlap@linux.intel.com>,
       lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH 10/13] ATA ACPI: do taskfile before mode commands
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com> <20060222140140.0d9e41b7.randy_d_dunlap@linux.intel.com> <20060228115715.GE4081@elf.ucw.cz>
In-Reply-To: <20060228115715.GE4081@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> On St 22-02-06 14:01:40, Randy Dunlap wrote:
> 
>>From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
>>
>>Do drive/taskfile-specific commands before setting the drive mode.
>>This allows the taskfile to unlock the drive before trying to
>>set the drive mode.
>>
>>Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
>>---
>> drivers/scsi/libata-core.c |   13 ++++++++++---
>> 1 file changed, 10 insertions(+), 3 deletions(-)
>>
>>--- linux-2616-rc4-ata.orig/drivers/scsi/libata-core.c
>>+++ linux-2616-rc4-ata/drivers/scsi/libata-core.c
>>@@ -4297,13 +4297,17 @@ static int ata_start_drive(struct ata_po
>>  */
>> int ata_device_resume(struct ata_port *ap, struct ata_device *dev)
>> {
>>+	printk(KERN_DEBUG "ata%d: resume device\n", ap->id);
> 
> 
> Yep, one more helpful printk. Not. Actually this is four more of them
> in this patch alone. Please remove your debugging code prior to merge.

Agreed, with the modification s/remove/limit by ata_msg_xxx/

	Jeff



