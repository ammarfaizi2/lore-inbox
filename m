Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261486AbULaIHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbULaIHG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 03:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbULaIHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 03:07:06 -0500
Received: from hera.kernel.org ([209.128.68.125]:3766 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261486AbULaIHB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 03:07:01 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: initramfs: is it supposed to work?
Date: Fri, 31 Dec 2004 08:06:03 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <cr319b$31b$1@terminus.zytor.com>
References: <41D4A2A6.3060607@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1104480363 3116 127.0.0.1 (31 Dec 2004 08:06:03 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 31 Dec 2004 08:06:03 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <41D4A2A6.3060607@tls.msk.ru>
By author:    Michael Tokarev <mjt@tls.msk.ru>
In newsgroup: linux.dev.kernel
> 
> o And finally, when booting the "right way", using initramfs where
> /init gets executed with pid=1 and should do the same pivot_root
> and things like that, before the umount loop mentioned above,
> it looks almost right:
>   rootfs /initrd rootfs ro 0 0
>   /dev/hda1 / ext3 rw 0 0
> (this is where eg umount from busybox chokes, also entering
> endless loop.. but tha's a different story, it's an obvious
> bug in busybox.. however in order to fix it properly one have
> to know which cases like the 3 mentioned above are possible).
> 

You don't pivot_root initramfs, because initramfs *IS* rootfs.

Instead, use the run-init program from the klibc distribution, or
something similar.  It cleans up the initramfs contents and overmounts
it with the new root filesystem.

	-hpa


