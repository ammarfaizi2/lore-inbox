Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261812AbUJYN3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbUJYN3p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 09:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbUJYN1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 09:27:47 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:16063 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261800AbUJYN0G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 09:26:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=FBXNMZep6bWeD5m7a6dzvqk9L1hd5knYds8Bkf2cclF82045WI0FojjsA5aWhlTWT4dAemdJ/LpIUF3jMcyCGYk2PorxUXFOt756T963McKXhK/Rpbsw3K2FLcbNjjozmBKD8+zUzhZAZlrGoTQvPyb5vw0paatXTray7Mz2KA0=
Message-ID: <58cb370e041025062658d28930@mail.gmail.com>
Date: Mon, 25 Oct 2004 15:26:05 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Masakazu Iwamura <masa@cs.osakafu-u.ac.jp>
Subject: Re: Second SATA disk is not recognized in kernel 2.6.x
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20041025.192404.59463574.masa@cs.osakafu-u.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041024.021758.130228080.masa@cs.osakafu-u.ac.jp>
	 <20041025.192404.59463574.masa@cs.osakafu-u.ac.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2004 19:24:04 +0900 (JST), Masakazu Iwamura
<masa@cs.osakafu-u.ac.jp> wrote:
> > I have a trouble which relates to serial ATA (libata). In summary, my
> > PC boots in kernel 2.4.27 with two SATA disks normally. But, in kernel
> > 2.6.x (I tested 2.6.8.1, 2.6.9), it boots with only one disk. The
> > second disk is not available. Are there any good idea to resolve this
> > problem?
> >
> > Actually, my PC has three SATA disks. One of them includes linux
> > system (the boot disk). The others construct a RAID by use of a
> > hardware RAID system "ARAID99 2000". So, BIOS recognizes there are two
> > disks. The RAID system includes my home directory only. The chipset of
> > the motherboard is ICH5R.
> >
> > In kernel 2.4.27, the first disk is recognized as /dev/hde and the
> > second one is as /dev/hdg. In kernel 2.6.x, the first disk is
> > recognized as /dev/sda. But, /dev/sdb does not appear (/dev/hdg is
> > also).
> 
> I also tested 2.6.10-rc1-bk2, 2.6.9-mm1 and 2.6.9-ac4 with almost the
> same configuration in 2.6.9.
> 
> 2.6.10-rc1-bk2 and 2.6.9-mm1 had the same problem as in 2.6.9.
> 
> In 2.6.9-ac4, the PC did not boot because of an error:
> atkbd.c: Spurious ACK on isa 0060/serio0. Some program, like XFree86,
> might be trying access hardware directly.
> 
> I do not know the reason. I attached dmesg outputs in 2.4.27 and
> 2.6.10-rc1-bk2 after booting, and kernel configuration in
> 2.6.10-rc1-bk2.
> Could you please help me?

In 2.4.27 you are using IDE driver (not libata) for your SATA disks.

libata has problems with handling hw RAID connected to the second
SATA port (?), for now you can revert to using IDE driver, just disable
CONFIG_SCSI_SATA and enable CONFIG_BLK_DEV_IDE_SATA.

Bartlomiej
