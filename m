Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315725AbSENNso>; Tue, 14 May 2002 09:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315726AbSENNsn>; Tue, 14 May 2002 09:48:43 -0400
Received: from ns.fondoweb.net ([195.223.235.190]:45752 "EHLO ns.fondoweb.net")
	by vger.kernel.org with ESMTP id <S315725AbSENNsl>;
	Tue, 14 May 2002 09:48:41 -0400
Date: Tue, 14 May 2002 15:48:36 +0200
From: andrea gelmini <andrea.gelmini@linux.it>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-pre8 != bk -rv2.4.19-pre8
Message-ID: <20020514134836.GA8261@fondoweb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,
	'diff -r' between 2.4.19-pre8 downloaded from ftp.kernel.org and
	the same version extracted from bitkeeper (parent is
	bk://linux.bkbits.net/linux-2.4), produce the follow diff. it's
	not a big issue, but it's a little annoying to apply -ac
	patches.

thanks for your work,
andrea gelmini


diff -r linux/Documentation/video4linux/API.html bk2.4.18/Documentation/video4linux/API.html
108c108
< <TR><TD><b>clips</b><TD>A list of clipping rectangles. <em>(Set only)</em)</TD>
---
> <TR><TD><b>clips</b><TD>A list of clipping rectangles. <em>(Set only)</em></TD>
122a123
> (i.e. PCI-PCI transfer to the frame buffer of the video card)
313,315c314,317
< Each call to the <b>read</b> syscall returns the next available image from
< the device. It is up to the caller to set the format and then to pass a 
< suitable size buffer and length to the function. Not all devices will support
---
> Each call to the <b>read</b> syscall returns the next available image
> from the device. It is up to the caller to set format and size (using
> the VIDIOCSPICT and VIDIOCSWIN ioctls) and then to pass a suitable
> size buffer and length to the function. Not all devices will support
332,341c334,366
< Once the mmap has been made the VIDIOCMCAPTURE ioctl sets the image size
< you wish to use (which should match or be below the initial query size).
< Having done so it will begin capturing to the memory mapped buffer. Whenever
< a buffer is "used" by the program it should called VIDIOCSYNC to free this
< frame up and continue. <em>to add:</em>VIDIOCSYNC takes the frame number
< you are freeing as its argument. When the buffer is unmapped or all the
< buffers are full capture ceases. While capturing to memory the driver will
< make a "best effort" attempt to capture to screen as well if requested. This
< normally means all frames that "miss" memory mapped capture will go to the
< display.
---
> Once the mmap has been made the VIDIOCMCAPTURE ioctl starts the
> capture to a frame using the format and image size specified in the
> video_mmap (which should match or be below the initial query size).
> When the VIDIOCMCAPTURE ioctl returns the frame is <em>not</em>
> captured yet, the driver just instructed the hardware to start the
> capture.  The application has to use the VIDIOCSYNC ioctl to wait
> until the capture of a frame is finished.  VIDIOCSYNC takes the frame
> number you want to wait for as argument.
> <p>
> It is allowed to call VIDIOCMCAPTURE multiple times (with different
> frame numbers in video_mmap->frame of course) and thus have multiple
> outstanding capture requests.  A simple way do to double-buffering
> using this feature looks like this:
> <pre>
> /* setup everything */
> VIDIOCMCAPTURE(0)
> while (whatever) {
>    VIDIOCMCAPTURE(1)
>    VIDIOCSYNC(0)
>    /* process frame 0 while the hardware captures frame 1 */
>    VIDIOCMCAPTURE(0)
>    VIDIOCSYNC(1)
>    /* process frame 1 while the hardware captures frame 0 */
> }
> </pre>
> Note that you are <em>not</em> limited to only two frames.  The API
> allows up to 32 frames, the VIDIOCGMBUF ioctl returns the number of
> frames the driver granted.  Thus it is possible to build deeper queues
> to avoid loosing frames on load peaks.
> <p>
> While capturing to memory the driver will make a "best effort" attempt
> to capture to screen as well if requested. This normally means all
> frames that "miss" memory mapped capture will go to the display.
Only in linux/arch/mips: .gdbinit
Only in bk2.4.18/drivers/net/wan/8253x: build
Only in linux/drivers/sound: .indent.pro
Only in linux/drivers/sound: .version
