Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265356AbUADKbj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 05:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265363AbUADKbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 05:31:39 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:50591 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265356AbUADKbh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 05:31:37 -0500
Date: Sun, 4 Jan 2004 11:31:19 +0100
From: Jens Axboe <axboe@suse.de>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: Hugang <hugang@soulinfo.com>, Bart Samwel <bart@samwel.tk>,
       Andrew Morton <akpm@osdl.org>, smackinlay@mail.com,
       Bartek Kania <mrbk@gnarf.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] laptop-mode-2.6.0 version 5
Message-ID: <20040104103119.GB3418@suse.de>
References: <3FF3887C.90404@samwel.tk> <20031231184830.1168b8ff.akpm@osdl.org> <3FF43BAF.7040704@samwel.tk> <3FF457C0.2040303@samwel.tk> <20040101183545.GD5523@suse.de> <20040102170234.66d6811d@localhost> <20040102112733.GA19526@suse.de> <20040102193849.6ff090da@localhost> <20040102120327.GA19822@suse.de> <16375.57972.132841.32878@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16375.57972.132841.32878@wombat.chubb.wattle.id.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04 2004, Peter Chubb wrote:
> >>>>> "Jens" == Jens Axboe <axboe@suse.de> writes:
> 
> Jens> The dump printk() needs to be changed anyways, the rw
> Jens> deciphering is not correct. Something like this is more
> Jens> appropriate:
> 
> Jens>	if (unlikely(block_dump)) { 
> Jens>		char b[BDEVNAME_SIZE];
> Jens>		printk("%s(%d): %s block %Lu on %s\n", current->comm, current-> pid, (rw & WRITE) ? "WRITE" : "READ",
> Jens>		(u64) bio->bi_sector, bdevname(bio->bi_bdev, b)); 
> Jens>	}
> 
> Please cast to (unsigned long long) not (u64) because on 64-bit
> architectures u64 is unsigned long, and you'll get a compiler warning.

Yeah Andrew noted the same thing, my bad.

-- 
Jens Axboe

