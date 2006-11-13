Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754588AbWKMM0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754588AbWKMM0W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 07:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754564AbWKMM0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 07:26:22 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:57273 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1754570AbWKMM0V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 07:26:21 -0500
Date: Mon, 13 Nov 2006 13:26:02 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Ivan Ukhov <uvsoft@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: /dev before the root filesystem is mounted
In-Reply-To: <a5de567c0611130415t6cbe97efr8e60a3d3e091d04d@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0611131320590.30156@yvahk01.tjqt.qr>
References: <a5de567c0611130252m52de5071vc25589bfd89b9c27@mail.gmail.com> 
 <Pine.LNX.4.61.0611131234140.28210@yvahk01.tjqt.qr>
 <a5de567c0611130415t6cbe97efr8e60a3d3e091d04d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 13 2006 15:15, Ivan Ukhov wrote:
> i dont use initrd. the kernel understands argument 'root=/dev/...', so
> /dev should exist, mb not in a real filesystem, but just in ram or
> something. i just want to know what devices are available for being
> the root filesystem for the kernel (displaying all available devices
> will be enough for me).

/dev does not exist. How should it? The root filesystem / is empty, other
people can verify that, or you can verify it yourself with an
initramfs (which, unlike an initrd, is copied to / instead of being
mounted).

Yes, the kernel understands root=/dev/ but that's a hack, a strstr(s,
"/dev/"). Should you want to use, say, root=/devices/hda instead,
that would only succeed when using an initrd/initramfs.

To display the accepted block devices (this is most likely what you
really wanted), check out

ftp://ftp-1.gwdg.de/pub/linux/misc/suser-jengelh/kernel/linux-2.6.18-jen35/show_partitions.diff


Please (a) don't top post (b) don't strip Cc:s.

>
> 2006/11/13, Jan Engelhardt <jengelh@linux01.gwdg.de>:
>> 
>> > I want the kernel (2.4) to display (just using printk) all available
>> > devices with full path (/dev/...) before the root filesystem is
>> > mounted.
>> 
>> Case 1: You do not use an initrd/initramfs:
>> / is empty, /dev does not exist.
>> 
>> Case 2: You do use an initrd/initramfs
>> You populated /dev during creation of the initrd/initramfs image OR
>> your init script inside the initrd/initramfs mknods the nodes when run.
>> 
>> 
>>        -`J'
>> --
>> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

	-`J'
-- 
