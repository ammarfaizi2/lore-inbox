Return-Path: <linux-kernel-owner+w=401wt.eu-S1751745AbXAOAW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbXAOAW4 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 19:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbXAOAWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 19:22:55 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:44349 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751725AbXAOAWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 19:22:55 -0500
Message-ID: <45AAC95B.1020708@garzik.org>
Date: Sun, 14 Jan 2007 19:22:51 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       linux-kernel@vger.kernel.org, htejun@gmail.com
Subject: Re: SATA exceptions with 2.6.20-rc5
References: <fa.hif5u4ZXua+b0mVNaWEcItWv9i0@ifi.uio.no> <45AAC039.1020808@shaw.ca>
In-Reply-To: <45AAC039.1020808@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> Björn Steinbrink wrote:
>> Hi,
>>
>> with 2.6.20-rc{2,4,5} (no other tested yet) I see SATA exceptions quite
>> often, with 2.6.19 there are no such exceptions. dmesg and lspci -v
>> output follows. In the meantime, I'll start bisecting.
> 
> ...
> 
>> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
>> ata1.00: cmd e7/00:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 in
>>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
>> ata1: soft resetting port
>> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> ata1.00: configured for UDMA/133
>> ata1: EH complete
>> SCSI device sda: 160086528 512-byte hdwr sectors (81964 MB)
>> sda: Write Protect is off
>> sda: Mode Sense: 00 3a 00 00
>> SCSI device sda: write cache: enabled, read cache: enabled, doesn't 
>> support DPO or FUA
> 
> Looks like all of these errors are from a FLUSH CACHE command and the 
> drive is indicating that it is no longer busy, so presumably done. 
> That's not a DMA-mapped command, so it wouldn't go through the ADMA 
> machinery and I wouldn't have expected this to be handled any 
> differently from before. Curious..

It's possible the flush-cache command takes longer than 30 seconds, if 
the cache is large, contents are discontiguous, etc.  It's a 
pathological case, but possible.

Or maybe flush-cache doesn't get a 30 second timeout, and it should...? 
  (thinking out loud)

	Jeff



