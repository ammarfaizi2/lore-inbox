Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265306AbTBOWAP>; Sat, 15 Feb 2003 17:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265320AbTBOWAP>; Sat, 15 Feb 2003 17:00:15 -0500
Received: from quechua.inka.de ([193.197.184.2]:49797 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S265306AbTBOWAO>;
	Sat, 15 Feb 2003 17:00:14 -0500
X-Mailbox-Line: From aj@dungeon.inka.de  Sat Feb 15 23:01:34 2003
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.61/usb: ioctl control transfer
Date: Sat, 15 Feb 2003 23:01:22 +0100
Message-Id: <20030215220122.B536020D1F@dungeon.inka.de>
From: aj@dungeon.inka.de (Andreas Jellinghaus)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using the devfs from a userspace application.
the ioctl USBDEVFS_CONTROL is supposed to return
the number of bytes actualy read from a control
transfer.

but the return code i get is always what i specified
as length of the buffer.

since i'm using the same usb control transfers
as the windows drivers and get the same result
back (but return code is always wLength),
i wonder if there is a bug in the kernel. Anyone
has similiar problems?

Regards, Andreas
(userspace code ...)
        syslog(LOG_DEBUG, "usb xmit %02hx %02hx %02hx %02hx 00 00 %02hx %02hx\n"
,
                type, req, value >> 8, value&0xff, size >> 8, size &
0xff);

        if (! (type & 0x80)) debug_hexdump("Sending:", buf, size);

        rc = ioctl(fd, USBDEVFS_CONTROL, &ctrl);
        if (rc == -1) {
                syslog(LOG_ERR, "usb ioctl control transfer failed:%s\n",
                       strerror(errno));
        }
        syslog(LOG_DEBUG, "ioctl rc %hx size %hx length %hx",
                        rc, size, ctrl.length);
        if (type & 0x80) debug_hexdump("Received:", buf, size);


