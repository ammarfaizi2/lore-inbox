Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265446AbTBOXdE>; Sat, 15 Feb 2003 18:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265470AbTBOXdE>; Sat, 15 Feb 2003 18:33:04 -0500
Received: from stroke.of.genius.brain.org ([206.80.113.1]:16320 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S265446AbTBOXdC>; Sat, 15 Feb 2003 18:33:02 -0500
Date: Sat, 15 Feb 2003 18:42:54 -0500
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.61/usb: ioctl control transfer
Message-ID: <20030215234254.GD1183@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030215220122.B536020D1F@dungeon.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030215220122.B536020D1F@dungeon.inka.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 15, 2003 at 11:01:22PM +0100, Andreas Jellinghaus wrote:
> I'm using the devfs from a userspace application.
> the ioctl USBDEVFS_CONTROL is supposed to return
> the number of bytes actualy read from a control
> transfer.
> 
> but the return code i get is always what i specified
> as length of the buffer.
> 
> since i'm using the same usb control transfers
> as the windows drivers and get the same result
> back (but return code is always wLength),
> i wonder if there is a bug in the kernel. Anyone
> has similiar problems?
> 
> Regards, Andreas
> (userspace code ...)
>         syslog(LOG_DEBUG, "usb xmit %02hx %02hx %02hx %02hx 00 00 %02hx %02hx\n"
> ,
>                 type, req, value >> 8, value&0xff, size >> 8, size &
> 0xff);
> 
>         if (! (type & 0x80)) debug_hexdump("Sending:", buf, size);
> 
>         rc = ioctl(fd, USBDEVFS_CONTROL, &ctrl);
>         if (rc == -1) {
>                 syslog(LOG_ERR, "usb ioctl control transfer failed:%s\n",
>                        strerror(errno));
>         }
>         syslog(LOG_DEBUG, "ioctl rc %hx size %hx length %hx",
>                         rc, size, ctrl.length);
>         if (type & 0x80) debug_hexdump("Received:", buf, size);
> 
> 

I seem to be seeing the same thing with USB-storage devices - usb-storage
sees an error because it got back the same value it sent.
It makes mounting usb-storage devices take a LONG time as each send is
followed by a device reset since the returned value is unexpected.

-- 
Murray J. Root

