Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261927AbUKUI5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbUKUI5a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 03:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262940AbUKUI5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 03:57:30 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:8084 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261927AbUKUI5T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 03:57:19 -0500
Date: Sun, 21 Nov 2004 09:56:36 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Chandler <alan@chandlerfamily.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-cd problem
Message-ID: <20041121085636.GG26240@suse.de>
References: <200411201842.15091.alan@chandlerfamily.org.uk> <20041120194756.GU26240@suse.de> <200411210053.45065.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411210053.45065.alan@chandlerfamily.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21 2004, Alan Chandler wrote:
> On Saturday 20 November 2004 19:47, Jens Axboe wrote:
> > On Sat, Nov 20 2004, Alan Chandler wrote:
> ...
> > > Normally, because the requested data_len is not zero, the data is
> > > sent.  In this case however, because the original request had nothing
> > > to send, the while/if clauses to initiate a new transfer are skipped
> > > and the routine ends up setting a new interrupt handler address and
> > > returning to await an interrupt that will never come.
> >
> > The big question is - what does the original command look like? Just
> > dumping rq->cmd[0] would be a big help, but really just put code in
> > sg_io() in block/scsi_ioctl.c to dump the completed sg_io_hdr_t and send
> > that.
> 
> I haven't dumped the whole request header, but the command (after it has been 
> retrieved from the user) and the dxfer_length.  Is there anything else I 
> should dump?

No that's fine, that's all I need.

> Here is the output leading up to the point where ide-cd hangs because the IO 
> is just left pending
> 
> Nov 21 00:44:20 kanger kernel: sg_io command length 10
> Nov 21 00:44:20 kanger kernel: sg_io command [0] = 0x3c
> Nov 21 00:44:20 kanger kernel: sg_io command [1] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io command [2] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io command [3] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io command [4] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io command [5] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io command [6] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io command [7] = 0xfc
> Nov 21 00:44:20 kanger kernel: sg_io command [8] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io command [9] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io dxfer_len = 64512
> Nov 21 00:44:20 kanger kernel: sg_io command length 10
> Nov 21 00:44:20 kanger kernel: sg_io command [0] = 0x3c
> Nov 21 00:44:20 kanger kernel: sg_io command [1] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io command [2] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io command [3] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io command [4] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io command [5] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io command [6] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io command [7] = 0xfc
> Nov 21 00:44:20 kanger kernel: sg_io command [8] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io command [9] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io dxfer_len = 64512
> Nov 21 00:44:20 kanger kernel: sg_io command length 10
> Nov 21 00:44:20 kanger kernel: sg_io command [0] = 0x3c
> Nov 21 00:44:20 kanger kernel: sg_io command [1] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io command [2] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io command [3] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io command [4] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io command [5] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io command [6] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io command [7] = 0xfc
> Nov 21 00:44:20 kanger kernel: sg_io command [8] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io command [9] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io dxfer_len = 64512
> Nov 21 00:44:20 kanger kernel: sg_io command length 10
> Nov 21 00:44:20 kanger kernel: sg_io command [0] = 0x3c
> Nov 21 00:44:20 kanger kernel: sg_io command [1] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io command [2] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io command [3] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io command [4] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io command [5] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io command [6] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io command [7] = 0xfc
> Nov 21 00:44:20 kanger kernel: sg_io command [8] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io command [9] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io dxfer_len = 64512
> Nov 21 00:44:20 kanger kernel: sg_io command length 6
> Nov 21 00:44:20 kanger kernel: sg_io command [0] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io command [1] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io command [2] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io command [3] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io command [4] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io command [5] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io dxfer_len = 0
> Nov 21 00:44:20 kanger kernel: sg_io command length 6
> Nov 21 00:44:20 kanger kernel: sg_io command [0] = 0x1b
> Nov 21 00:44:20 kanger kernel: sg_io command [1] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io command [2] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io command [3] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io command [4] = 0x3
> Nov 21 00:44:20 kanger kernel: sg_io command [5] = 0x0
> Nov 21 00:44:20 kanger kernel: sg_io dxfer_len = 0
> Nov 21 00:45:00 kanger kernel: hdc: lost interrupt
> Nov 21 00:45:40 kanger kernel: hdc: lost interrupt
> Nov 21 00:47:00 kanger last message repeated 2 times
> Nov 21 00:47:40 kanger kernel: hdc: lost interrupt

So the last request is a START_STOP unit, which doesn't transfer any
data. If the drive has DRQ_STAT stat set here, it looks very odd. Any
chance you could instrument cdrom_newpc_intr() as well to dump status
bytes and expected transfer lengths from the drive?

-- 
Jens Axboe

