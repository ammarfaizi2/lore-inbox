Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268541AbUJVN6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268541AbUJVN6r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 09:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267259AbUJVN6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 09:58:46 -0400
Received: from vsmtp2alice.tin.it ([212.216.176.142]:26357 "EHLO vsmtp2.tin.it")
	by vger.kernel.org with ESMTP id S269696AbUJVN6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 09:58:12 -0400
Date: Fri, 22 Oct 2004 16:07:03 +0200
From: Luca Risolia <luca.risolia@studio.unibo.it>
To: Luc Saillard <luc@saillard.org>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, akpm@osdl.org
Subject: Re: Linux 2.6.9-ac3
Message-Id: <20041022160703.1ca025f4.luca.risolia@studio.unibo.it>
In-Reply-To: <20041022131639.GC16963@sd291.sivit.org>
References: <20041022101335.6dcf247a.luca.risolia@studio.unibo.it>
	<20041022092102.GA16963@sd291.sivit.org>
	<20041022143036.462742ca.luca.risolia@studio.unibo.it>
	<20041022131639.GC16963@sd291.sivit.org>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2004 15:16:39 +0200
Luc Saillard <luc@saillard.org> wrote:

> On Fri, Oct 22, 2004 at 02:30:36PM +0200, Luca Risolia wrote:
> > Either port the driver to V4L2, which handles decompression stuff well,

> no, it only provide a number (that needs to be reserved) to the user API, but
> if the user API doesn't exist, application will not support your camera. I
> can provide a .c and .h for the decompression module, but since the
> decompression table depend of the resolution,quality choose by the webcam
> (thinks as quality fine,normal,low). I can't provide with v4l2 a generic
> control for this.

Modify the V4L2 API by adding the correct generic interface.

> > or provide a separate downloadble GPL'ed module. Other drivers in the
> > mainline kernel observe this rule; the pwc case is not an exception.

> The driver, in it's current status, is GPL. Can you give me some examples
> about "other drivers" ?

At least two: w9968cf, ov511.

> > Also, this matter has been already discussed many times in the v4l
> > mailing list: no video decompression at all in kernel space, even if
> > *optional* through an *indipendent* module.

> It's easy for you to say that, because your driver returns a native format.
> Since nobody cares about webcam, and stream compressed, if today, i remove
> the table in the module, i'll wait one year ? two years for app that support
> my webcam ?

No, it's not easy for me to say that: the w9968cf driver is not really usefull
without the optional module available *outside* the kernel, since native UYVY
is not supported in userland at all. Furthermore, having had a separate module
for these things, is one more reason why none never patched any of the existing
applications.

Another example: sometime ago I had to patch the V4L2 API to add Bayer format
support to V4L2. This saved me from implementing colorspace conversion in the
sn9c102 driver. The patch was *one line* long and one of its results is that
now someone is working on gnomemeeting/pwlib to implement Bayer-to-* color
conversions that will make thousands of webcams work on Linux with this
application.

Regards,
	Luca Risolia
