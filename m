Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290727AbSAYQxN>; Fri, 25 Jan 2002 11:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290726AbSAYQxA>; Fri, 25 Jan 2002 11:53:00 -0500
Received: from dpc6682034030.direcpc.com ([66.82.34.30]:260 "EHLO
	oscar.hatestheinter.net") by vger.kernel.org with ESMTP
	id <S290725AbSAYQw2>; Fri, 25 Jan 2002 11:52:28 -0500
Subject: Re: [right one][patch] amd athlon cooling on kt266/266a chipset
From: Disconnect <lkml@sigkill.net>
To: Daniel Nofftz <nofftz@castor.uni-trier.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1011899975.2029.9.camel@oscar>
In-Reply-To: <Pine.LNX.4.40.0201221817410.11025-200000@infcip10.uni-trier.de> 
	<1011899975.2029.9.camel@oscar>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 25 Jan 2002 11:49:07 -0500
Message-Id: <1011977347.1788.5.camel@oscar>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On suggestions from a few people, I tried underclocking the system to
1200 mhz (x12 instead of x13) and most of the problems went away.

The jagged lines on xawtv are present only during "fast motion" although
there is some fuzz on all motion, its watchable (akin to slightly bad
reception.)

The usb keyboard problems went away (that could relate to other things
I've been messing with - X seems happier w/ 2 usb keyboards than with
just 1 for some reason.)

Testing sound and such, no skips or other issues from xmms, even when
top reports 70-80% idle.

CPU states:  22.2% user,  10.9% system,  24.7% nice,  42.2% idle
CPU Temp: +35.8 C     (limit = +51 C,  hysteresis = +49 C) 

So I'm about 10C lower than before. Yay :)

Any way to selectively enable/disable this from userspace? (Such that,
eg, when I'm not watching tv I can enable, when I fire up xawtv and/or
high-load apps I can disable..)  

Maybe (eventually) base it off load average..? (So load >.8 its
disabled, below that its selectively enabled - daemon to handle it could
be taught to check process lists, etc..)


On Thu, 2002-01-24 at 14:19, Disconnect wrote:
> I just finished testing the patch, and it shows huge temperature savings
> (10 to 15C when idle).  The problem is, it screws up v4l (bttv), usb
> keyboard under X becomes effectively unusable, etc.
> 
> V4l - using xinerama, xvideo, v4l under X4.1.0.1 - the picture gets
> jagged lines through it (offset scanlines maybe?) and tends to be jumpy.
> 
> usb keyboard - its slightly bad under X anyway (sticky keys, modifiers,
> etc) but with this patch I had to log in from another system just to
> shut down - even ctrl-alt-delete wouldn't work. In about 15 mins of
> arguing with it I probably got 20 keystrokes into the xserver. (mouse
> continued to work fine however.)
> 
> Seems like a great idea, if these problems can be solved. I'd love to
> get my cpu back down to 30C on a regular basis ;)
> 
> (Currently running the same kernel w/o amd_disconnect=yes and it isn't
> showing any problems at all.)
> 
> Motherboard is an Iwill kk266 (kt133) w/ a 1.2G tbird, 512M ram, 2
> aic7xxx (one pcb w/ pci bridge)
> Primary video: nvidia geforce2 mx (yah yah but it works ;) ..)
> Second/Third video: matrox mga g100 (4port card, 2 ports in use)
> 
> Also, I noticed an odd problem w/ ACPI. dmesg shows:
> ACPI: Power Button (FF) found
> ACPI: Multiple power buttons detected, ignoring fixed-feature
> ACPI: Power Button (CM) found
> ..and:
>  ls -l /proc/acpi/button/
> total 0
> dr-xr-xr-x    2 root     root            0 Jan 24 14:19 power/
> dr-xr-xr-x    2 root     root            0 Jan 24 14:19 power/
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



