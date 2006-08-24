Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbWHXPJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbWHXPJo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 11:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbWHXPJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 11:09:44 -0400
Received: from 81-179-62-49.dsl.pipex.com ([81.179.62.49]:39871 "EHLO
	jaguar.linux-grotto.org.uk") by vger.kernel.org with ESMTP
	id S964993AbWHXPJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 11:09:43 -0400
Message-ID: <44EDC135.4080007@linux-grotto.org.uk>
Date: Thu, 24 Aug 2006 16:09:41 +0100
From: Johan Groth <johan.groth@linux-grotto.org.uk>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: Scsi errors with Megaraid 300-8x
References: <44EB1875.3020403@linux-grotto.org.uk> <44EC73D2.9090302@rtr.ca> <44EC775C.7040003@linux-grotto.org.uk> <Pine.LNX.4.64.0608231145290.15031@p34.internal.lan> <44EC78CD.9010401@linux-grotto.org.uk> <44EDBC39.2070207@rtr.ca>
In-Reply-To: <44EDBC39.2070207@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Johan Groth wrote:
>> Justin Piszcz wrote:
>>> Run badblocks in r+w mode on the bad disk and it will force the disk 
>>> to re-allocate the bad sector if it can.
>>>
>>> Justin.
>>
>> Is that possible to do in a non-destructive way? I don't want to loose 
>> all data and apparently I can't back it up either :(.
> 
> Yes, it is perfectly doable, but I don't think anyone has yet bothered
> to release a utility that actually does it.
> 
> OPPORTUNITY FOR FAME AND FORTUNE! (okay, maybe just some fame):
> =================================
> Hack the existing smartctl code to read out the failed sector numbers,
> and then issue single-sector read-overwrite to each of those bad sectors.
> 
> Very simple code.  I'll do it myself eventually, but please beat me to it!

Authors of badblocks already has with the -n option :). When I ran 
badblocks on the entire partition it wanted to check over 210 million 
blocks and when it finally came to the bad sector parts the controller 
lost the drive and the kernel started to spit out scsi errors! Buggy 
driver, hardware error? God knows. Unfortunately I don't have a log to 
show you as I was in single user mode.

I would like to run badblocks again but only around the damaged part. 
Thing is that I know which sector the kernel thinks is bad but badblocks 
wants to know which block to start and end at. How do I convert a sector 
number to block number. The partition is a standard XFS partition, ie I 
haven't made any changes to block sizes when I formatted it.

Got this from xfs_info:
meta-data=/dev/sda7              isize=256    agcount=16, agsize=3433014 
blks
          =                       sectsz=512   attr=1
data     =                       bsize=4096   blocks=54928224, imaxpct=25
          =                       sunit=0      swidth=0 blks, unwritten=1
naming   =version 2              bsize=4096
log      =internal               bsize=4096   blocks=26820, version=1
          =                       sectsz=512   sunit=0 blks
realtime =none                   extsz=65536  blocks=0, rtextents=0

There's another thing I would like know. How do I find out what file a 
sector belongs to?

Regards,
Johan
