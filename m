Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316577AbSGHHYP>; Mon, 8 Jul 2002 03:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316795AbSGHHYO>; Mon, 8 Jul 2002 03:24:14 -0400
Received: from ns.suse.de ([213.95.15.193]:41222 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316577AbSGHHYN>;
	Mon, 8 Jul 2002 03:24:13 -0400
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: direct-to-BIO for O_DIRECT
References: <3D2904C5.53E38ED4@zip.com.au.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 08 Jul 2002 09:26:53 +0200
In-Reply-To: Andrew Morton's message of "8 Jul 2002 05:16:06 +0200"
Message-ID: <p73adp2wugy.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@zip.com.au> writes:

> 	drivers/md/lvm-snap.c
> 	drivers/media/video/video-buf.c
> 	drivers/mtd/devices/blkmtd.c
> 	drivers/scsi/sg.c
> 
> the video and mtd drivers seems to be fairly easy to de-kiobufize.
> I'm aware of one proprietary driver which uses kiobufs.  XFS uses
> kiobufs a little bit - just to map the pages.

lkcd uses it too for its kernel crash dump. I suspect it wouldn't be that
hard to change.

> So with a bit of effort and maintainer-irritation, we can extract
> the kiobuf layer from the kernel.
> 
> Do we want to do that?

I think yes - keeping two kinds of iovectors for IO (kiovecs and BIOs) seems 
to be redundant.
kiovecs never fulfilled their original promise of a universal zero copy
container (e.g. they were too heavy weight for networking) so it's probably
best to remove them as a failed experiment.

-Andi
