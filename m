Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264379AbRFHWAg>; Fri, 8 Jun 2001 18:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264376AbRFHWA0>; Fri, 8 Jun 2001 18:00:26 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:7684 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264355AbRFHWAO>; Fri, 8 Jun 2001 18:00:14 -0400
Subject: Re: [CHECKER] 15 probable security holes in 2.4.5-ac8
To: engler@csl.Stanford.EDU (Dawson Engler)
Date: Fri, 8 Jun 2001 22:58:11 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
In-Reply-To: <200106082134.OAA12792@csl.Stanford.EDU> from "Dawson Engler" at Jun 08, 2001 02:34:01 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E158UGh-0003Hl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [BUG]  dataxferlen is never checked.
> /u2/engler/mc/oses/linux/2.4.5-ac8/drivers/scsi/megaraid.c:4108:megadev_ioctl: ERROR:RANGE:3825:4108: Using user length "dataxferlen" as argument to "copy_from_user" [type=LOCAL] [state = any_check] set by 'copy_from_user':3825 [val=28300]

Yep. Fixed - privileged ioctl fortunately

> static int moxaload320b(int cardno, unsigned char * tmp, int len)
> {
>         unsigned long baseAddr;
>         int i;

Fixed - privileged anyway

> ---------------------------------------------------------
> [BUG]  d.idx is an int: < 0 = bad news.
> /u2/engler/mc/oses/linux/2.4.5-ac8/drivers/char/drm/i810_dma.c:1413:i810_copybuf: ERROR:RANGE:1409:1413: Using user length "idx"as an array index for "buflist" set by 'copy_from_user':1409 [val=400]
> 	if(!_DRM_LOCK_IS_HELD(dev->lock.hw_lock->lock)) {
> 		DRM_ERROR("i810_dma called without lock held\n");

Fixed - nasty

> [BUG]  ouch.  (routine also uses it as an index)
> /u2/engler/mc/oses/linux/2.4.5-ac8/drivers/usb/se401.c:1290:se401_ioctl: ERROR:RANGE:1286:1290: Using user length "frame"as an array index for "frame" set by 'copy_from_user':1286 [val=400]

Uggh..

> [BUG]  ouch x 2: no check either way.
> /u2/engler/mc/oses/linux/2.4.5-ac8/drivers/char/drm/mga_state.c:835:mga_iload: ERROR:RANGE:827:835: Using user length "idx"as an array index for "buflist" set by 'copy_from_user':827 [val=800]

Nasty - left for the X folks to fix

> [BUG] (but i'm not sure whey we're missing the initial irq).
> /u2/engler/mc/oses/linux/2.4.5-ac8/drivers/net/hamradio/scc.c:1772:scc_net_ioctl: ERROR:RANGE:1762:1772: Using user length "irq"as an array index for "Ivec" set by 'copy_from_user':1762 [val=1000]
> 			if (!arg) return -EFAULT;

Thats a real bug for other reaosns. the iRQ might be > 16 on APIC using hosts
or non x86

Both fixed

> [BUG]  usbvideo_GetFrame can fail, but result is not checked before index.
> /u2/engler/mc/oses/linux/2.4.5-ac8/drivers/usb/usbvideo.c:1596:usbvideo_v4l_ioctl: ERROR:RANGE:1572:1596: Using user length "frameNum"as an array index for "frame" set by 'copy_from_user':1572 [val=2400]
> 		}

Fixed

> ---------------------------------------------------------
> [BUG] pretty sure, though the code is convoluted.
> /u2/engler/mc/oses/linux/2.4.5-ac8/drivers/media/video/zr36067.c:3505:do_zoran_ioctl: ERROR:RANGE:3435:3505: Using user length "norm"as an array index for "cardnorms" [val=7000]

Done

