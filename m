Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316822AbSGHHlq>; Mon, 8 Jul 2002 03:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316823AbSGHHlp>; Mon, 8 Jul 2002 03:41:45 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:14086 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S316822AbSGHHlo>; Mon, 8 Jul 2002 03:41:44 -0400
Date: Mon, 8 Jul 2002 09:44:17 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: direct-to-BIO for O_DIRECT
Message-ID: <20020708094417.B18142@rotuma.informatik.tu-chemnitz.de>
References: <3D2904C5.53E38ED4@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3D2904C5.53E38ED4@zip.com.au>; from akpm@zip.com.au on Sun, Jul 07, 2002 at 08:19:33PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 07, 2002 at 08:19:33PM -0700, Andrew Morton wrote:
> Question is: what do we want to do with this sucker?  These are the
> remaining users of kiovecs:
> 
> 	drivers/md/lvm-snap.c
> 	drivers/media/video/video-buf.c
> 	drivers/mtd/devices/blkmtd.c
> 	drivers/scsi/sg.c
> 
> the video and mtd drivers seems to be fairly easy to de-kiobufize.
> I'm aware of one proprietary driver which uses kiobufs.  XFS uses
> kiobufs a little bit - just to map the pages.

It would be nice if we could just map a set of user pages to a scatterlist.

Developers of mass transfer devices (video grabbers, dsp devices, sg and
many others) would just LOVE you for this ;-)

Block devices are the common case worth optimizing for, but character
devices just need to reimplement most of this, if they want the same 
optimizations. Some devices need mass transfers and are NOT blockdevices.

Linux supports only one class of them properly: NICs.

Please consider supporting them better for 2.5 in stuff similiar to BIOs
and DMA to/from user pages.

Thanks & Regards

Ingo Oeser
