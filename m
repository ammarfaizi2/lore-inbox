Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbWEOEKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbWEOEKw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 00:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWEOEKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 00:10:51 -0400
Received: from hqemgate02.nvidia.com ([216.228.112.143]:21557 "EHLO
	HQEMGATE02.nvidia.com") by vger.kernel.org with ESMTP
	id S1751393AbWEOEKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 00:10:51 -0400
Message-ID: <4466E2E8.7090801@nvidia.com>
Date: Sun, 14 May 2006 03:57:28 -0400
From: Ayaz Abdulla <aabdulla@nvidia.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jeff@garzik.org, netdev@vger.kernel.org,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: Linux v2.6.17-rc4
References: <Pine.LNX.4.64.0605111640010.3866@g5.osdl.org> <200605122219.37626.s0348365@sms.ed.ac.uk>
In-Reply-To: <200605122219.37626.s0348365@sms.ed.ac.uk>
X-NVConfidentiality: public
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 May 2006 04:10:18.0796 (UTC) FILETIME=[7A2A26C0:01C677D5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alistair John Strachan wrote:
> On Friday 12 May 2006 00:44, Linus Torvalds wrote:
> 
>>Ok, I've let the release time between -rc's slide a bit too much again,
>>but -rc4 is out there, and this is the time to hunker down for 2.6.17.
>>
>>If you know of any regressions, please holler now, so that we don't miss
>>them.
>>
>>-rc4 itself is mainly random driver fixes (sound, infiniband, scsi,
>>network drivers), but some splice fixes too and some arch (arm, powerpc,
>>mips) updates. Shortlog follows,
> 
> 
> Linus,
> 
> I've got an oops in the forcedeth driver on shutdown. Sorry for the crappy 
> camera phone pictures, this board doesn't have RS232 ports:
> 
> http://devzero.co.uk/~alistair/oops-20060512/
> 
> It was initially difficult to reproduce, but I found I could do so reliably if 
> I ssh'ed into the box and halted it remotely, then it would always oops on 
> shutdown. I assume this is because the driver is still active when something 
> happens to it during halt.
> 
> There's been just a single commit since -rc3:
> 
> forcedeth: fix multi irq issues
> ebf34c9b6fcd22338ef764b039b3ac55ed0e297b
> 
> However, it could have just been hidden since before -rc3, so I'll try to work 
> backwards if nobody has any immediate ideas..
> 

The interrupt handler could be called during the same time (on different 
cpu) the dev->stop function is clearing out the rings (nv_txrx_reset).

