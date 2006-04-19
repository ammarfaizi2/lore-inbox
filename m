Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbWDSKkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWDSKkK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 06:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbWDSKkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 06:40:10 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:14097 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750848AbWDSKkI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 06:40:08 -0400
Date: Wed, 19 Apr 2006 12:40:09 +0200
From: Jens Axboe <axboe@suse.de>
To: erich <erich@areca.com.tw>
Cc: dax@gurulabs.com, "\"(????????????)??????O\"" <billion.wu@areca.com.tw>,
       Al Viro <viro@ftp.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>,
       Chris Caputo <ccaputo@alt.net>
Subject: Re: new Areca driver in 2.6.16-rc6-mm2 appears to be broken
Message-ID: <20060419104009.GB614@suse.de>
References: <Pine.LNX.4.64.0603212310070.20655@nacho.alt.net> <007701c653d7$8b8ee670$b100a8c0@erich2003> <Pine.LNX.4.64.0603301542590.19680@nacho.alt.net> <004a01c65470$412daaa0$b100a8c0@erich2003> <20060330192057.4bd8c568.akpm@osdl.org> <20060331074237.GH14022@suse.de> <002901c65e33$ceac9e00$b100a8c0@erich2003>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002901c65e33$ceac9e00$b100a8c0@erich2003>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12 2006, erich wrote:
> Dear Jens Axboe,
> 
> I had found a big difference of generic_make_request(struct bio *bio)
> got message : sdb1: rw=0, want=...., limit=.....
> 
> 
> *****************
> ** TEST 1
> *****************
> 
> I used "MAX_XFER_SECTORS  4096" driver to do mkfs.ext2 with ARECA RAID 
> volume sdb1.
> and copy a big file (900MB) into sdb1.
> If I copy this file from sdb1, the message rw=.... ,want=......, 
> limit=...... will appear immediately.
> 
> When I reboot the system and used  "MAX_XFER_SECTORS  512" driver.
> I copy this big file from sdb1, the message rw=.... ,want=......, 
> limit=...... still appear immediately.

This to me looks like you have a corrupted fs after using the 4k sectors
as the max transfer setting. I would look for a bug in the driver that
could explain this. Or perhaps the hardware.

Can you try and boot with MAX_XFER_SECTORS at 4096 and run mkfs + copy
big file to the partition. umount, then boot a kernel with
MAX_XFER_SECTORS at 512 and do a full fsck of that partition.


-- 
Jens Axboe

