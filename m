Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261635AbVDEIsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbVDEIsJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 04:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVDEIsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 04:48:09 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:26764 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261636AbVDEIrN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 04:47:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=YXVi0cCqOYUCMww1eYziN8Go4t0bPGJVpQooE1ojwo7fL5cvQjxPwPqRMoK5FxBNdF6/FgvEuewORy/Zrve2CRxzvH9mpJBTb8FajdxM0siX9xzEplgauWFSvFKyeLOStYkLTV6BrEt5rxVDFLgTyafWV9uJcsCDYcaqyH1U1tw=
Message-ID: <58cb370e05040501476c2cb71f@mail.gmail.com>
Date: Tue, 5 Apr 2005 10:47:08 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc1-mm4 crash while mounting a reiserfs3 filesystem
Cc: =?ISO-8859-1?Q?Mathieu_B=E9rard?= <Mathieu.Berard@crans.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050403145606.51ffeb72.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <42500F5E.9090604@crans.org>
	 <20050403145606.51ffeb72.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 3, 2005 11:56 PM, Andrew Morton <akpm@osdl.org> wrote:
> Mathieu Bérard <Mathieu.Berard@crans.org> wrote:
> >
> > Hi,
> > I get a 100% reproductible oops while booting linux 2.6.12-rc1-mm4.
> > (Everyting run smoothly using 2.6.11-mm1)
> > It seems to be related with mounting a reiserfs3 filesystem.
> 
> It looks more like an IDE bug.
> 
> > ReiserFS: hdg1: checking transaction log (hdg1)
> > Unable to handle kernel paging request at virtual address 0a373138
> >   printing eip:
> > df6d1211
> > *pde = 00000000
> > Oops: 0002 [#1]
> > PREEMPT
> > Modules linked in: ext2 mbcache w83627hf i2c_sensor i2c_isa ppp_generic
> > slhc w83627hf_wdt msr cpuid
> > rtc
> > CPU:    0
> > EIP:    0060:[<df6d1211>]    Not tainted VLI
> > EFLAGS: 00010202   (2.6.12-rc1-mm4)
> > EIP is at 0xdf6d1211
> > eax: c9393266   ebx: df6d1c84   ecx: d84eab1e   edx: c155ccf8
> > esi: c039242c   edi: c039239c   ebp: 700d580a   esp: df6d1c80
> > ds: 007b   es: 007b   ss: 0068
> > Process mount (pid: 1132, threadinfo=df6d1000 task=df711a50)
> > Stack: c039242c c0229945 c039239c df6d1000 df6d1000 c039242c c155ccf8
> > c0223051
> >         00000088 00001388 c159ae28 df6d1000 c039242c c155ccf8 c039239c
> > c022333e
> >         df6d1d1c ffffffff c153d6e0 c155bd78 00000000 df6d1d1c c14007f0
> > c0212260
> > Call Trace:
> >   [<c0229945>] flagged_taskfile+0x125/0x380
> >   [<c0223051>] start_request+0x1f1/0x2a0
> >   [<c022333e>] ide_do_request+0x20e/0x3c0
> >   [<c0212260>] __generic_unplug_device+0x20/0x30
> >   [<c0212281>] generic_unplug_device+0x11/0x30
> >   [<c02122ac>] blk_backing_dev_unplug+0xc/0x10
> >   [<c0156336>] sync_buffer+0x26/0x40
> >   [<c02a0b22>] __wait_on_bit+0x42/0x70
> >   [<c0156310>] sync_buffer+0x0/0x40
> >   [<c0156310>] sync_buffer+0x0/0x40
> >   [<c02a0bcd>] out_of_line_wait_on_bit+0x7d/0x90
> >   [<c012bf80>] wake_bit_function+0x0/0x60
> >   [<c01563c9>] __wait_on_buffer+0x29/0x30
> >   [<c01b0dd7>] _update_journal_header_block+0xf7/0x140
> >   [<c01b290d>] journal_read+0x31d/0x470
> >   [<c01b3241>] journal_init+0x4e1/0x650
> >   [<c011748b>] printk+0x1b/0x20
> >   [<c01a3ced>] reiserfs_fill_super+0x34d/0x770
> >   [<c01c9470>] snprintf+0x20/0x30
> >   [<c0189ab6>] disk_name+0x96/0xf0
> >   [<c015bf75>] get_sb_bdev+0xe5/0x130
> >   [<c0163945>] link_path_walk+0x65/0x140
> >   [<c01a4168>] get_super_block+0x18/0x20
> >   [<c01a39a0>] reiserfs_fill_super+0x0/0x770
> >   [<c015c194>] do_kern_mount+0x44/0xf020 30 20 30 20 30 20 30 20 30 20
> > 30 20 30 20 30 20 <1>general p
> 
> It appears that we might have jumped from flagged_taskfile into something
> at 0xdf6d1211, which is rather odd.

It is very odd, we shouldn't hit flagged_taskfile() in the first 
place.  This function currently is executed only for special
HDIO_DRIVE_TASKFILE ioctl requests.
