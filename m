Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274796AbRIUTpS>; Fri, 21 Sep 2001 15:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274797AbRIUTpJ>; Fri, 21 Sep 2001 15:45:09 -0400
Received: from f196.law8.hotmail.com ([216.33.241.196]:33540 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S274796AbRIUTo7>;
	Fri, 21 Sep 2001 15:44:59 -0400
X-Originating-IP: [12.13.238.140]
Reply-To: ddade@digitalstatecraft.com
From: "Donald Dade" <don_dade@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Questions about task, thread, and tss _struct
Date: Fri, 21 Sep 2001 12:45:17 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F196i6i9J1Mm3xFKGqv00002af1@hotmail.com>
X-OriginalArrivalTime: 21 Sep 2001 19:45:17.0795 (UTC) FILETIME=[F0C45330:01C142D5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a few points of confusion, and I would deeply appreciate any 
clarifications. They concern the three primary structures task_struct, 
thread_struct, and tss_struct. (in kernel 2.4.x)

1) I am having a difficult time understanding how tss_struct could be moved 
out of task_struct (per process basis, as one would expect) to a statically 
allocated array (per CPU basis, ???). How can these registers be saved 
across context switches, when there are only as many such structures as 
there are CPUs? I did not follow the explanation in UTLK.

2) Why the multiple stack pointers and stack segments in tss_struct?

3) What is esp0 in thread_struct?

4) What are the members suffixed with 'h' in tss_struct? I thought they were 
the segment shadow registers until I saw the member __ldth, because I didn't 
believe that ldt had a shadow register.

5) Is there a particular reason for the double underscore convention 
prefixing certain members?

Thank you so much for the clarifications that I've received in the past, and 
no doubt this one also,

Don Dade

>From: Vojtech Pavlik <vojtech@suse.cz>
>To: Greg Ward <gward@python.net>
>CC: bugs@linux-ide.org, linux-kernel@vger.kernel.org
>Subject: Re: "hde: timeout waiting for DMA": message gone, same behaviour
>Date: Fri, 21 Sep 2001 20:53:56 +0200
>
>On Fri, Sep 21, 2001 at 01:44:02PM -0400, Greg Ward wrote:
> > Having problems with an ATA/100 drive under Linux 2.4.{2,9}.
> >
> > drive: Seagate Barracuda IV 80 GB (ST380021A)
> > motherboard: ASUS A7V (VIA Apollo KT133 chipset)
> > ide0, ide1: VIA VT82C686A
> > ide2, ide3: Promise PDC20265 (these are the ATA/100 interfaces)
> >   (all four IDE interfaces are right on the motherboard)
> >
> > I have tried connecting the drive to both ide0 and ide2, with both a
> > 40-conductor and 80-conductor cable.
> >
> > Under 2.4.2, there was a very lengthy delay at boot time with this
> > output:
> >   Partition check:
> >    hda:hda: timeout waiting for DMA
> >   ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> >   hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
> >   [...repeat 2 times...]
> >   hda: DMA disabled
> >   ide0: reset: success
> >    hda1
> >
> > Eventually the system booted, but the drive was really slow (no DMA).
> > When I forced DMA on ("hdparm -d1 /dev/hda"), I got the same lengthy
> > sequence of output as I had at boot time, and eventually the kernel
> > turned DMA off again.
> >
> > So far nothing new -- from the linux-kernel archive, I'm not the first
> > person to report this problem in early 2.4 kernels.
> >
> > Under 2.4.9, the boot-time delay is not quite as long, but it's still
> > there.  And it's not nearly as noisy.  However, the end-result is the
> > same: DMA is disabled for this drive; it's a lot slower than an ATA/100
> > drive ought to be; if I force DMA back on, the first access to the drive
> > has another looong delay that results in the kernel turning DMA back
> > off.  Grumble.
> >
> > This is a brand-new drive and brand-new cable.  The motherboard's only
> > about 9 months old.
> >
> > So: is this in fact a kernel problem? or is it more likely to be a cable
> > problem, a motherboard problem, or a hard drive problem?
>
>Do you have the VIA IDE support enabled?
>
>--
>Vojtech Pavlik
>SuSE Labs
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/


_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

