Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268502AbUHLJn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268502AbUHLJn3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 05:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268500AbUHLJn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 05:43:29 -0400
Received: from mail.tpgi.com.au ([203.12.160.61]:53387 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S261232AbUHLJnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 05:43:24 -0400
Subject: Re: [PATCH] SCSI midlayer power management
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Nathan Bryant <nbryant@optonline.net>
Cc: Pavel Machek <pavel@ucw.cz>,
       "'James Bottomley'" <James.Bottomley@steeleye.com>,
       Linux SCSI Reflector <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com
In-Reply-To: <411AA24C.6050303@optonline.net>
References: <4119611D.60401@optonline.net>
	 <20040811080935.GA26098@elf.ucw.cz> <411A1B72.1010302@optonline.net>
	 <1092262602.3553.14.camel@laptop.cunninghams>
	 <411AA24C.6050303@optonline.net>
Content-Type: text/plain
Message-Id: <1092303123.3214.3.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 12 Aug 2004 19:39:51 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-08-12 at 08:48, Nathan Bryant wrote: 
> Just to speculate about what would be required for swsusp: you probably 
> need to be using a SCSI LLD that properly implements pci suspend/resume, 
> which implies you need to make sure the card's DMA state machine is 
> flushed and idle before suspend completes. I've got a patch that fixes 
> this much up for aic7xxx. And my other midlayer-level patch may also 
> help... What happens during resume is interesting. I think maybe the 
> problem is not what the drive is expecting, but what the card's state 
> engine is expecting when it tries to map commands to command buffers in 
> DMA space.  Maybe you need to suspend the LLD from the context of the 
> kernel that is doing the image load, and then resume from the context of 
> the kernel that was just loaded.

I fully agree. That's what I'm doing at the moment; it's been a while
since I looked at swsusp though, so can't say anything about Pavel &
Patrick's implementation.

> >With my 'device tree' code, I'm getting the struct dev of the device
> >we're using via the struct block_device in the swap_info struct.
> >
> Right, though you also need to get the host adapter's struct device, if 
> you're not already doing so, that is. Many IDE host drivers don't bother 
> with suspend/resume callbacks at the pci_driver level, but SCSI needs 
> callbacks because the BIOS usually doesn't handle things for us.

The host adapter isn't in the device's chain of parents?

Nigel 

-- 
Nigel Cunningham
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. But true tolerance can cope with others
being intolerant.

