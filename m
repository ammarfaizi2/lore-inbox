Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268689AbUH3Rqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268689AbUH3Rqk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 13:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268683AbUH3RpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 13:45:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55227 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268681AbUH3Roa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 13:44:30 -0400
Message-ID: <4133676B.70800@pobox.com>
Date: Mon, 30 Aug 2004 13:44:11 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brad Campbell <brad@wasp.net.au>
CC: "John W. Linville" <linville@tuxdriver.com>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] libata: add ioctls to support SMART
References: <200408301531.i7UFVBg29089@ra.tuxdriver.com> <41336570.8090308@wasp.net.au>
In-Reply-To: <41336570.8090308@wasp.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Campbell wrote:
> John W. Linville wrote:
> 
>> Support for HDIO_DRIVE_CMD and HDIO_DRIVE_TASK in libata.  Useful for
>> supporting SMART w/ unmodified smartctl and smartd userland binaries.
>>
>> Not happy w/ loop after failed ata_qc_new_init(), but needed because 
>> smartctl
>> and smartd did not retry after failure.  Likely need an option to wait 
>> for
>> available qc?  Also not sure all the error return codes are correct...
>>
> 
> YYYYYYYYYYEeeeeeeeeeeeeeeeeeeeeeeeeeehhhhhhhhhhaaaaaaaaaaaaaaaaaaa!!!!!!!!
> 
> I know it's a bit kludgy and does not really fit the philosophy of 
> libata but it works and it lets me keep an eye on my drives *now*.
> 
> Although just for good measure I'll probably unmount and stop my raid 
> arrays before I use it on the disks. Whats it like for locking on a busy 
> system?

I wouldn't trust it on a busy system yet -- it submits the command to 
the device without checking if there is a command already outstanding.

The patch could _definitely_ corrupt data or lock your hardware, since 
it bypasses the SCSI mechanism that ensures that only one command is 
executing at a time.

	Jeff



