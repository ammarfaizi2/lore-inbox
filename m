Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbVLSPrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbVLSPrA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 10:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbVLSPrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 10:47:00 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:28633 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964782AbVLSPq7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 10:46:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CSFQemb/iYbsZDxK9uT8/xLIuvunePt4i4oEPZP2xPqq5n/gzH0PnWk4LO+lQIqIMgxe1qxsHqE1dvq7/XZvncP8quCvi+Z3Zr9ydkRt4UcTaL9aX5Ma3gZXs1eh3OhXbVuF5Dap1Ve+LXC7w68r2Sn8oW7HauCBWdFomXBIzPk=
Message-ID: <58cb370e0512190746w4d43814br6a5e92bcf793e711@mail.gmail.com>
Date: Mon, 19 Dec 2005 16:46:55 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Clemens Koller <clemens.koller@anagramm.de>
Subject: Re: IDE: PDC20275 turning on/off DMA dangerous?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43A6C780.5070000@anagramm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43A2DE5F.7060108@anagramm.de>
	 <58cb370e0512190440p3889a489sbc82f0c482fd9db9@mail.gmail.com>
	 <43A6C780.5070000@anagramm.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/05, Clemens Koller <clemens.koller@anagramm.de> wrote:
> Hello, Bartolmiej!
>
> >>I am working on an embedded ppc (mpc8540) using a pretty common Promise IDE
> >>PCI controller w/ a PDC20275 on it (it's called Ultra TX2).
> >>I have an otherwise good Maxtor 6B120P0 (160GB) connected to it.
> >>
> >>But sometimes (expecially with more than zero disk-i/o-load), when I
> >>turn on DMA by
> >>
> >>$hdparm -X69 -d1 /dev/hda
> >>I get
> >>
> >>hda: task_out_intr: status=0x58 { DriveReady SeekComplete DataRequest }
> >>ide: failed opcode was: unknown
> >>hda: CHECK for good STATUS
> >>
> >>And when I turn off DMA with
> >>$hdparm -d0 /dev/hda
> >>I get sometimes a
> >>
> >>hda: DMA disabled
> >>
> >>which is fine but sometimes I also get:
> >>
> >>hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> >>ide: failed opcode was: unknown
> >>hda: drive not ready for command
> >>hda: CHECK for good STATUS
> >>
> >>which is not so nice.
> >>Can you tell me if this is dangerous?
> >
> >
> > Is there any particular reason why you are using hdparm with '-d' and '-X'?
>
> I want to test it with DMA before fixing it into the kernel.
>
> > Your IDE host driver (pdc202xx_new in this case) should configure
> > best xfer mode and enable DMA so you shouldn't need to use hdparm.
>
> I didn't enable automatic turning on of DMA it in the kernel by default
> in the past because I had problems with this hdd controller and
> interrupts (some PCI IRQ mapping issues). The interrupt issues are
> solved now, so I've tried to enable DMA. DMA works pretty fine,
> I was just worried about the severity of the message. It doesn't
> really tell anything useful for non-ide-hackers. (whether it's
> dangerous or not.)
>
> > Given that IDE driver code for changing xfer mode and DMA setting
> > is racy and actually quite hard to fix, it will probably be removed in
> > the future (after auditing IDE host drivers).
>
> So, I guess the answer is: DMA itself seems to work and it
> isn't really dangerous - it's working as it's supposed to.

Yes.

> But if you do it the way you do, you can run into problems due
> to races. Right? So, if I enable DMA as usual in the kernel,
> I don't usually risk my data?!

Yes, just use default settings.

Thanks,
Bartlomiej
