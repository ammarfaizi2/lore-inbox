Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265110AbUAEFYj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 00:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265171AbUAEFYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 00:24:39 -0500
Received: from glockenspiel.complete.org ([69.10.152.57]:52353 "EHLO
	glockenspiel.complete.org") by vger.kernel.org with ESMTP
	id S265110AbUAEFYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 00:24:34 -0500
Date: Sun, 4 Jan 2004 23:24:26 -0600
From: John Goerzen <jgoerzen@complete.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SYM53c8xx Panic on Boot: 2.6.1rc1 (Alpha)
Message-ID: <20040105052426.GA2116@complete.org>
References: <slrnbvegjp.4er.jgoerzen@christoph.complete.org> <20040105025450.A16408@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040105025450.A16408@jurassic.park.msu.ru>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 02:54:50AM +0300, Ivan Kokshaysky wrote:
> On Sat, Jan 03, 2004 at 10:30:17PM +0000, John Goerzen wrote:
> > SCSI device sda: drive cache: write back
> >  sda:Bad unaligned kernel access at fffffc000043ec28: fffffc001fe72432 22 31
> > Kernel panic: Attempted to kill init!
> ...
> > # CONFIG_ALPHA_SRM is not set
> 
> So you're booting from MILO - its ancient PALcode doesn't handle

Yes.

> prefetch instructions with invalid target address "properly".
> Personally I don't consider this as a PALcode bug, since even
> with a "correct" PALcode spin_lock_prefetch() just burns CPU cycles
> on uni-processor (and I think this applies not only to Alpha).
> 
> Does that old patch work for you?

That does improve matters immensely, and the system does actually boot
far enough for me to get a login prompt.

However, a few seconds after I logged in, I received:

>n  4 23:12:07 erwin kernel: SCSI error : <0 0 6 0> return code = 0x70000
Jan  4 23:12:07 erwin kernel: end_request: I/O error, dev sdb, sector 4973144
Jan  4 23:12:07 erwin kernel: Buffer I/O error on device dm-1, logical block 237
663
Jan  4 23:12:07 erwin kernel: lost page write due to I/O error on dm-1

then after it repeated about 30 times...

Jan  4 23:12:07 erwin kernel: SCSI error : <0 0 6 0> return code = 0x70000
Jan  4 23:12:07 erwin kernel: end_request: I/O error, dev sdb, sector 4980224
Jan  4 23:12:07 erwin kernel: Buffer I/O error on device dm-1, logical block 239
434
Jan  4 23:12:07 erwin kernel: lost page write due to I/O error on dm-1

which also repeated many times.

While this did not appear to cause any actual data loss, I was spooked
enough that I rebooted the machine into 2.4.23 immediately.  I do not
believe that this is any sort of physical disk problem.

-- John
