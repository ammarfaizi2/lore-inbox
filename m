Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316167AbSETRyk>; Mon, 20 May 2002 13:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316170AbSETRyj>; Mon, 20 May 2002 13:54:39 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:58386 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316167AbSETRyi>;
	Mon, 20 May 2002 13:54:38 -0400
Date: Mon, 20 May 2002 10:53:54 -0700
From: Greg KH <greg@kroah.com>
To: Will Newton <will@misconception.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.18 and VIA USB
Message-ID: <20020520175353.GB24443@kroah.com>
In-Reply-To: <E179T0J-0002gQ-00.2002-05-19-16-53-53@mail6.svr.pol.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 22 Apr 2002 16:30:09 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 19, 2002 at 04:56:19PM +0100, Will Newton wrote:
> 
> I have seen several posts in the archives that mention the following error on 
> VIA chipset (usually K7V Athlon boards):
> 
> hub.c: USB new device connect on bus1/2, assigned device number 7
> usb.c: USB device not accepting new address=7 (error=-110)
> hub.c: Cannot enable port 2 of hub 1, disabling port.
> hub.c: Maybe the USB cable is bad?

Which USB host controller driver are you using?
And are you sure your cable isn't bad?  :)

> If anyone could shed any light on this or recommend a test to find out more I 
> would be very grateful. It may or may not be related to my other USB problem.
> 
> I am seeing this error on attempting a bulk transfer to a USB camera:
> 
> usbdevfs: USBDEVFS_BULK failed dev 8 ep 0x81 len 4096 ret -110

Are you using usbdevfs/libusb to send data to this camera (like gphoto
does?)

> The thing that strikes me about this is that the endpoint in question is 
> specified thus:
> 
> 			Endpoint Address: 81
> 			Direction: in
> 			Attribute: 2
> 			Type: Bulk
> 			Max Packet Size: 64
> 			Interval:   0ms
> 
> Max packet size of 64 would seem to indicate that packets of too large a size 
> are being sent to the endpoint. Is this a correct analysis?

No, it's ok to send larger packet sizes to endpoints, the USB host
controller driver divides up the packet into smaller pieces for the
device, based on the endpoint size.

> Any help with either of these problems would be much appreciated. Please CC 
> any replies. Thanks.

Can you check out the 2.4.19-pre kernel tree right now?  Lots of good
USB host controller cleanups have happened in there that might help you
out.

thanks,

greg k-h
