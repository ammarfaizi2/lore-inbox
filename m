Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281053AbRKDRi2>; Sun, 4 Nov 2001 12:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280969AbRKDRiT>; Sun, 4 Nov 2001 12:38:19 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:7 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S280037AbRKDRiB>;
	Sun, 4 Nov 2001 12:38:01 -0500
Date: Sun, 4 Nov 2001 09:35:19 -0800
From: Greg KH <greg@kroah.com>
To: Marcus Meissner <mm@caldera.de>
Cc: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.13-ac7
Message-ID: <20011104093519.A20323@kroah.com>
In-Reply-To: <20011103185216.A24888@lightning.swansea.linux.org.uk> <200111041659.fA4Gx0B20660@flash.caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200111041659.fA4Gx0B20660@flash.caldera.de>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.19 (i586)
Reply-By: Sun, 07 Oct 2001 16:24:39 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2001 at 05:59:00PM +0100, Marcus Meissner wrote:
> > 2.4.13-ac7
> > o	Add support for one shot interrupt urbs		(Maksim Krasnyanskiy)
> > 	in usbdevfs
> 
> I don't see that patch, there is just one ir-usb.c patch in ac7...

It doesn't look like it really made it in.  I've attached it below
again.

thanks,

greg k-h


diff --minimal -Nru a/drivers/usb/devio.c b/drivers/usb/devio.c
--- a/drivers/usb/devio.c	Thu Nov  1 15:05:39 2001
+++ b/drivers/usb/devio.c	Thu Nov  1 15:05:39 2001
@@ -844,6 +844,14 @@
 		uurb.buffer_length = totlen;
 		break;
 
+	case USBDEVFS_URB_TYPE_INTERRUPT:
+		uurb.number_of_packets = 0;
+		if (uurb.buffer_length > 16384)
+			return -EINVAL;
+		if (!access_ok((uurb.endpoint & USB_DIR_IN) ? VERIFY_WRITE : VERIFY_READ, uurb.buffer, uurb.buffer_length))
+			return -EFAULT;   
+		break;
+
 	default:
 		return -EINVAL;
 	}

