Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282246AbRKWV0n>; Fri, 23 Nov 2001 16:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282248AbRKWV0d>; Fri, 23 Nov 2001 16:26:33 -0500
Received: from law2-oe45.hotmail.com ([216.32.180.43]:45578 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S282247AbRKWV0Z> convert rfc822-to-8bit;
	Fri, 23 Nov 2001 16:26:25 -0500
X-Originating-IP: [62.98.83.69]
From: "Marco Berizzi" <pupilla@hotmail.com>
To: "Jens Axboe" <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Panic: too few segs for DMA mapping increase AHC_NSEG
Date: Fri, 23 Nov 2001 22:26:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Message-ID: <LAW2-OE45gFrYILoygX00001ee6@hotmail.com>
X-OriginalArrivalTime: 23 Nov 2001 21:26:20.0175 (UTC) FILETIME=[7E4059F0:01C17465]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Always me.
Just tried with a fresh 2.4.15 kernel: same behaviour.
I get a little different message when the hi mem enabled kernel bombs:

Kernel Panic: too few segs for DMA mapping increase AHC_NSEG
Kernel Panic: too few segs for DMA mapping increase AHC_NSEG
Kernel Panic: too few segs for DMA mapping increase AHC_NSEG
In interrupt handler - not syncing

And the system freeze completely.

PS: I tried to mount an ISO (with joilet ext) cdrom and copy some file (the tarball kernel) and the system was fine (iso/joylet filesystem driver was built in the kernel).
It seems to panic only with vfat filesystem. I remember you that I build vfat driver as a kernel module, then I load it with 'modprobe vfat'.


----- Original Message ----- 
From: "Marco Berizzi" <pupilla@hotmail.com>
To: "Jens Axboe" <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Sent: Wednesday, November 21, 2001 8:46 AM
Subject: Re: Kernel Panic: too few segs for DMA mapping increase AHC_NSEG


> ...not good news.
> Same behaviour: without hi mem support all right. With hi mem support
> (4GB) I get this error on console, after a kernel dump:
> 
> SCSI1:0:0:0 attempt to queue an abort message
> SCSI1:0:0:0 command not found
> aic7xxx_abort returns 0x2002
> 
> Then the system freeze completely, so I press the reset button.
> At the startup INIT calls fsck and when the checking is at about 55% it
> displays this message:
> 
> SCSI1:A:0:0 locking max tag count at 128
> 
> then the following startup procedure goes well.
> I want to tell you that with this kernel (hi mem support enabled), all
> is working perfectly (I can compile a new working kernel, for example).
> X Window (4.1) plus kde is working well.
> Only when I mount a vfat filesystem type and then I try to copy a file
> to the root partition I get this error.
> Another point: I usually build only mass storage driver in the kernel
> (Adaptec AHA 39160 bios rev 3.10). I build as modules all other HW (nic,
> sound, USB), however only the SB PCI512 is loaded in this situation. I
> haven't any IDE device just one SCSI HD (IBM DDYS-T18350N firmware rev
> S93E) and one Plextor SCSI cdrom (UltraPlex 40max PX-40TS firmware
> revision 1.04).
> 
> ----- Original Message -----
> From: "Jens Axboe" <axboe@suse.de>
> To: "Marco Berizzi" <pupilla@hotmail.com>
> Cc: <linux-kernel@vger.kernel.org>
> Sent: Monday, November 19, 2001 10:44 AM
> Subject: Re: Kernel Panic: too few segs for DMA mapping increase
> AHC_NSEG
> 
> 
> > On Mon, Nov 19 2001, Marco Berizzi wrote:
> > > Hi everybody.
> > >
> > > I have just upgraded my PC from 768MB RAM to 1GB.
> > > I have recompiled the kernel (2.4.14) for hi mem support (4GB).
> > >
> > > Now it's appening a very strange behaviour.
> > > I have several file system on the same disk (vfat file system). I
> have
> > > compiled vfat driver as a module. So before try to mount I must
> issue a
> > > 'modprobe vfat'. I'm using Slackware 8.0. modutils version is 2.4.6
> > >
> > > Then if I try to copy a file from that filesystem to the root
> filesystem
> > > I get this error:
> > >
> > > Kernel panic: too few segs for DMA mappings increase AHC_NSEG
> >
> > Aha! Finally someone that can provoke this easily. Could you please
> > apply attached patch and reproduce? Thanks.
> >
> > --
> > Jens Axboe
> >
> >
> 
