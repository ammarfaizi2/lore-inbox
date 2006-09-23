Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbWIWILf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWIWILf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 04:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbWIWILf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 04:11:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56470 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750832AbWIWIL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 04:11:29 -0400
Date: Sat, 23 Sep 2006 01:06:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Claudio Lanconelli <lanconelli.claudio@eptar.com>
Subject: Re: 2.6.19 -mm merge plans
Message-Id: <20060923010610.d048629e.akpm@osdl.org>
In-Reply-To: <45121382.1090403@garzik.org>
References: <20060920135438.d7dd362b.akpm@osdl.org>
	<45121382.1090403@garzik.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006 00:22:26 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> > There are quite a lot of patches here which belong in subsystem trees. 
> > I'll patchbomb the relevant maintainers soon.  Could I pleeeeeze ask that
> > they either merge the patches or solidly nack them (with reasons)?  Don't
> > just ignore it all and leave me hanging onto this stuff for ever.  Thanks.
> 
> I know this is probably heresy, but what would happen if we didn't merge 
> all that stuff at once, and then committed to having a real 4-week cycle?
> 
> The cycles seem to be stretching out again, and I don't really think 
> it's worth it to hold up the entire kernel for every single piddly 
> little regression to get fixed.  We'll _never_ be perfect, even if we 
> weren't slackers.

It's remarkable how one can wait for months for the next kernel release,
carefully lining up, testing and reviewing the patches for the next
release, then whoop!  As soon as Linus cuts a new release all sorts of
hitherto unimagined stuff comes out of the woodwork and gets instaslammed
into mainline.

WARNING: "register_mtd_blktrans" [drivers/mtd/rfd_ftl.ko] undefined!
WARNING: "deregister_mtd_blktrans" [drivers/mtd/rfd_ftl.ko] undefined!
WARNING: "add_mtd_blktrans_dev" [drivers/mtd/rfd_ftl.ko] undefined!
WARNING: "del_mtd_blktrans_dev" [drivers/mtd/rfd_ftl.ko] undefined!
WARNING: "register_mtd_blktrans" [drivers/mtd/nftl.ko] undefined!
WARNING: "add_mtd_blktrans_dev" [drivers/mtd/nftl.ko] undefined!
WARNING: "deregister_mtd_blktrans" [drivers/mtd/nftl.ko] undefined!
WARNING: "del_mtd_blktrans_dev" [drivers/mtd/nftl.ko] undefined!
WARNING: "register_mtd_blktrans" [drivers/mtd/mtdblock_ro.ko] undefined!
WARNING: "add_mtd_blktrans_dev" [drivers/mtd/mtdblock_ro.ko] undefined!
WARNING: "del_mtd_blktrans_dev" [drivers/mtd/mtdblock_ro.ko] undefined!
WARNING: "deregister_mtd_blktrans" [drivers/mtd/mtdblock_ro.ko] undefined!
WARNING: "register_mtd_blktrans" [drivers/mtd/mtdblock.ko] undefined!
WARNING: "add_mtd_blktrans_dev" [drivers/mtd/mtdblock.ko] undefined!
WARNING: "del_mtd_blktrans_dev" [drivers/mtd/mtdblock.ko] undefined!
WARNING: "deregister_mtd_blktrans" [drivers/mtd/mtdblock.ko] undefined!
WARNING: "register_mtd_blktrans" [drivers/mtd/inftl.ko] undefined!
WARNING: "add_mtd_blktrans_dev" [drivers/mtd/inftl.ko] undefined!
WARNING: "deregister_mtd_blktrans" [drivers/mtd/inftl.ko] undefined!
WARNING: "del_mtd_blktrans_dev" [drivers/mtd/inftl.ko] undefined!
WARNING: "register_mtd_blktrans" [drivers/mtd/ftl.ko] undefined!
WARNING: "deregister_mtd_blktrans" [drivers/mtd/ftl.ko] undefined!
WARNING: "add_mtd_blktrans_dev" [drivers/mtd/ftl.ko] undefined!
WARNING: "del_mtd_blktrans_dev" [drivers/mtd/ftl.ko] undefined!

Please don't do this.

Quick review:

- search for "( " and " )", fix.

- Might want to do something about the 512-byte automatic variable in
  get_valid_cis_sector()

- It's full of uint8_t drain bamage.
