Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269445AbUINPzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269445AbUINPzz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 11:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269455AbUINPyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 11:54:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34528 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269456AbUINPvQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 11:51:16 -0400
Message-ID: <41471366.1070103@pobox.com>
Date: Tue, 14 Sep 2004 11:51:02 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: Jens Axboe <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "C.Y.M." <syphir@syphir.sytes.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Changes to ide-probe.c in 2.6.9-rc2 causing improper detection
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA9mKu6AlYok2efOpJ3sb3O+KAAAAQAAAAjtLAU+gqyUq8AePOBiNtXQEAAAAA@syphir.sytes.net> <20040914060628.GC2336@suse.de> <1095156346.16572.2.camel@localhost.localdomain> <41470BBD.7060700@pobox.com> <20040914152509.GA27892@suse.de> <41470F3A.1060308@rtr.ca> <414710AA.80706@rtr.ca>
In-Reply-To: <414710AA.80706@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> One obvious safeguard would be to never use FLUSH_CACHE on any
> drive that lacks UDMA, unless the drive claims to support FLUSH_CACHE.
> 
> That will eliminate all current FLASH memory devices.

I think you're hunting for hueristics, not making a general rule.  IMO 
any assumption that this behavior will always be limited to flash 
devices is a shaky assumption.

Your initial suggestion is probably much better:
> But one could augment it with a check of the ATA revision code,
> and possibly exclude drives that predate the *formal* introduction
> of the FLUSH_CACHE command, unless their IDENTIFY data specifically
> claims to include it. 

That implies my code would become

	if (ata version < 4)
		return not-supported
	if (wbcache-enabled or have-flush-cache or have-flush-cache-ext)
		return supported
	return not-supported

Yes?

Alan, do you still feel that the "wbcache-enabled" test should be removed?

Since wbcache-enabled is more of a hueristic than a formal test, I don't 
mind removing it.

	Jeff


