Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272302AbTHAXTB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 19:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272426AbTHAXSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 19:18:24 -0400
Received: from mrout1.yahoo.com ([216.145.54.171]:17170 "EHLO mrout1.yahoo.com")
	by vger.kernel.org with ESMTP id S272302AbTHAXSR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 19:18:17 -0400
Message-ID: <3F2AF529.3040100@bigfoot.com>
Date: Fri, 01 Aug 2003 16:18:01 -0700
From: Erik Steffl <steffl@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i386; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: SATA (Serial ATA) support in 2.4.x?
References: <3F217BE8.5070807@bigfoot.com> <20030725193548.GA14017@gtf.org>
In-Reply-To: <20030725193548.GA14017@gtf.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> On Fri, Jul 25, 2003 at 11:50:16AM -0700, Erik Steffl wrote:
> 
>>  I am specifically interested whether it should support disks above 
>>137GB (as I have problems accessing anything above 137GB on 250GB SATA 
>>drive)
> 
> 
> It should.
> 
> I will be testing this when I return from OLS, next week.

   any news?

   I have found that /var/log/kern.log has following messages (when 
trying to access blocks above 137GB, using e.g. badblocks):

Jul 29 00:41:02 jojda kernel: Attached scsi disk sda at scsi0, channel 
0, id 0, lun 0
Jul 29 00:41:02 jojda kernel: SCSI device sda: 490234752 512-byte hdwr 
sectors (251000 MB)
Jul 29 00:41:03 jojda kernel:  sda: sda1
Jul 29 00:47:41 jojda kernel:  I/O error: dev 08:00, sector 268435456
Jul 29 00:47:41 jojda kernel:  I/O error: dev 08:00, sector 268435456
Jul 29 00:47:41 jojda kernel:  I/O error: dev 08:00, sector 268435472
Jul 29 00:47:41 jojda kernel:  I/O error: dev 08:00, sector 268435456
Jul 29 00:47:41 jojda kernel:  I/O error: dev 08:00, sector 268435456
Jul 29 00:47:41 jojda kernel:  I/O error: dev 08:00, sector 268435464
Jul 29 00:47:41 jojda last message repeated 3 times

   I have found where these are coming from (drivers/scsi/scsi_lib.c) 
but  it's in fairly generic error routine that is called from number of 
places so it doesn't explain anything to me... (I'll take a look at it 
again but considering that I have almost zero experience with kernel 
programming it probably will not be very useful)

   this is using linux-2.4.21-ac4 kernel (scsi sata, as above messages show)

	erik

