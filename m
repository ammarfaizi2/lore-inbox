Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268053AbUHFCEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268053AbUHFCEf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 22:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268056AbUHFCEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 22:04:35 -0400
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:52404 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268053AbUHFCEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 22:04:15 -0400
Message-ID: <4112E24A.3060309@yahoo.com>
Date: Thu, 05 Aug 2004 21:43:38 -0400
From: "David N. Arnold" <dnarnold@yahoo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: David Ford <david+challenge-response@blue-labs.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       wiggly@wiggly.org, matt@mattcaron.net, seymour@astro.utoronto.ca
Subject: Re: cdrom: dropping to single frame dma
References: <41040A4B.6080703@blue-labs.org> <20040802132457.GT10496@suse.de> <41102FAB.40701@yahoo.com> <20040804053134.GA10340@suse.de>
In-Reply-To: <20040804053134.GA10340@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Tue, Aug 03 2004, David N. Arnold wrote:
> 
>>I don't know if it's a result of upgrading to 2.6.8-rc2 (from 2.6.5) or 
>>from the patch, but it has changed things.  I still get
>>
>>hdd: DMA timeout retry
>>hdd: timeout waiting for DMA
>>hdd: status timeout: status=0xd0 { Busy }
>>hdd: status timeout: error=0x00
>>hdd: drive not ready for command
>>hdd: ATAPI reset complete
>>cdrom: dropping to single frame dma
>>
>>but ripping stays at its normal speed (5.0x instead of 0.6x) and the 
>>file produced is correct instead of skipping/silence.
>>
>>It doesn't fix the true issue of why I'm getting DMA timeouts, but it 
>>does make ripping useable.
> 
> 
> After the 'dropping to single frame' message, does it work reliably
> after that? And when does the above occur, initially or after some time?
> Details, please.
> 

After the single frame message it completes the CD rip without any other 
timeouts.  I can't tell if single frame mode impairs the speed, because 
sound-juicer doesn't rip at full CD speed anyway.  The DMA timeout 
usually happens in the first few tracks (it's nondeterministic even on 
the same CD).  The only annoying issue left is that the initial ATAPI 
reset freezes the system for a few seconds until it completes.

I don't know if you're interested, but the DMA timeout only happens in 
certain usage patterns.  If you grab the data one frame at a time with 
pauses in between (for example linking an ogg encoder directly to the 
data stream) it will trigger the DMA timeout.  If you rip the CD at full 
  drive speed (like ripping to WAV) or batch the read requests together, 
it doesn't have any problems.  Also, if you slow the max speed of the 
drive down with 'hdparm -E' so that the drive is operating at max 
(because it's now slower than the encoder) it works fine.

This is all on a JLMS XJ-HD163D DVD drive on the latest firmware.

Thanks,
Dave Arnold
