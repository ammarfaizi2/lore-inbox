Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbUL3P4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbUL3P4y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 10:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbUL3P4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 10:56:54 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:9912 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S261658AbUL3P4v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 10:56:51 -0500
Message-ID: <41D4253D.8070006@drzeus.cx>
Date: Thu, 30 Dec 2004 16:56:45 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MMC block removable flag
References: <41D3646F.5050408@drzeus.cx> <20041230095448.A9500@flint.arm.linux.org.uk>
In-Reply-To: <20041230095448.A9500@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>On Thu, Dec 30, 2004 at 03:14:07AM +0100, Pierre Ossman wrote:
>  
>
>>A MMC card is a highly removable device. This patch makes the block 
>>layer part of the MMC layer set the removable flag.
>>    
>>
>
>I have this patch also floating around, but I've decided it isn't needed.
>I believe this flag is to indicate that we have removable media for a
>block device rather than to indicate that the block device can be removed.
>
>However, when we insert and remove a MMC card, we create and destroy the
>block device itself.  Therefore, as far as the block layer is concerned,
>the device itself is being inserted and removed, so telling the block
>layer that the media is removable is just silly - you can't separate the
>flash media from the on-board MMC controller.
>
>(Note: any block device can be removed - you just rmmod the module
>supplying the block device driver, but this doesn't mean we mark all
>block devices with GENHD_FL_REMOVABLE.)
>
>  
>
I suspect that the removable flag might be used in different GUI:s to 
figure out with block devices should be presented to the user in a nice 
way. It's usually just the removable devices that need some form of 
special handling. So even though, as you point out, the entire device 
disappears it might be useful from a user interface perspective to have 
this hint set. From what I've found this flag doesn't seem to change any 
handling inside the kernel, just how the device should be perceived.

Rgds
Pierre

