Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130108AbRASThd>; Fri, 19 Jan 2001 14:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130399AbRASThX>; Fri, 19 Jan 2001 14:37:23 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:9740 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S130108AbRASThE>;
	Fri, 19 Jan 2001 14:37:04 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: mkloppstech@freenet.de
Date: Fri, 19 Jan 2001 20:35:58 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: matroxfb
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <130B98052DAB@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Jan 01 at 18:18, mkloppstech@freenet.de wrote:
> I have a Matrox G450 and Kernel 2.4.0.
> Vesafb works fine, however not matroxfb.
> First, matroxfb.o does not exist.

Why do you think that matroxfb.o should exist?

> Any other module in the matrox directory doesn't do anything.
> strace fbset -s returns -ENOSYS for /dev/fb0, which exists.
> Loading matroxfb_base.o crashes the computer immediately.
> What's wrong?

Ask Matrox. On some boards, under some circumstances, accelerator
dies after painting about 60 characters (you should see correct
chars at the beginning of first line on screen). It stops doing anything,
and G450 reports that command FIFO is full (under normal conditions,
I cannot get even two entries in FIFO when painting 8x16 chars on my
dual PIII/800). Next write access to acelerator locks PCI bus forever,
so even if you patch mga_fifo() to not loop endlessly, it will not
fix problem.

You can try either booting to Windows, and then to Linux, or you can
just try poweroff/poweron again and again. In ~5 attempts it starts working
and works until poweroff.

You can also use 'insmod matroxfb_base noaccel=1'. Without accelerator
it works fine. But make sure that your mode lines in /etc/fb.modes do
not contain 'accel true' lines. As soon as you enable acceleration,
it dies again. So best is compiling matroxfb into kernel - then if it
dies, filesystems are not mounted, so you can reboot quickly...

Also, secondary head output to TV is not supported, and probably never
will be, unless Matrox releases documentation.

I was able to decrease number of unsucessfull powerons with updating BIOS,
and not using AGP4x. But I was not able to get 100% success.
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
