Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285159AbRLMUbe>; Thu, 13 Dec 2001 15:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285160AbRLMUbZ>; Thu, 13 Dec 2001 15:31:25 -0500
Received: from rj.SGI.COM ([204.94.215.100]:60857 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S285159AbRLMUbP>;
	Thu, 13 Dec 2001 15:31:15 -0500
Subject: Re: highmem, aic7xxx, and vfat: too few segs for dma mapping
From: Steve Lord <lord@sgi.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Jens Axboe <axboe@suse.de>, LBJM <LB33JM16@yahoo.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <200112132015.fBDKFig09255@aslan.scsiguy.com>
In-Reply-To: <200112132015.fBDKFig09255@aslan.scsiguy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.13.08.57 (Preview Release)
Date: 13 Dec 2001 14:29:29 -0600
Message-Id: <1008275369.22208.5.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-12-13 at 14:15, Justin T. Gibbs wrote:
> >And this is the scb:
> >0xc7f945b0 c7f90040 c7f943dc 00000000 00000000   @.yG\CyG........
> >0xc7f945c0 c7f945f0 c7f5e000 c7fb0800 00000000   pEyG.`uG..{G....
> >0xc7f945d0 c7bd38c0 c7bd3900 c530c000 0530c008   @8=G.9=G.@0E.@0.
> >0xc7f945e0 00000080 c7f90140 c7f94478 00000000   ....@.yGxDyG....
> >0xc7f945f0 00000000 c7f94554 c7f58000 c7fb0800   ....TEyG..uG..{G
> >0xc7f94600 00004000 c7bd38a0 c7bd3900 c530c400   .@.. 8=G.9=G.D0E
> >0xc7f94610 0530c408 00000080 c7f90080 c7f94478   .D0.......yGxDyG
> >0xc7f94620 00000000 c7f9464c c7f94a00 c7f59c00   ....LFyG.JyG..uG
> >
> >I have the system in a debugger and can look at memory for you
> >if you want.
> 
> I'd like to know the value of scb->io_ctx->use_sg.

Here is the scsi_cmd in hex:

0xc7f5e000 e25c23a5 c13ad980 01021003 c7f84e00   %#\b.Y:A.....NxG
0xc7f5e010 00000000 c7f5e200 00000000 00000000   .....buG........
0xc7f5e020 c0270a70 00002aa4 00000000 00000000   p.'@$*..........
0xc7f5e030 00000005 00000bb8 00000000 00000000   ....8...........
0xc7f5e040 00000000 00000000 00000001 00000000   ................
0xc7f5e050 00000000 01010a0a 9a00002a 00002f17   ........*..../..
0xc7f5e060 00000008 00000000 00001000 c0439104   ..............C@
0xc7f5e070 c7f5e46c 000140ad c7f5e000 c024ff10   lduG-@...`uG.$@
0xc7f5e080 c1b0f000 00000000 9a00002a 00002f17   .p0A....*..../..
0xc7f5e090 00000008 00000000 00000000 00000a00   ................
0xc7f5e0a0 00001000 c1b0f000 00001000 00001000   .....p0A........
0xc7f5e0b0 00000200 00000000 c7f7dd60 c7f84e48   ........`]wGHNxG
0xc7f5e0c0 00003f7f 9a00002a 04002f17 00000000   .?..*..../......
0xc7f5e0d0 00000000 00000039 00000001 00000800   ....9...........
0xc7f5e0e0 00000000 009a172f 00000400 009a172f   ..../......./...
0xc7f5e0f0 00000400 00010080 00000008 00000008   ................
0xc7f5e100 00000000 c1b0f000 00000000 c14ca320   .....p0A.... #LA
0xc7f5e110 c14c6fa0 c7f84e18 c7f84e30 00000000    oLA.NxG0NxG....
0xc7f5e120 00000000 00000000 00000000 00000000   ................
0xc7f5e130 00000000 00000000 00000000 00000000   ................
0xc7f5e140 00000000 00000000 00000000 00000000   ................
0xc7f5e150 00000000 00000000 00000000 00000000   ................
0xc7f5e160 00000000 c024cd30 00000000 00000000   ....0M$@........
0xc7f5e170 00000000 00000000 00000000 c7f48a00   ..............tG

And here is the kdb interpreted version (this command is pretty old,
but built against current structure definitions)

scsi_cmnd at 0xc7f5e000
host = 0xc13ad980  state = 4099  owner = 258  device = 0xc7f84e00
bnext = 0xc7f5e200  reset_chain = 0x00000000  eh_state = 0 done =
0xc0270a70
serial_number = 10916  serial_num_at_to = 0 retries = 0 timeout = 0
id/lun/cmnd = [1/0/0]  cmd_len = 10  old_cmd_len = 10
cmnd = [2a/00/00/9a/17/2f/00/00/08/00/00/00]
data_cmnd = [2a/00/00/9a/17/2f/00/00/08/00/00/00]
request_buffer = 0xc1b0f000  bh_next = 0x00000000  request_bufflen =
4096
use_sg = 0  old_use_sg = 0 sglist_len = 2560 abore_reason = 0
bufflen = 4096  buffer = 0xc1b0f000  underflow = 4096 transfersize = 512
tag = 0 pid = 10915
request struct
rq_status = RQ_ACTIVE  rq_dev = [8/0]  errors = 0nsector = 10098479
nr_sectors = 1024  current_nr_sectors = 8

So according to this, zero.

Steve

> 
> --
> Justin
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com
