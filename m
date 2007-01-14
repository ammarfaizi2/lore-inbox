Return-Path: <linux-kernel-owner+w=401wt.eu-S1751082AbXANXoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbXANXoV (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 18:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751723AbXANXoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 18:44:21 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:56943 "EHLO
	pd2mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbXANXoV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 18:44:21 -0500
Date: Sun, 14 Jan 2007 17:43:53 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: SATA exceptions with 2.6.20-rc5
In-reply-to: <fa.hif5u4ZXua+b0mVNaWEcItWv9i0@ifi.uio.no>
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>, jeff@garzik.org,
       linux-kernel@vger.kernel.org, htejun@gmail.com
Message-id: <45AAC039.1020808@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <fa.hif5u4ZXua+b0mVNaWEcItWv9i0@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Björn Steinbrink wrote:
> Hi,
> 
> with 2.6.20-rc{2,4,5} (no other tested yet) I see SATA exceptions quite
> often, with 2.6.19 there are no such exceptions. dmesg and lspci -v
> output follows. In the meantime, I'll start bisecting.

...

> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata1.00: cmd e7/00:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1: soft resetting port
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata1.00: configured for UDMA/133
> ata1: EH complete
> SCSI device sda: 160086528 512-byte hdwr sectors (81964 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA

Looks like all of these errors are from a FLUSH CACHE command and the 
drive is indicating that it is no longer busy, so presumably done. 
That's not a DMA-mapped command, so it wouldn't go through the ADMA 
machinery and I wouldn't have expected this to be handled any 
differently from before. Curious..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

