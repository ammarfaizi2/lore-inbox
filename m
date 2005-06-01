Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbVFASNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbVFASNr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 14:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVFASMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 14:12:42 -0400
Received: from mail.tmr.com ([64.65.253.246]:33413 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261504AbVFASB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 14:01:57 -0400
Message-ID: <429DFBF1.3080402@tmr.com>
Date: Wed, 01 Jun 2005 14:18:25 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Bernd Eckenfels <ecki@lina.inka.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RAID-5 design bug (or misfeature)
References: <E1DcXfR-0000zf-00@calista.eckenfels.6bone.ka-ip.net>	 <Pine.LNX.4.58.0505300440550.15088@artax.karlin.mff.cuni.cz> <1117454144.2685.174.camel@localhost.localdomain>
In-Reply-To: <1117454144.2685.174.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Llu, 2005-05-30 at 03:47, Mikulas Patocka wrote:
> 
>>>In article <Pine.LNX.4.58.0505300043540.5305@artax.karlin.mff.cuni.cz> you wrote:
>>>
>>>>I think Linux should stop accessing all disks in RAID-5 array if two disks
>>>>fail and not write "this array is dead" in superblocks on remaining disks,
>>>>efficiently destroying the whole array.
> 
> 
> It discovered the disks had failed because they had outstanding I/O that
> failed to complete and errorred. At that point your stripes *are*
> inconsistent. If it didn't mark them as failed then you wouldn't know it
> was corrupted after a power restore. You can then clean it fsck it,
> restore it, use mdadm as appropriate to restore the volume and check it.
> 
> 
>>But root disk might fail too... This way, the system can't be taken down
>>by any single disk crash.
> 
> 
> It only takes on disk in an array to short 12v and 5v due to a component
> failure to total the entire disk array, and with both IDE and SCSI a
> drive fail can hang the entire bus anyway.

Having somthing called "the entire bus" is more common on SCSI than IDE 
(at least well-configured IDE) unless you mean the PCI bus. I regularly 
used to see failures of one drive which made the SCSI controller decide 
that one other drive was bad. Fortunately some change in either the 
drive or controller (IBM ServeRAID) has made that a non-problem.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
