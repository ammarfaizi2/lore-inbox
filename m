Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933457AbWKNW0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933457AbWKNW0U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 17:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933479AbWKNW0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 17:26:19 -0500
Received: from wx-out-0506.google.com ([66.249.82.231]:33144 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S933457AbWKNW0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 17:26:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X0b3TYyDSEy4wp1T8AiPoJImmPx5cvFQmyo092uGxA0uQ0R62CGkMByvaEjKrS3/ob3nm00R5M/zP6MZJEn81u47FIXcncO8rzF8ADOdspG45WIQENKuCA6hptSwZNIuzKmG8YvNKDc0NBN7sTd5vWy1WWP9xmwajuWhcMH7j50=
Message-ID: <653402b90611141426y6db15a3bh8ea59f89c8f1bb39@mail.gmail.com>
Date: Tue, 14 Nov 2006 23:26:17 +0100
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "James Simmons" <jsimmons@infradead.org>
Subject: Re: ACPI output/lcd/auxdisplay mess
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Linux Fbdev development list" 
	<linux-fbdev-devel@lists.sourceforge.net>,
       "Luming Yu" <Luming.yu@intel.com>, "Andrew Zabolotny" <zap@homelink.ru>,
       "Jamey Hicks" <jamey.hicks@hp.com>
In-Reply-To: <Pine.LNX.4.64.0611141939050.6957@pentafluge.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0611141939050.6957@pentafluge.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/06, James Simmons <jsimmons@infradead.org> wrote:
>
> I have noticed a bunch of patches coming in dealing with the same problem. How to handle displays
> i.e LCD, CRT etc. We have a lcd class in video/backlight which no one is using. Because no one was
> aware of it auxdisplay was created instead. Then we have the acpi code which wants a output class

Well, we were aware of video/backlight/* (read below). Anyway,
auxdisplay doesn't create a class; it did in first versions, but right
now it behaves just like a framebuffer, no classes in the playground
(maybe you read a old version?).

> to handle powering down the display device. Plus the acpi layer does something very similar to the
> framebuffer with getting edids and data relating to the display device. We really should place all
> this handling in one standard place. To do this I need to know what all of you require.
>

auxdisplay was discussed and created because lcd/backlight mean a primary LCD:

"Backlight & LCD device support"
	  Enable this to be able to choose the drivers for controlling the
	  backlight and the LCD panel on some platforms, for example on PDAs.

However, auxdisplay means "auxiliary display device drivers", not _the
display_. In such folder we can put every
auxiliar-optional-secundary-rare display (not just LCDs, framebuffers,
...) who has special requirements (like parport wiring, fixed refresh
rate, different properties...). Also, things like "set_contrast",
"max_constrast", "set_power"... didn't seem very appropriate.

There was a long discussion about this stuff and someone pointed out
the existence of video/backlight/*, so, well, we were aware of such
it. I think people prefered drivers/auxdisplay.

As people wish,

       Miguel Ojeda

-- 
Miguel Ojeda
http://maxextreme.googlepages.com/index.htm
