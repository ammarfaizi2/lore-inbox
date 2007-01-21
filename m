Return-Path: <linux-kernel-owner+w=401wt.eu-S1751232AbXAURcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbXAURcJ (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 12:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbXAURcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 12:32:08 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:14498 "EHLO
	pd3mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbXAURcH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 12:32:07 -0500
Date: Sun, 21 Jan 2007 11:32:02 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: SATA exceptions triggered by XFS (since 2.6.18)
In-reply-to: <20070121174023.68402ade@localhost>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       Jens Axboe <jens.axboe@oracle.com>, Jeff Garzik <jeff@garzik.org>,
       Tejun Heo <htejun@gmail.com>
Message-id: <45B3A392.6050609@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <20070121152932.6dc1d9fb@localhost>
 <20070121174023.68402ade@localhost>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ornati wrote:
> On Sun, 21 Jan 2007 15:29:32 +0100
> Paolo Ornati <ornati@fastwebnet.it> wrote:
> 
>> Sorry for starting a new thread, but I've deleted the messages from my
>> mail-box, and I'm sot sure it's the same problem as here:
>> 	http://lkml.org/lkml/2007/1/14/108
>>
>> Today I've decided to try XFS... and just doing anything on it
>> (extracting a tarball, for example) make my SATA HD go crazy ;)
>>
>> I don't remember to have seen this using Ext3.
>>
>> [  877.839920] ata1.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action
>> 0x2 frozen [  877.839929] ata1.00: cmd
>> 61/02:00:64:98:98/00:00:00:00:00/40 tag 0 cdb 0x0 data 1024 out
>> [  877.839931]          res 40/00:00:00:4f:c2/00:00:00:4f:c2/00 Emask
>> 0x4 (timeout) [  878.142367] ata1: soft resetting port [  878.351791]
>> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300) [  878.354384]
>> ata1.00: configured for UDMA/133 [  878.354392] ata1: EH complete
>> [  878.355696] SCSI device sda: 156301488 512-byte hdwr sectors
>> (80026 MB) [  878.355716] sda: Write Protect is off
>> [  878.355718] sda: Mode Sense: 00 3a 00 00
>> [  878.355745] SCSI device sda: write cache: enabled, read cache:
>> enabled, doesn't support DPO or FUA
>>
>>
>> It takes nothing to reproduce it.
..

> git-bisect points to this commit:
> 
> ----------------------------------------------
> 
> 12fad3f965830d71f6454f02b2af002a64cec4d3 is first bad commit
> commit 12fad3f965830d71f6454f02b2af002a64cec4d3
> Author: Tejun Heo <htejun@gmail.com>
> Date:   Mon May 15 21:03:55 2006 +0900
> 
> [PATCH] ahci: implement NCQ suppport
> 
> Implement NCQ support.

It looks like what you're getting is an actual NCQ write timing out. 
That makes the bisect result not very interesting since obviously it 
wouldn't have issued any NCQ writes before NCQ support was implemented. 
Seeing as how it's also an entirely different driver I imagine it's a 
different problem than what I've been looking at.

Maybe that drive just has some issues with NCQ? I would be surprised at 
that with a Seagate though..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

