Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264039AbTFHXWI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 19:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264040AbTFHXWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 19:22:08 -0400
Received: from codepoet.org ([166.70.99.138]:29654 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S264039AbTFHXWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 19:22:06 -0400
Date: Sun, 8 Jun 2003 17:35:46 -0600
From: Erik Andersen <andersen@codepoet.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linksys WRT54G and the GPL
Message-ID: <20030608233546.GA11064@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Jun 2003 21:53:14 -0600, Erik Andersen wrote:
> I went through a similar exercise several weeks ago when I saw
> the thread on the l-k mailing list.  It took just a fix minutes
> to extract the linux kernel and cramfs filesystem from their
> firmware.  Linksys is indeed shipping BusyBox and the Linux

BTW, this is what I did to open up the Linksys rom...

    #!/bin/sh

    wget ftp://ftp.linksys.com/pub/network/WRT54G_1.02.1_US_code.bin

    # I noticed a GZIP signature for a file name "piggy" at offset
    # 60 bytes from the start, suggesting we have a compressed Linux
    # kernel
    dd if=WRT54G_1.02.1_US_code.bin bs=60 skip=1 | zcat > kernel

    # Noticed there was a cramfs magic signature (bytes 45 3D CD 28
    followed shortly by "Compressed ROMFS") at offset 786464
    dd if=WRT54G_1.02.1_US_code.bin of=cramfs.image bs=786464 skip=1
    file cramfs.image

    sudo mount -o loop,ro -t cramfs ./cramfs.image /mnt 
    ls -la /mnt/bin
    file /mnt/bin/busybox
    strings /mnt/bin/busybox | grep BusyBox
    # Use uClibc's ldd to get useful answers for non-x86 binaries
    /usr/i386-linux-uclibc/bin/i386-uclibc-ldd /mnt/bin/busybox

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
