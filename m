Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266085AbUGTSKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266085AbUGTSKH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 14:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266081AbUGTSKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 14:10:07 -0400
Received: from thunderdog.allegientsystems.com ([208.251.178.238]:27286 "EHLO
	lasn-001.allegientsystems.com") by vger.kernel.org with ESMTP
	id S266075AbUGTSKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 14:10:01 -0400
Message-ID: <40FD6002.4070206@optonline.net>
Date: Tue, 20 Jul 2004 14:10:10 -0400
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: linux-scsi@vger.kernel.org, random1@o-o.yi.org,
       Luben Tuikov <luben_tuikov@adaptec.com>, benh@kernel.crashing.org,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: device_suspend() levels [was Re: [patch] ACPI work on aic7xxx]
References: <40FD38A0.3000603@optonline.net> <20040720155928.GC10921@atrey.karlin.mff.cuni.cz> <40FD4CFA.6070603@optonline.net> <20040720174611.GI10921@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20040720174611.GI10921@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>>Can you kill #if 0 code?
>>
>>Yes. This is a work in progress. Interestingly, the ifdef'd-out code was 
>>pasted from mptbase.c in the MPT Fusion driver. If it's broken here, 
>>it's probably broken there -- seems the state parameter passed to the 
>>pci resume callback is intended to be a PCI D state, not an ACPI S 
>>state. Can somebody confirm or deny? The kernel is actually passing 
>>state 2 (D2) to the driver when I enter ACPI S3, so presumably the same 
>>failure could happen to fusion.
> 
> 
> I'm no longer sure what should be passed there... We'll probably need
> to turn it into enum... Actually swsusp code in -mm actually passes
> value from enum, and mainline swsusp code passes 0/3. 
> 
> 								Pavel

Seems to me, aside from whether it's an enum or not, it should represent 
a D-state not an ACPI S-state. Some platforms (Power Mac?) probably 
implement PCI power management but not in an ACPI way.

