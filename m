Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268196AbUH1Gsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268196AbUH1Gsa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 02:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268206AbUH1Gsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 02:48:30 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:23008 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268196AbUH1Gs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 02:48:28 -0400
Message-ID: <41302A8D.1010903@comcast.net>
Date: Sat, 28 Aug 2004 02:47:41 -0400
From: Clem Taylor <clemtaylor@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040809
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: QuantumG <qg@biodome.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: reverse engineering pwcx
References: <412FD751.9070604@biodome.org>
In-Reply-To: <412FD751.9070604@biodome.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

QuantumG wrote:
> There is no secret algorithm or complex image processing in this
> code.  Having worked on reverse engineering a complex audio
> processing application (see our paper Using a Decompiler for
> Real-World Source Recovery, to appear WCRE 2004), I expected to see
> some serious floating point calculations or at least something
> recognisable as a FFT or some other known algorithm.

I think you need to look a little closer. This type of decompression is 
surely not going to be done with floating point (can you even do 
floating point ops in the kernel?).

This class of camera chip uses a greatly simplified JPEG like 
compression. The compression is a 4x4 DCT (JPEG uses a 8x8 DCT), a 
quantize step and some sort of simple VLC. The algorithm was chosen to 
be easy to implement in an absolutely minimal number of gates. At this 
point true JPEG encode hardware is enough of a commodity that it would 
be silly not to use JPEG in a new design.

I'm pretty sure this class of camera chip uses a 4x4 DCT and some sort 
of VLC. Most of the meat of the decoder would be table lookups to decode 
the symbols and then a small multiply accumulate loop to do the inverse 
DCT and another series of table lookups and multiplies to do the inverse 
quant. Pretty basic stuff at this point.

The white paper I read a while back on this chipset family had been out 
of NDA for a number of years, so I was never sure why the pwcx driver 
wasn't opened up. A competitor wouldn't gain much knowing the exact 
details of the decompression algorithm. If I was a competitor designing 
a new webcam chip, I wouldn't waste my time reverse engineering Philips 
compression scheme, I'd just use JPEG and be done with it.

Has anyone even asked Philips if they would be willing to open up the 
algorithm? Maybe they would have said NO a few years ago, but at this 
point does it matter?

                    --Clem
