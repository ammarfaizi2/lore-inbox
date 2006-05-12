Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbWELUvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWELUvN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 16:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWELUvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 16:51:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2488 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932065AbWELUvM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 16:51:12 -0400
Date: Fri, 12 May 2006 13:50:46 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Erik Mouw <erik@harddisk-recovery.com>,
       Or Gerlitz <or.gerlitz@gmail.com>, linux-scsi@vger.kernel.org,
       axboe@suse.de, Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
Subject: Re: [BUG 2.6.17-git] kmem_cache_create: duplicate cache scsi_cmd_cache
In-Reply-To: <20060512203850.GC17120@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0605121346060.3866@g5.osdl.org>
References: <20060511151456.GD3755@harddisk-recovery.com>
 <15ddcffd0605112153q57f139a1k7068e204a3eeaf1f@mail.gmail.com>
 <20060512171632.GA29077@harddisk-recovery.com> <Pine.LNX.4.64.0605121024310.3866@g5.osdl.org>
 <1147456038.3769.39.camel@mulgrave.il.steeleye.com>
 <1147460325.3769.46.camel@mulgrave.il.steeleye.com>
 <Pine.LNX.4.64.0605121209020.3866@g5.osdl.org> <20060512203850.GC17120@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 May 2006, Russell King wrote:
> 
> Great, I'm fucked by the SCSI folk again.

No, you introduced a regression. This isn't the SCSI layer being evil, 
this is the "regressions aren't acceptable".

Fixing one bug and introducing another is actively _worse_ than having the 
same bug stay around.

> Can we revert the patch which broke the MMC/SD layer - the one which
> added the mount/unmount hotplug events as well then.
> 
> That way we get back to a working MMC/SD layer as well as a working
> SCSI layer.

That's certainly the logical fix - push the pain up the chain to the 
person who introduced it. Which commit is that, do you know?

Really, the added ref-count should be gotten by whoever holds on to the 
thing, and it sounds like it's the hotplug event that caused this and 
should have held on to its hotplug reference.

Greg added to the Cc: list in case he already knows off-hand which commit 
it is..

		Linus
