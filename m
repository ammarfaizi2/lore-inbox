Return-Path: <linux-kernel-owner+w=401wt.eu-S1750921AbXACQum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbXACQum (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 11:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbXACQum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 11:50:42 -0500
Received: from smtp-vbr17.xs4all.nl ([194.109.24.37]:3179 "EHLO
	smtp-vbr17.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbXACQul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 11:50:41 -0500
Date: Wed, 3 Jan 2007 17:50:38 +0100 (CET)
From: bbee <bumble.bee@xs4all.nl>
X-X-Sender: legate@dolores.legate.org
To: Tejun Heo <htejun@gmail.com>, Andrew Lyon <andrew.lyon@gmail.com>
cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995
 sactive 0x0) r0xj0
In-Reply-To: <459B2DEA.8080202@gmail.com>
Message-ID: <Pine.LNX.4.64.0701031733001.1969@dolores.legate.org>
References: <f4527be0612271812p7282de31j98462aebde16e5a1@mail.gmail.com>
 <45933A53.1090702@gmail.com> <loom.20070103T020347-255@post.gmane.org>
 <459B140C.1060401@gmail.com> <Pine.LNX.4.64.0701030334460.12309@dolores.legate.org>
 <459B2DEA.8080202@gmail.com>
X-Files: The truth is out there
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2007, Tejun Heo wrote:
> bbee wrote:
>>> Yeap, I have major issues with SDB FISes which contains spurious
>>> completions but most other spurious interrupts shouldn't be dangerous
>>> and I haven't seen spurious completions for quite some time, so I was
>>> thinking either removing the message or printing it only on SDB FIS
>>> containing spurious completions.
>>>
>>> But, Andrew Lyon *is* reporting spurious completions.  Now I just wanna
>>> update those printks such that more info is reported only on spurious
>>> SDB FISes.
>>
>> That would certainly help verify that I'm having the exact same problem,
>> since Andrew didn't say anything about his drive going offline.
>
> Okay.

Sorry, I thought you meant you would need to update it *further*. I applied 
the patch you gave to Andrew with this result so far:

$ dmesg | grep -A1 "spurious interrupt"
ata1: spurious interrupt (irq_stat 0x8 active_tag 0xfafbfcfd sactive 0x0)
ata1: issue=0x0 SAct=0x0 SDB_FIS=004040a1:00000008
--
ata1: spurious interrupt (irq_stat 0x8 active_tag 0xfafbfcfd sactive 0x0)
ata1: issue=0x0 SAct=0x0 SDB_FIS=004040a1:00000001

No luck yet triggering the exception.

On Wed, 3 Jan 2007, Andrew Lyon wrote:
> Alan said he was going to add the drive to a blacklist he was
> maintaining for NCQ, perhaps that has been done in kernel 2.6.19, I
> dont know as I am still running 2.6.18.
>
> Perhaps the WD Raptor drive that I have does have lousy NCQ and that
> explains both the poor performance and the spurious interrupts.

Blacklisting NCQ on the drive(s) for all controllers might be ill advised, 
since it could be a JMicron-specific issue (or ahci-specific, since the 
person in the thread I referenced had a different ahci controller..). 
Either that, or both our drive models have "lousy NCQ"..


Thanks,

bbee
