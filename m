Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271251AbUJVMWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271251AbUJVMWa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 08:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271263AbUJVMW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 08:22:29 -0400
Received: from vsmtp2alice.tin.it ([212.216.176.142]:54480 "EHLO vsmtp2.tin.it")
	by vger.kernel.org with ESMTP id S271251AbUJVMVv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 08:21:51 -0400
Date: Fri, 22 Oct 2004 14:30:36 +0200
From: Luca Risolia <luca.risolia@studio.unibo.it>
To: Luc Saillard <luc@saillard.org>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, akpm@osdl.org
Subject: Re: Linux 2.6.9-ac3
Message-Id: <20041022143036.462742ca.luca.risolia@studio.unibo.it>
In-Reply-To: <20041022092102.GA16963@sd291.sivit.org>
References: <20041022101335.6dcf247a.luca.risolia@studio.unibo.it>
	<20041022092102.GA16963@sd291.sivit.org>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2004 11:21:02 +0200
Luc Saillard <luc@saillard.org> wrote:

> On Fri, Oct 22, 2004 at 10:13:35AM +0200, Luca Risolia wrote:
> > > o       Restore PWC driver                              (Luc Saillard)
> > 
> > This driver does decompression in kernel space, which is not
> > allowed. That part has to be removed from the driver before
> > asking for the inclusion in the mainline kernel.
> 
> I know this problem, but without a user API like ALSA, each driver need to
> implement the decompression module. When the driver will support v4l2, we can
> return the compressed stream to the user land. I want a v4l3, which is
> designed as ALSA does for soundcard, with a API for userland and kernelland.
> In the meantime, i can put a module option, if the user want the
> decompression in the kernel mode.

Either port the driver to V4L2, which handles decompression stuff well,
or provide a separate downloadble GPL'ed module. Other drivers in the
mainline kernel observe this rule; the pwc case is not an exception.
Also, this matter has been already discussed many times in the v4l
mailing list: no video decompression at all in kernel space, even if
*optional* through an *indipendent* module. I doubt Morton or Linus will
ever accept this version of pwc driver, since they did accept a patch disabling
colorspace conversion from a driver recently.

> Just for your information, many other part in the kernel use
> decompression/compression like PPP, video, ... Have you look about the
> algorithm use in decompression ?, it's just a lookup table with some
> pre-calculated values. Ok you lost ~60Kbytes of kernel memory. I you look into
> the logitech windows drivers, you will a see a big fat library name openvc
> (apt-cache search opencv). I don't want to include all operations but if we
> haven't a good userland library, our webcam is useless on Linux. 
> Please, if you can provide some help to put this in userland (provides
> patches for mplayer, xawtv, kame, gnomeeting, ...), i'll be glad to remove
> the offending code.

It sounds logic that none would help to fix user applications, if
we kept including things like decompression in each module in the kernel.

If it ever happens that this driver is accepted, be also prepared to
accept patches adding decompression and colorspace conversions for
every video driver I am aware of, starting from the ones I have already
written to the ones I'll submit in the future.

Regards,
	Luca Risolia

> 
> Luc
> 
> opencv:
>  The Open Computer Vision Library is a collection of algorithms and sample
>  code for various computer vision problems. The library is compatible with
>  IPL (Intel's Image Processing Library) and, if available, can use IPP
>  (Intel's Integrated Performance Primitives) for better performance.
>  .
>  OpenCV provides low level portable data types and operators, and a set
>  of high level functionalities for video acquisition, image processing and
>  analysis, structural analysis, motion analysis and object tracking, object
>  recognition, camera calibration and 3D reconstruction.
> (taken from apt-cache show libopencv-doc)
> 
