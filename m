Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267450AbUH1QZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267450AbUH1QZT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 12:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267424AbUH1QWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 12:22:25 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:62437 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267416AbUH1QSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 12:18:36 -0400
Subject: Re: reverse engineering pwcx
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: rlrevell@joe-job.com, clemtaylor@comcast.net, qg@biodome.org,
       rogers@isi.edu
Content-Type: text/plain
Organization: 
Message-Id: <1093709838.434.6797.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 28 Aug 2004 12:17:19 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The LavaRnd guys examined the pixels on the actual
> CCD chip.  It's 160x120.  The 'decompression' is
> just interpolation.

First of all, it's not a CCD chip. It's CMOS.

Now, here's a Bayer pattern:

RG
GB
RGRGR
GBGBG
RGRGR
GBGBG

Don't put much faith in the 160x120 number. Suppose
that the chip is in a Bayer pattern, with 160x120
of those. Well, how many pixels is that? Who knows.
You'd sort of have 160x120, but with double the
green data. Since green carries most of the luminance
information, producing a larger image is reasonable.

Suppose the pattern is larger. The "Bayer" name in
the code may well be misleading. Each "pixel" that
was counted could be a 4x4 grid with 6 red subpixels,
8 green subpixels, and 2 blue subpixels. What's that?
You count 160x120, because it looks that way, but
it's 640x480 subpixels.

To correctly convert this to pixels while keeping the
maximum amount of image data, I think you need to
use the sinc() function. Problem is, you're getting
pre-mangled data from the camera. So it gets a bit
more complicated.

BTW, what are the legal problems? I didn't click to
agree on some EULA. I didn't sign an NDA. I don't
see how this could be considered a copy-control or
encryption system. Am I missing something? Maybe
this ought to be a 2-person project?

The code does look easy enough to take apart, even
using plain objdump. I think I'd be doing so now if
I had one of the cameras. (What nerd could resist?)
The decompiler is a much cooler option though.
By using both x86_64 and powerpc, recovery of data
types should improve.


