Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130290AbRAWV5b>; Tue, 23 Jan 2001 16:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129983AbRAWV5V>; Tue, 23 Jan 2001 16:57:21 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:12298 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129811AbRAWV5E>;
	Tue, 23 Jan 2001 16:57:04 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: f5ibh <f5ibh@db0bm.ampr.org>
Date: Tue, 23 Jan 2001 22:54:06 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: display problem with matroxfb
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <136DEFAC3E11@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Jan 01 at 21:34, f5ibh wrote:
> 
> After booting and having the display shifted to the middle of the screen, I've

Stop. Do you see right portion of screen in left, left portion in right,
with black column in between, or is picture only shifted, without
wraparound? I thought that you see wrapped display...

> played a bit with fbset and the -left, -right, -move, -match options. After a
> while I got an 'acceptable' picture (some pixels missing on the left). At this
> point, fbset -s  give me the following :
> 
> mode "640x480-60"
>     # D: 25.176 MHz, H: 31.628 kHz, V: 60.243 Hz
>     geometry 640 480 640 480 8
>     timings 39721 50 10 32 11 96 2
>     accel true
>     rgba 8/0,8/0,8/0,0/0
> endmode

Are you sure that it is source of problem? Default matroxfb settings
for 640x480 is 'timmings 39721 48 16 33 10 96 2' - As horizontal position
is in multiple of 8, I cannot understand, how moving picture one column
(8 pixels) right(!) (and even worse - there is no rounding in code,
so you only changed right screen margin from 16 to 8 - this should
move picture even more to right side of screen) and one scanline up could 
make so drastical change...

> How can I pass the parameters at boot time ? 
> I've tried :
> video=matrox:vesa:0x301,pixclock:39721,left:50,right:10,upper:32,lower:11,hslen:96,vslen:2
> ... without any success...

After boot look at /proc/cmdline. If it is cutted at column 64 (or 79),
you have to upgrade your LILO. RedHat6.2 uses LILO with this dumb limitation.
Also, you do not have to specify vesa,pixclock,hslen and vslen, as you leave
them on defaults. So 'video=matrox:left:50,right:10,upper:32,lower:11'
should work... But I think that only 'right:' really matters.
                                                Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
