Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262243AbVHAQZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262243AbVHAQZl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 12:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbVHAQYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 12:24:22 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:12444 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S262246AbVHAQSh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 12:18:37 -0400
Message-ID: <42EE4B4A.80602@andrew.cmu.edu>
Date: Mon, 01 Aug 2005 12:18:18 -0400
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Weinehall <tao@acc.umu.se>
CC: Lee Revell <rlrevell@joe-job.com>, Pavel Machek <pavel@ucw.cz>,
       Marc Ballarin <Ballarin.Marc@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
References: <20050730120645.77a33a34.Ballarin.Marc@gmx.de> <1122746718.14769.4.camel@mindpipe> <20050730195116.GB9188@elf.ucw.cz> <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz> <42ED32D3.9070208@andrew.cmu.edu> <20050731211020.GB27433@elf.ucw.cz> <42ED4CCF.6020803@andrew.cmu.edu> <20050731224752.GC27580@elf.ucw.cz> <1122852234.13000.27.camel@mindpipe> <20050801074447.GJ9841@khan.acc.umu.se>
In-Reply-To: <20050801074447.GJ9841@khan.acc.umu.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall wrote:
> On Sun, Jul 31, 2005 at 07:23:54PM -0400, Lee Revell wrote:
>>Any idea what their official recommendation for people running apps that
>>require the 1ms sleep resolution is?  Something along the lines of "Get
>>bent"?
> 
> Calm down.

Yes, Lee needs to chill a bit.  I'll hopefully explain our position 
calmly enough below.

> Any argument along the lines of the change of a default
> value in the defconfig screwing people over equally applies the other
> way around; by not changing the defconfig, you're screwing laptop users
> (and others that want less power consumption) over.  The world is not
> black and white, it's a very boring gray (or a very sadening bloody
> red; but I hope we won't come to that point just because of a silly
> argument on lkml...)

The tradeoff is a realistic 4.4% power savings vs a 300% increase in the 
minimum sleep period.  A user will see zero power savings if they have a 
USB mouse (probably 99% of desktops).  On top of that, we can throw in 
Con's disturbing AV benchmark results (1).  As a result, some of us 
don't think 250HZ is a great tradeoff to make _for_the_default_value_.

(1) http://article.gmane.org/gmane.linux.kernel/319124/

> In the end, Linus will decide this anyway.  I can understand that you
> don't want to change your application.  Help developing the dynamic
> tick patch, and maybe you won't have to =)

 From what I can tell, tick skipping works fine right now, it just needs 
some cleanup.  Thus I'd expect something like it will get integrated 
into 2.6.14.  If it gets in, the default HZ should go back up to 1000. 
In that case why decrease it for exactly one patchlevel?

As an app programmer, it'd be nice not to have to support 2.6.13 
differently from 2.6.(x!=13).  For my app, busy waiting means a ~12% 
load increase for 2.6.13 compared to (probably) all other 2.6 kernel 
versions.  That's certainly violating the principle of least surprise. 
Up to now, it was easy enough to tell people "upgrade from 2.4.x and 
it'll work better".  Now it gets more complicated.

Finally, as a conspiracy theorist, I wonder if Linus is just playing us 
to get more people working on the tick skipping and highres timer 
patches.  Someone with the ability to herd cats obviously has to be 
sneaky.  As an impressive demonstration of my free will I'm going to go 
test dyntick on my VIA Epia board...

  - Jim Bruce
