Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbUKUAxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbUKUAxv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 19:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbUKUAxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 19:53:51 -0500
Received: from 82-43-72-5.cable.ubr06.croy.blueyonder.co.uk ([82.43.72.5]:19440
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S261554AbUKUAxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 19:53:46 -0500
From: Alan Chandler <alan@chandlerfamily.org.uk>
To: Jens Axboe <axboe@suse.de>
Subject: Re: ide-cd problem
Date: Sun, 21 Nov 2004 00:53:44 +0000
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <200411201842.15091.alan@chandlerfamily.org.uk> <20041120194756.GU26240@suse.de>
In-Reply-To: <20041120194756.GU26240@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411210053.45065.alan@chandlerfamily.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 November 2004 19:47, Jens Axboe wrote:
> On Sat, Nov 20 2004, Alan Chandler wrote:
...
> > Normally, because the requested data_len is not zero, the data is
> > sent.  In this case however, because the original request had nothing
> > to send, the while/if clauses to initiate a new transfer are skipped
> > and the routine ends up setting a new interrupt handler address and
> > returning to await an interrupt that will never come.
>
> The big question is - what does the original command look like? Just
> dumping rq->cmd[0] would be a big help, but really just put code in
> sg_io() in block/scsi_ioctl.c to dump the completed sg_io_hdr_t and send
> that.

I haven't dumped the whole request header, but the command (after it has been 
retrieved from the user) and the dxfer_length.  Is there anything else I 
should dump?

Here is the output leading up to the point where ide-cd hangs because the IO 
is just left pending

Nov 21 00:44:20 kanger kernel: sg_io command length 10
Nov 21 00:44:20 kanger kernel: sg_io command [0] = 0x3c
Nov 21 00:44:20 kanger kernel: sg_io command [1] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io command [2] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io command [3] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io command [4] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io command [5] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io command [6] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io command [7] = 0xfc
Nov 21 00:44:20 kanger kernel: sg_io command [8] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io command [9] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io dxfer_len = 64512
Nov 21 00:44:20 kanger kernel: sg_io command length 10
Nov 21 00:44:20 kanger kernel: sg_io command [0] = 0x3c
Nov 21 00:44:20 kanger kernel: sg_io command [1] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io command [2] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io command [3] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io command [4] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io command [5] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io command [6] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io command [7] = 0xfc
Nov 21 00:44:20 kanger kernel: sg_io command [8] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io command [9] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io dxfer_len = 64512
Nov 21 00:44:20 kanger kernel: sg_io command length 10
Nov 21 00:44:20 kanger kernel: sg_io command [0] = 0x3c
Nov 21 00:44:20 kanger kernel: sg_io command [1] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io command [2] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io command [3] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io command [4] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io command [5] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io command [6] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io command [7] = 0xfc
Nov 21 00:44:20 kanger kernel: sg_io command [8] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io command [9] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io dxfer_len = 64512
Nov 21 00:44:20 kanger kernel: sg_io command length 10
Nov 21 00:44:20 kanger kernel: sg_io command [0] = 0x3c
Nov 21 00:44:20 kanger kernel: sg_io command [1] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io command [2] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io command [3] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io command [4] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io command [5] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io command [6] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io command [7] = 0xfc
Nov 21 00:44:20 kanger kernel: sg_io command [8] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io command [9] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io dxfer_len = 64512
Nov 21 00:44:20 kanger kernel: sg_io command length 6
Nov 21 00:44:20 kanger kernel: sg_io command [0] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io command [1] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io command [2] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io command [3] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io command [4] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io command [5] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io dxfer_len = 0
Nov 21 00:44:20 kanger kernel: sg_io command length 6
Nov 21 00:44:20 kanger kernel: sg_io command [0] = 0x1b
Nov 21 00:44:20 kanger kernel: sg_io command [1] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io command [2] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io command [3] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io command [4] = 0x3
Nov 21 00:44:20 kanger kernel: sg_io command [5] = 0x0
Nov 21 00:44:20 kanger kernel: sg_io dxfer_len = 0
Nov 21 00:45:00 kanger kernel: hdc: lost interrupt
Nov 21 00:45:40 kanger kernel: hdc: lost interrupt
Nov 21 00:47:00 kanger last message repeated 2 times
Nov 21 00:47:40 kanger kernel: hdc: lost interrupt



-- 
Alan Chandler
alan@chandlerfamily.org.uk
First they ignore you, then they laugh at you,
 then they fight you, then you win. --Gandhi
