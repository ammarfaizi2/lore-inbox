Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbVHaBPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbVHaBPI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 21:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbVHaBPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 21:15:08 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:58118 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932313AbVHaBPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 21:15:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ZC5AFiG07y2fQPSWph75R+FRpNP8sqODxLbN/IsiNDCg0AgelztuXucU6PKTti96rE2LfQJT52RJA4YotqL2Oh2oMqNu3+MyY9YQ7Jg+QX4MpJGfwQjiUj2Gl/RcCJvRE9AQyk40AoNi2c6YEW9eTYr0FGfpC+JuOg4YscdGu2U=
Message-ID: <4315047A.4040907@gmail.com>
Date: Wed, 31 Aug 2005 09:14:34 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Knut Petersen <Knut_Petersen@t-online.de>
CC: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Jochen Hein <jochen@jochen.org>
Subject: Re: [PATCH 1/1 2.6.13] framebuffer: bit_putcs() optimization for
 8x* fonts
References: <43148610.70406@t-online.de>
In-Reply-To: <43148610.70406@t-online.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Knut Petersen wrote:
> This trivial patch gives a performance boost to the framebuffer console
> 
> Constructing the bitmaps that are given to the bitblit functions of the
> framebuffer
> drivers is time consuming. Here we avoide a call to the slow
> fb_pad_aligned_buffer().
> The patch replaces that call with a simple but much more efficient
> bytewise copy.
> 
> The kernel spends a significant time at this place if you use 8x* fonts.
> Every
> pixel displayed on your screen is prepared here.
> 
> Some benchmark results:
> 
> Displaying a file of 2000 lines with 160 characters each takes 889 ms
> system
> time using  cyblafb on my system  (I´m using a 1280x1024 video mode,
> resulting in a 160x64 character console)
> 
> Displaying the same file with the enclosed patch applied to 2.6.13 only
> takes
> 760 ms system time, saving 129 ms or 14.5%.

Where did this 14.5% come from?  Is it bit_putcs alone or is more
real world, such as 'time cat text_file'? If I'm to guess, a large
percent of the improvement is caused by the inlining of the code.

I'm not against the patch, it will benefit drivers with very fast
imageblits.  However, since most drivers have imageblits done in software,
a large proportion of the processing time will go to the imageblit itself,
so I don't think you'll get that high a number (I get only a 4%
improvement, and this is in a driver with accelerated blits, and it will
probably be lower, ie, in vesafb).

Anyway, with the addition of your patch, bit_putcs has now reached an
'ugliness threshhold' for a revamp.

Tony
