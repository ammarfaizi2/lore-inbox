Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130374AbQJ0VAw>; Fri, 27 Oct 2000 17:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130383AbQJ0VAm>; Fri, 27 Oct 2000 17:00:42 -0400
Received: from ganymede.or.intel.com ([134.134.248.3]:64526 "EHLO
	ganymede.or.intel.com") by vger.kernel.org with ESMTP
	id <S130374AbQJ0VAf>; Fri, 27 Oct 2000 17:00:35 -0400
Message-ID: <39F9EE33.B65ABE71@intel.com>
Date: Fri, 27 Oct 2000 14:05:55 -0700
From: Randy Dunlap <randy.dunlap@intel.com>
X-Mailer: Mozilla 4.51 [en] (X11; I; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Gerald.Haese@gmx.de
CC: linux-kernel@vger.kernel.org, blc@q.dyndns.org
Subject: Re: USB Printer, in 2.4.0-test9
In-Reply-To: <2915.972470910@www33.gmx.net>
Content-Type: multipart/mixed;
 boundary="------------C04ECA6FCC3BFED511B6F2AE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C04ECA6FCC3BFED511B6F2AE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Gerald, Benson-

USB in 2.4.0-test9 had several broken pieces in it.
Something like 2.4.0-test10-pre6 is much better IMO.
However, the USB printer driver in test10-pre6 still
needs the attached patch (already sent to Linus).

Please try test10-pre6 with this patch and let me know how it is.

Thanks,
~Randy


Gerald.Haese@gmx.de wrote:
> 
> In article
>  <linux.kernel.Pine.LNX.4.21.0010232241360.7434-100000@q.dyndns.org>,
> Benson Chow <blc@q.dyndns.org> wrote:
> 
> > I get a bunch of form feeds too but it continues to print a few
> > characters fine and some that are totally wrong.
> 
> The same problem here. I'am using a dual Pentium (GA586-DX) with 2 x 233
> MHz PentiumMMX and a PCI USB controller card with a VIA Chip. The
> printer is
> a DeskJet 970Cxi. Printing via USB is completely impossible.
> 
>  Gerald
--------------C04ECA6FCC3BFED511B6F2AE
Content-Type: text/plain; charset=us-ascii;
 name="printer_c_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="printer_c_patch"

--- linux/drivers/usb/printer.c.org	Thu Oct 26 17:36:50 2000
+++ linux/drivers/usb/printer.c	Thu Oct 26 17:09:53 2000
@@ -190,6 +190,8 @@
 		retval = retval > 1 ? -EIO : -ENOSPC;
 		goto out;
 	}
+#else
+	retval = 0;	
 #endif
 
 	usblp->used = 1;
@@ -383,6 +385,7 @@
 		return -EFAULT;
 
 	if ((usblp->readcount += count) == usblp->readurb.actual_length) {
+		usblp->readcount = 0;
 		usblp->readurb.dev = usblp->dev;
 		usb_submit_urb(&usblp->readurb);
 	}

--------------C04ECA6FCC3BFED511B6F2AE--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
