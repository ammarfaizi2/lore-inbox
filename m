Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030290AbVKPR6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290AbVKPR6r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 12:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030293AbVKPR6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 12:58:47 -0500
Received: from bay103-f17.bay103.hotmail.com ([65.54.174.27]:62239 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1030290AbVKPR6r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 12:58:47 -0500
Message-ID: <BAY103-F17B16A3E9D5B3E06ACB57CDF5C0@phx.gbl>
X-Originating-IP: [68.75.63.180]
X-Originating-Email: [dravet@hotmail.com]
From: "Jason Dravet" <dravet@hotmail.com>
To: samuel.thibault@ens-lyon.org
Cc: 7eggert@gmx.de, adaplas@gmail.com, torvalds@osdl.org, akpm@osdl.org,
       davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vgacon: Workaround for resize bug in some chipsets
Date: Wed, 16 Nov 2005 11:58:42 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 16 Nov 2005 17:58:42.0335 (UTC) FILETIME=[616D52F0:01C5EAD7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Samuel Thibault <samuel.thibault@ens-lyon.org>
>To: Jason Dravet <dravet@hotmail.com>
>CC: 7eggert@gmx.de, adaplas@gmail.com, torvalds@osdl.org, 
>akpm@osdl.org,davej@redhat.com, linux-kernel@vger.kernel.org
>Subject: Re: [PATCH] vgacon: Workaround for resize bug in some chipsets
>Date: Wed, 16 Nov 2005 03:25:08 +0100
>
>Hi,
>
>Jason Dravet, le Tue 15 Nov 2005 19:50:39 -0600, a écrit :
> > Here are the results:
> > y=25   fonth=16   deffh=16   vidfh=16   scanl=400
> > overflow=ff
> > vsync_end=8f
> > vdisp_end=1f
>
>Ah, this is odd indeed: your hardware uses 800 scanlines
>(overflow:(512+256)+vdisp_end:0x1f), while the actual needed lines
>should be y:25*fonth:16 ... Maybe it is actually using a 32 lines font.
>
>Just to make sure about every VGA bits, could you install the
>svgatextmode package, which holds a getVGAreg command, and run twice
>
>for i in `seq 0 24` ; do getVGAreg CRTC $i ; done
>
>The first time while having a correct full text screen rendering, and
>the second time after vgacon_doresize() has blanked the bottom half of
>the screen.
>
>Regards,
>Samuel

For some reason my custom 2.6.14 kernels no longer boot.  While I look into 
this here are the results when only half the screen works:

VGA 'CRTC' register, index 0 (=0x0) contains 89 (=0x59 =b01011001)
VGA 'CRTC' register, index 1 (=0x1) contains 79 (=0x4f =b01001111)
VGA 'CRTC' register, index 2 (=0x2) contains 79 (=0x4f =b01001111)
VGA 'CRTC' register, index 3 (=0x3) contains 157 (=0x9d =b10011101)
VGA 'CRTC' register, index 4 (=0x4) contains 84 (=0x54 =b01010100)
VGA 'CRTC' register, index 5 (=0x5) contains 27 (=0x1b =b00011011)
VGA 'CRTC' register, index 6 (=0x6) contains 255 (=0xff =b11111111)
VGA 'CRTC' register, index 7 (=0x7) contains 191 (=0xbf =b10111111)
VGA 'CRTC' register, index 8 (=0x8) contains 0 (=0x00 =b00000000)
VGA 'CRTC' register, index 9 (=0x9) contains 239 (=0xef =b11101111)
VGA 'CRTC' register, index 10 (=0xa) contains 13 (=0x0d =b00001101)
VGA 'CRTC' register, index 11 (=0xb) contains 14 (=0x0e =b00001110)
VGA 'CRTC' register, index 12 (=0xc) contains 40 (=0x28 =b00101000)
VGA 'CRTC' register, index 13 (=0xd) contains 240 (=0xf0 =b11110000)
VGA 'CRTC' register, index 14 (=0xe) contains 42 (=0x2a =b00101010)
VGA 'CRTC' register, index 15 (=0xf) contains 32 (=0x20 =b00100000)
VGA 'CRTC' register, index 16 (=0x10) contains 125 (=0x7d =b01111101)
VGA 'CRTC' register, index 17 (=0x11) contains 143 (=0x8f =b10001111)
VGA 'CRTC' register, index 18 (=0x12) contains 143 (=0x8f =b10001111)
VGA 'CRTC' register, index 19 (=0x13) contains 40 (=0x28 =b00101000)
VGA 'CRTC' register, index 20 (=0x14) contains 31 (=0x1f =b00011111)
VGA 'CRTC' register, index 21 (=0x15) contains 30 (=0x1e =b00011110)
VGA 'CRTC' register, index 22 (=0x16) contains 0 (=0x00 =b00000000)
VGA 'CRTC' register, index 23 (=0x17) contains 163 (=0xa3 =b10100011)
VGA 'CRTC' register, index 24 (=0x18) contains 255 (=0xff =b11111111)

I will send the whole screen results when I find and fix the problem.  I am 
running the fedora core development system with all but todays updates.

Thanks,
Jason


