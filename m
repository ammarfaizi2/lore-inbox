Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267891AbUH1VIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267891AbUH1VIW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 17:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266887AbUH1VIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 17:08:21 -0400
Received: from science.horizon.com ([192.35.100.1]:48439 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S267891AbUH1VHz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 17:07:55 -0400
Date: 28 Aug 2004 21:07:51 -0000
Message-ID: <20040828210751.24380.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org, linux-usb-devel@vger.kernel.org
Subject: Re: Summarizing the PWC driver questions/answers
Cc: paul@clubi.ie
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jakma wrote:
> http://linux.slashdot.org/comments.pl?sid=119578&cid=10089410
>
> From the LavaRND people. Apparently images produced with the binary 
> pcwx portion loaded (full-sized frame) had *less* entropy than the 
> smaller images produced without. Hence they speculate that the 
> function of the binary pcwx part is actually to interpolate the 
> 160x120 image to the bigger 640x480 size, and has little to do with 
> hardware..

Actually, it's probably *colour* interpolation.  Digital cameras are
based on fundamentally black-and-white image sensors, with a filter
grid superimposed.  (Search on "Bayer filter" for the most common RGGB
pattern.)  A "640x480" digital camera has 640x480 = 307200 sensor pixels,
divided among 3 (or sometimes 4) colours.

Note that this is unlike a "640x480" colour LCD, which will have 640x480x3
= 921600 active elements.  But it is the standard terminology for the field.

This gives some luminance/chrominance information at each pixel, but to
assign a 24-bit colour to each pixel requires some interpolation based on
adjacent picels.  Digital cameras do such interpolation internally, but
it's also popular to support a "raw" image format to an external program,
in the hope of better result.  See gPhoto for examples of such algorithms.

Anyway, I can imagine that the camera can do something crude internally
like downsampling by 2x2 to get colour values for each pixel.  I can also
imagine that it can export the raw image to a software driver for better
interpolation that would take more CPU horsepower than it has on board.

Now, the fact that colour is effectively encoded in the high-frequency
portion of the luminance signal makes it rather tricky to produce a
"sharp" colour image without introducing artifacts when a high-frequency
black & white signal is present.  The general techniques are published,
but digital camera makers put a lot of effort into the subtleties and are
generally very posessive of the details of their implementation.

This might be what's going on with Philips.

However, given that we already have access to lots of suitable Free
interpolating software, Linux doesn't need that.  It just needs to know
how to elicit a raw high-res frame from the camera and what the returned
bits mean.  The rest can be coped with.
