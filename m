Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbWIDUxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbWIDUxL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 16:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbWIDUxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 16:53:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63665 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751314AbWIDUxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 16:53:09 -0400
Date: Mon, 4 Sep 2006 13:52:58 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ben Collins <bcollins@ubuntu.com>
Subject: Re: [PATCH 2.6.18-rc4 1/5] ieee1394: sbp2: workaround for write
 protect bit of Initio firmware
In-Reply-To: <44FC8AAC.10609@s5r6.in-berlin.de>
Message-ID: <Pine.LNX.4.64.0609041348220.27779@g5.osdl.org>
References: <tkrat.bbaf8d081f6a31b7@s5r6.in-berlin.de>
 <tkrat.94cecc462a778dde@s5r6.in-berlin.de> <Pine.LNX.4.64.0608271308360.27779@g5.osdl.org>
 <20060828092429.GA8980@infradead.org> <44F2D70F.30102@s5r6.in-berlin.de>
 <44FC8AAC.10609@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 4 Sep 2006, Stefan Richter wrote:
> 
> I finally did my homework.

Thanks for looking into it.

> OS X' and Win XP's SBP-2 drivers send MODE SENSE (6) to RBC disks and to
> SBC disks. OS X sends MODE SENSE (10) to MMC devices, Win XP seems to
> send MODE SENSE (6).

I think that clinches it. If WinXP sends the 6-byte version, we should 
too, since that's effectively what pretty much everybody has tested with 
(yeah, Apple used to be the main firewire user, but I bet there have been 
more XP users over the last few years, it's not like it's unusual on PC's 
any more).

> So it should be safe to remove the use_10_for_ms flag in our sbp2 driver
> at least for RBC disks and SBC disks. I.e. the proposed "workaround for
> write protect bit of Initio firmware" will no longer be necessary.
> 
> Next steps for me to do:
>  - test all my devices with use_10_for_ms removed from sbp2,
>  - prepare patch as candidate for 2.6.19-rc.

Yeah, please send me a patch asap after 2.6.18, so that it can go in very 
early (regardless of anything else).

Btw, somebody should tell the Oracle Endpoint people to get their target 
client to support the 6-byte version too, no? Anybody who knows that team?

		Linus
