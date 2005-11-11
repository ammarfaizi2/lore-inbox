Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbVKKXaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbVKKXaQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 18:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbVKKXaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 18:30:16 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:33235 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751298AbVKKXaO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 18:30:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mWCww+ltrUMoTg6TcZdF/mIlw0SlPxa6Uvnx5Wl01cTqUWxUjDqiAafkKvPOjlvwr9gRhvml0TZsbCJjp3TpAJFBSPTSx5AzqXqMNtXnak3xXWY6ii/FhLnD5+9gu5PyE9dQmNbD0EfDYSXSVHOUT+1vsxjPe+WtT4cuyZ5yJtA=
Message-ID: <6bffcb0e0511111530t55bb1decq@mail.gmail.com>
Date: Sat, 12 Nov 2005 00:30:13 +0100
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.14-mm2
Cc: linux-kernel@vger.kernel.org, "Antonino A. Daplas" <adaplas@pol.net>
In-Reply-To: <20051111150108.265b2d3f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051110203544.027e992c.akpm@osdl.org>
	 <6bffcb0e0511111432m771dcda2y@mail.gmail.com>
	 <20051111150108.265b2d3f.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/05, Andrew Morton <akpm@osdl.org> wrote:
> Yup, thanks.  Yesterday Ben reported:
>
> > not 100% sure what's up, but current -git has funny breakage with
> > nvidiafb on an iMac G5 I have here. The mode seems correct but the
> > console uses one line too much of text.
> >
> > That is, the total height of the screen isn't a multiple of the height
> > of a line of text. It seems that fbcon is rounding up instead of down,
> > thus the "last" line is basically going offscreen (about 2 or 3 pixels
> > visible, the rest is offscreen).
> >
>
> Which looks sort-of similar.
>
> And Tony replied:
>
> > What does stty -a say, and fbset -i?
>

debian:~# stty -a
speed 38400 baud; rows 48; columns 128; line = 0;
intr = ^C; quit = ^\; erase = ^?; kill = ^U; eof = ^D; eol = <undef>;
eol2 = <undef>; start = ^Q; stop = ^S; susp = ^Z;
rprnt = ^R; werase = ^W; lnext = ^V; flush = ^O; min = 1; time = 0;
-parenb -parodd cs8 hupcl -cstopb cread -clocal -crtscts
-ignbrk -brkint -ignpar -parmrk -inpck -istrip -inlcr -igncr icrnl
ixon ixoff -iuclc -ixany -imaxbel
opost -olcuc -ocrnl onlcr -onocr -onlret -ofill -ofdel nl0 cr0 tab0 bs0 vt0 ff0
isig icanon -iexten echo echoe echok -echonl -noflsh -xcase -tostop
-echoprt -echoctl echoke

debian:~# fbset -i

mode "1024x768-60"
    # D: 65.003 MHz, H: 48.365 kHz, V: 60.006 Hz
    geometry 1024 768 1024 32767 8
    timings 15384 160 24 29 3 136 6
    accel true
    rgba 8/0,8/0,8/0,0/0
endmode

Frame buffer device information:
    Name        : NV32
    Address     : 0xe8000000
    Size        : 134217728
    Type        : PACKED PIXELS
    Visual      : PSEUDOCOLOR
    XPanStep    : 8
    YPanStep    : 1
    YWrapStep   : 0
    LineLength  : 1024
    MMIO Address: 0xf6000000
    MMIO Size   : 16777216
    Accelerator : Unknown (45)

fbset recognise my gpu as NV32. lspci show it as NV34 (0000:01:00.0
VGA compatible controller: nVidia Corporation NV34 [GeForce FX 5200]
(rev a1)
). According to
http://download.nvidia.com/Windows/45.23/NVIDIA_Driver_Release_Notes_v45.23.pdf
it should be NV34.

Regards,
Michal Piotrowski
