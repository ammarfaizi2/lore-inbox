Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270948AbUJVJ0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270948AbUJVJ0F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 05:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270938AbUJVJWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 05:22:49 -0400
Received: from sd291.sivit.org ([194.146.225.122]:4841 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S270915AbUJVJVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 05:21:03 -0400
Date: Fri, 22 Oct 2004 11:21:02 +0200
From: Luc Saillard <luc@saillard.org>
To: Luca Risolia <luca.risolia@studio.unibo.it>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.6.9-ac3
Message-ID: <20041022092102.GA16963@sd291.sivit.org>
References: <20041022101335.6dcf247a.luca.risolia@studio.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022101335.6dcf247a.luca.risolia@studio.unibo.it>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 10:13:35AM +0200, Luca Risolia wrote:
> > o       Restore PWC driver                              (Luc Saillard)
> 
> This driver does decompression in kernel space, which is not
> allowed. That part has to be removed from the driver before
> asking for the inclusion in the mainline kernel.

I know this problem, but without a user API like ALSA, each driver need to
implement the decompression module. When the driver will support v4l2, we can
return the compressed stream to the user land. I want a v4l3, which is
designed as ALSA does for soundcard, with a API for userland and kernelland.
In the meantime, i can put a module option, if the user want the
decompression in the kernel mode.

Just for your information, many other part in the kernel use
decompression/compression like PPP, video, ... Have you look about the
algorithm use in decompression ?, it's just a lookup table with some
pre-calculated values. Ok you lost ~60Kbytes of kernel memory. I you look into
the logitech windows drivers, you will a see a big fat library name openvc
(apt-cache search opencv). I don't want to include all operations but if we
haven't a good userland library, our webcam is useless on Linux. 
Please, if you can provide some help to put this in userland (provides
patches for mplayer, xawtv, kame, gnomeeting, ...), i'll be glad to remove
the offending code.

Luc

opencv:
 The Open Computer Vision Library is a collection of algorithms and sample
 code for various computer vision problems. The library is compatible with
 IPL (Intel's Image Processing Library) and, if available, can use IPP
 (Intel's Integrated Performance Primitives) for better performance.
 .
 OpenCV provides low level portable data types and operators, and a set
 of high level functionalities for video acquisition, image processing and
 analysis, structural analysis, motion analysis and object tracking, object
 recognition, camera calibration and 3D reconstruction.
(taken from apt-cache show libopencv-doc)
