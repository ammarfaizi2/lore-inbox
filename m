Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316868AbSE1R4i>; Tue, 28 May 2002 13:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316871AbSE1R4h>; Tue, 28 May 2002 13:56:37 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:4626 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316868AbSE1R4f>;
	Tue, 28 May 2002 13:56:35 -0400
Date: Tue, 28 May 2002 10:55:23 -0700
From: Greg KH <greg@kroah.com>
To: d_vangreg <d.vangreg@inwind.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: COMPILATION-BUGS_KERNEL-2.5.18
Message-ID: <20020528175523.GG11993@kroah.com>
In-Reply-To: <20020527142306Z316627-22651+61956@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Tue, 30 Apr 2002 16:43:25 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2002 at 04:32:42PM +0200, d_vangreg wrote:
> #################
> 
> COMPILATION-BUG-3 encountered while executing:  'make modules'
> ........................
> /opt/gcc304a/bin/gcc -D__KERNEL__ -I/usr/src/linux-2.5.18/include -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
> -march=athlon  -DMODULE -DMODVERSIONS -include 
> /usr/src/linux-2.5.18/include/linux/modversions.h   
> -DKBUILD_BASENAME=usbvideo -DEXPORT_SYMTAB -c -o usbvideo.o usbvideo.c
> usbvideo.c: In function `usbvideo_StartDataPump':
> usbvideo.c:1906: structure has no member named `next'
> usbvideo.c:1908: structure has no member named `next'
> make[3]: *** [usbvideo.o] Error 1
> make[3]: Leaving directory `/usr/src/linux-2.5.18/drivers/usb/media'
> make[2]: *** [_modsubdir_media] Error 2
> make[2]: Leaving directory `/usr/src/linux-2.5.18/drivers/usb'
> make[1]: *** [_modsubdir_usb] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.5.18/drivers'
> make: *** [_mod_drivers] Error 2
> 
> 
> PROPOSED-SOLUTION-3:
> replacing string  '->next'  with string  '->urb_list.next' 
> in file:  linux/drivers/usb/media/usbvideo.c    lines: 1906, 1908

Eeek, NO!
The ->next field is now gone.  The driver needs to be changed due to
this core USB change.  See the cpia and audio USB drivers for how to do
this properly.

thanks,

greg k-h
