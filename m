Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267483AbUH1SFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267483AbUH1SFq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 14:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267508AbUH1SFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 14:05:46 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:32647 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S267483AbUH1SFL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 14:05:11 -0400
Date: Sat, 28 Aug 2004 20:05:13 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Albert Cahalan <albert@users.sf.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       clemtaylor@comcast.net, qg@biodome.org, rogers@isi.edu
Subject: Re: reverse engineering pwcx
Message-ID: <20040828180511.GA3916@ucw.cz>
References: <1093709838.434.6797.camel@cube> <1093710358.8611.22.camel@krustophenia.net> <1093712176.431.6806.camel@cube> <1093713088.8611.30.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093713088.8611.30.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 01:11:28PM -0400, Lee Revell wrote:
> On Sat, 2004-08-28 at 12:56, Albert Cahalan wrote:
> > On Sat, 2004-08-28 at 12:25, Lee Revell wrote:
> > > On Sat, 2004-08-28 at 12:17, Albert Cahalan wrote:
> > >> [somebody]
> > 
> > > > > The LavaRnd guys examined the pixels on the actual
> > > > > CCD chip.  It's 160x120.  The 'decompression' is
> > > > > just interpolation.
> > > > 
> > > > Don't put much faith in the 160x120 number. Suppose
> > > > that the chip is in a Bayer pattern, with 160x120
> > > > of those. Well, how many pixels is that? Who knows.
> > > > You'd sort of have 160x120, but with double the
> > > > green data. Since green carries most of the luminance
> > > > information, producing a larger image is reasonable.
> > > 
> > > Right, as someone else pointed out, this is wrong.
> > > 
> > > How do you account for the Slashdot poster's assertion that it's
> > > physically impossible to cram 640 x 480 worth of data down a USB 1.1
> > > pipe?
> > 
> > 640x480 uncompressed 24-bit RGB? It doesn't matter.
> > 
> > The suggestion of a 4x4 JPEG-like transform seems
> > pretty reasonable. I'd like to see that whitepaper.
> > 
> 
> This still can't be called 'True 640 x 480' by any reasonable standard. 
> Philips' marketing claims exactly this.

If the sensor has 640x480 Bayer half-cells (640x480 green subpixels),
then that's considered as 'true 640x480' by the industry. Green
resolution is 640x480, red and blue resolution is 640x240. A full
640x480 RGB image can be reconstructed in good quality.

And that's what I believe the cameras have - it's damn cheap in CMOS
anyways.

Now about the compression - that'll only take place when streaming (and
the lossiness will depend on the selected frame rate). When taking still
images, you should get the full resolution.

That's at least how most USB 1.1 webcams work - I don't have personal
experience with Philips webcams.

> So far I have not seen any evididence to refute QuantumG's original
> assertion that the reason everyone in the know is being so tight-lipped 
> is that releasing source code would prove Philips and/or Logitech guilty
> of false advertising.

I don't think that's the reason. In the early days of webcams, the
compression method was what was differentiating the different webcam
brands.

When all have basically the same sensor, and the same USB 1.1 bandwidth,
the image quality is given by the compression. And designing a
compression algorithm so that it's both efficient and fits into only a
few logic gates (resulting in a cheap chip) is a challenge.

And the webcam companies were competing to deliver the cheapest webcam
with the best image quality. It's obvious they wanted to hide the
algorithm - copying it is rather easy.

Nowadays, there is no point in hiding it - with USB 2.0 allowing for
uncompressed video, with JPEG encoding chips being a commodity, that
competition point has disappeared.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
