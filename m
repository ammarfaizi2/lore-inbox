Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265958AbUFWBqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265958AbUFWBqo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 21:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265930AbUFWBqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 21:46:44 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:44521 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S265958AbUFWBqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 21:46:42 -0400
Date: Wed, 23 Jun 2004 10:47:58 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: Re: [PATCH 2/4]Diskdump Update
In-reply-to: <20040622121201.GA1820@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <EBC458C41C138Bindou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.55
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <20040622121201.GA1820@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jun 2004 13:12:01 +0100, Christoph Hellwig wrote:

>On Tue, Jun 22, 2004 at 09:01:43PM +0900, Takao Indoh wrote:
>> On Thu, 17 Jun 2004 14:39:06 +0100, Christoph Hellwig wrote:
>> 
>> >> >please make it not a module of it's own but part of the
>> >> >scsi code, 
>> >> 
>> >> Do you mean scsi_dump module should be merged with sd_mod.o or 
>> >> scsi_mod.o?
>> >
>> >scsi_mod.o.
>> 
>> It is difficult because disk_dump and scsi_dump try to check checksum of
>> itself using check_crc_module so as to confirm whether module is
>> compromised or not.
>
>
>> Therefore, scsi_dump need to be always compiled as independent module.
>> If scsi_dump is merged with scsi_mod, scsi_mod is not able to be
>> compiled statically.
>
>So check if it's a module and otherwise not.

It means checksum is not used when scsi_mod is compiled statically.
I think it is very important to check the checksum before dump starts.

The most serious problem of dumping to the disk is that dumping may 
overwrite parts of filesystem and destroy user data. This problem
happens when data structures or codes which is used during dumping are
broken.

Diskdump solves this problem by the following methods.
a) Using module checksum, check whether codes (and data) are broken.
b) Confirm whether the target device is really dump device, by checking
   that target device is rightly formatted.

Therefore, checking the checksum is necessary before dumping. scsi_dump
always needs to be compiled as module. So I said it is difficult to
merge scsi_dump with scsi_mod.

Best Regards,
Takao Indoh
