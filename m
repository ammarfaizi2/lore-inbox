Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262648AbUFVMA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbUFVMA3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 08:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbUFVMA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 08:00:29 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:2182 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262648AbUFVMA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 08:00:27 -0400
Date: Tue, 22 Jun 2004 21:01:43 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: Re: [PATCH 2/4]Diskdump Update
In-reply-to: <20040617133906.GA32219@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <E3C45850AF4E78indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.55
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <20040617133906.GA32219@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2004 14:39:06 +0100, Christoph Hellwig wrote:

>> >please make it not a module of it's own but part of the
>> >scsi code, 
>> 
>> Do you mean scsi_dump module should be merged with sd_mod.o or scsi_mod.o?
>
>scsi_mod.o.

It is difficult because disk_dump and scsi_dump try to check checksum of
itself using check_crc_module so as to confirm whether module is
compromised or not.

drivers/scsi/scsi_dump.c:
static int
scsi_dump_sanity_check(struct disk_dump_device *dump_device)
{
        struct scsi_device *sdev = dump_device->device;
        struct Scsi_Host *host = sdev->host;
        int adapter_sanity = 0;
        int sanity = 0;

        if (!check_crc_module()) {
                Err("checksum error. scsi dump module may be compromised.
");
                return -EINVAL;
        }

Therefore, scsi_dump need to be always compiled as independent module.
If scsi_dump is merged with scsi_mod, scsi_mod is not able to be
compiled statically.

Best Regards,
Takao Indoh
