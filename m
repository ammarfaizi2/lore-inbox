Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270495AbRH1JFK>; Tue, 28 Aug 2001 05:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270506AbRH1JFA>; Tue, 28 Aug 2001 05:05:00 -0400
Received: from gnu.in-berlin.de ([192.109.42.4]:2318 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S270495AbRH1JEt>;
	Tue, 28 Aug 2001 05:04:49 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: kraxel
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: v4l interface questions
Date: 28 Aug 2001 07:14:12 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrn9omh63.4as.kraxel@bytesex.org>
In-Reply-To: <20010827231126.A21664@bug.ucw.cz>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 998982852 4820 127.0.0.1 (28 Aug 2001 07:14:12 GMT)
User-Agent: slrn/0.9.7.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
>  Hi!
>  
>  I have few questions about v4l api.
>  
>  I have device (vicam == usb 3com homeconnect camera), which would like to
>  fit into v4l framework. But... mmap is not really native operation for
>  usb. Should I emulate it, or just return unsupported and expect
>  applications to use read()?

IHMO applications should be able to fallback to read() if mmap() doesn't
work.

>  Similar problem is there with formats. vicam has some really strange
>  formats. Should I do conversion in kernel?

Probably.  The driver should support at least one of the standard
VIDEO_PALETTE_* formats.  It is fine to pick one which comes close to
the native format of the camera, there is no need to support _all_
formats.

>  Is there some usermode program that can handle camera without mmap
>  ability and can support arbitrary screen sizes + 16bpp grayscale?

8bpp grayscale should be no problem with xawtv.  I'd suspect you will
not find any app which can deal with 16bpp, there isn't even a
VIDEO_PALETTE_* #define for this ...

  Gerd

-- 
Damn lot people confuse usability and eye-candy.
