Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287488AbRLaLwg>; Mon, 31 Dec 2001 06:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287493AbRLaLw0>; Mon, 31 Dec 2001 06:52:26 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:22533 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S287488AbRLaLwI>;
	Mon, 31 Dec 2001 06:52:08 -0500
Date: Mon, 31 Dec 2001 12:51:57 +0100
From: Jens Axboe <axboe@suse.de>
To: Peter Osterlund <petero2@telia.com>, Greg KH <greg@kroah.com>,
        linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: "sr: unaligned transfer" in 2.5.2-pre1
Message-ID: <20011231125157.D1246@suse.de>
In-Reply-To: <m2vgexzv90.fsf@ppro.localdomain> <20011223112249.B4493@kroah.com> <m23d1trr4w.fsf@pengo.localdomain> <20011230122756.L1821@suse.de> <20011230212700.B652@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011230212700.B652@one-eyed-alien.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30 2001, Matthew Dharm wrote:
> If it shouldn't be used, it should be removed from the structure to force
> people to change.

It will be soonish. Davem has practically finished this already.

> This is probably why usb-storage broke, and it wasn't obvious to me what
> went wrong.

It's been discussed here before, both wrt 2.5 and 2.4 with the block
highmem patches.

> So now I guess I need to either (a) compute the address for the USB layer,
> or (b) figure out how to pass the memory parameters directly, so we can use
> highmem.

If you don't set highmem_io in the scsi host structure, then you can
always do

	vaddr = page_address(sg->page) + sg->offset;

-- 
Jens Axboe

