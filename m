Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264484AbUAZT1C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 14:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264488AbUAZT1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 14:27:02 -0500
Received: from user-119ahgg.biz.mindspring.com ([66.149.70.16]:22160 "EHLO
	mail.home") by vger.kernel.org with ESMTP id S264484AbUAZT07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 14:26:59 -0500
From: Eric <eric@cisu.net>
To: Andrew Morton <akpm@osdl.org>, "John Stoffel" <stoffel@lucent.com>
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
Date: Mon, 26 Jan 2004 13:26:09 -0600
User-Agent: KMail/1.5.94
Cc: ak@muc.de, Valdis.Kletnieks@vt.edu, bunk@fs.tum.de, cova@ferrara.linux.it,
       linux-kernel@vger.kernel.org
References: <200401232253.08552.eric@cisu.net> <16404.10496.50601.268391@gargle.gargle.HOWL> <20040125220027.30e8cdf3.akpm@osdl.org>
In-Reply-To: <20040125220027.30e8cdf3.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401261326.09903.eric@cisu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 January 2004 00:00, Andrew Morton wrote:
> "John Stoffel" <stoffel@lucent.com> wrote:
> > Sure, the darn thing wouldn't boot, it kept Oopsing with the
> >  test_wp_bit oops (that I just posted more details about).
>
> Does this fix the test_wp_bit oops?

Yes, it fixes my test_wp_bit oops. But NOW, when booting 2.6.2-rc1-mm3 (which 
i pathed removing -funit-at-a-time and the wp_but oops patch) I get an oops 
derefrencing null pointer in blkdev_reread_part.

I booted normal and with vga=ask acpi=off
Here is a close approxamation of what I wrote down by hand. 

raid1: raid set md1 active..(blah blah)
Unable to handle null dereference at virtual address 0000008c025b893
*pde = 00000000
oops = 0000 [#1]
PREEMPT SMP
CPU:	0
EIP:	0060		Not Tainted VLI
EIP is at blkdev_reread_part+0x13/0x80

Trace
[<c025bdfe>] 	blkdev_ioctl+0x30e/0x3b5
[<co17f426>]	wake_up_inode+0x6/0x30 (might be 0xb.. cant read my writing)
[<co1bb696>]	io_ctl_by_bdev+0x26/0x40
[<c0307e53>] do_md_run+0x493/0x5c0
.....trace continues about 20-30 functions

	Let me know if you need more (or more accurate) debugging info. I am very 
sorry if I have copied something down incorrectly. If I have, I guess its a 
great time to learn how to set a up serial console :)

-------------------------
Eric Bambach
Eric at cisu dot net
-------------------------
