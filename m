Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313181AbSHMJPw>; Tue, 13 Aug 2002 05:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSHMJPw>; Tue, 13 Aug 2002 05:15:52 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:27889 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S313181AbSHMJPu>; Tue, 13 Aug 2002 05:15:50 -0400
Date: Tue, 13 Aug 2002 11:19:38 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Greg Kroah-Hartman <greg@kroah.com>,
       Kai Germaschewski <kai.germaschewski@gmx.de>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre2
In-Reply-To: <Pine.LNX.4.44.0208121943150.3382-100000@freak.distro.conectiva>
Message-ID: <Pine.NEB.4.44.0208131116270.14606-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2002, Marcelo Tosatti wrote:

>...
> Greg Kroah-Hartman <greg@kroah.com>:
>...
>   o USB: removed the devrequest typedef
>...

This broke the compilation of drivers/isdn/hisax/st5481_usb.c:

<--  snip  -->

...
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.4/linux-2.4.19-full/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=k6  -DHISAX_MAX_CARDS=8 -nostdinc -I
/usr/lib/gcc-lib/i386-linux/2.95.4/include -DKBUILD_BASENAME=st5481_usb  -c -o
st5481_usb.o st5481_usb.c
st5481_usb.c: In function `usb_next_ctrl_msg':
st5481_usb.c:43: structure has no member named `request'
st5481_usb.c:44: structure has no member named `value'
st5481_usb.c:45: structure has no member named `index'
st5481_usb.c: In function `usb_ctrl_msg':
st5481_usb.c:72: structure has no member named `requesttype'
st5481_usb.c:73: structure has no member named `request'
st5481_usb.c:74: structure has no member named `value'
st5481_usb.c:75: structure has no member named `index'
st5481_usb.c:76: structure has no member named `length'
st5481_usb.c: In function `usb_ctrl_complete':
st5481_usb.c:143: structure has no member named `request'
st5481_usb.c:147: structure has no member named `index'
st5481_usb.c:148: structure has no member named `index'
st5481_usb.c:152: structure has no member named `index'
st5481_usb.c:152: structure has no member named `index'
st5481_usb.c:153: structure has no member named `index'
st5481_usb.c:154: structure has no member named `index'
make[4]: *** [st5481_usb.o] Error 1
make[4]: Leaving directory
`/home/bunk/linux/kernel-2.4/linux-2.4.19-full/drivers/isdn/hisax'

<--  snip  -->

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


