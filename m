Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261323AbTDCQWK>; Thu, 3 Apr 2003 11:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261326AbTDCQWK>; Thu, 3 Apr 2003 11:22:10 -0500
Received: from CPEdeadbeef0000-CM400026342639.cpe.net.cable.rogers.com ([24.114.185.204]:516
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S261323AbTDCQWJ>; Thu, 3 Apr 2003 11:22:09 -0500
Date: Thu, 3 Apr 2003 11:36:50 -0500 (EST)
From: Shawn Starr <spstarr@sh0n.net>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Narayan Desai <desai@mcs.anl.gov>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.66-bk5 spinlock warnings/errors - Specifically ide-io:109
 spinlock notice
In-Reply-To: <3E8BCB3A.8080806@colorfullife.com>
Message-ID: <Pine.LNX.4.44.0304031136430.270-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I will test this tonight when I get home :-)

On Thu, 3 Apr 2003, Manfred Spraul wrote:

> Shawn wrote:
>
> >>List:     linux-kernel
> >>Subject:  2.5.66-bk5 spinlock warnings/errors
> >From:     Narayan Desai <desai () mcs ! anl ! gov>
> >>Date:     2003-04-02 4:01:02
> >
> >>hda: dma_timer_expiry: dma status == 0x24
> >>drivers/ide/ide-io.c:109: spin_lock(drivers/ide/ide.c:c037abe8) already
> >>locked by drivers/ide/ide-io.c/948 drivers/ide/ide-io.c:990:
> >>spin_unlock(drivers/ide/ide.c:c037abe8) not locked
> >>hda: lost interrupt
> >>hda: dma_intr: bad DMA status (dma_stat=30)
> >>hda: dma_intr: status=0x50 { DriveReady SeekComplete }
> >
> >I had this problem last night while making a huge debian package (tar.bz2
> >stage). It occured once.
> >
> >
> The attached patch should fix the problem:
> the dma_timer_expiry handler calls HWGROUP(drive)->handler in the wrong
> context. Instead of calling ->handler directly, the ->expiry handler
> must inform the caller that ->handler must be called, and then the
> caller must do some setup before calling ->handler.
>
> --
>     Manfred
>

