Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135791AbRDTELo>; Fri, 20 Apr 2001 00:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135792AbRDTELe>; Fri, 20 Apr 2001 00:11:34 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:32264 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S135791AbRDTELS>; Fri, 20 Apr 2001 00:11:18 -0400
Date: Fri, 20 Apr 2001 00:11:20 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@portland>
To: Gunther Mayer <Gunther.Mayer@t-online.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: PNP BIOS and parport_pc - dma found but not used
In-Reply-To: <3ADF20F4.2FBBE8DF@t-online.de>
Message-ID: <Pine.LNX.4.33.0104192348510.1119-100000@portland>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Gunther!

On Thu, 19 Apr 2001, Gunther Mayer wrote:

> > PnPBIOS: Parport found PNPBIOS PNP0401 at io=0378,0778 irq=7 dma=-1
>                                                                ^^^^^^ culprit !

For some reason I'm not getting that message anymore. PnPBIOS is in the
kernel, parport_pc is a module. This time I rebooted with the parport_pc
module already installed, as opposed to the first time when I compiled and
inserted it without a reboot.

I'm puzzled. Just in case, it's my .config:
http://www.red-bean.com/~proski/linux/config

Anyway, the result is still the same, just without this message.

> 1) Search for the right two-digit PNP handle for device "0104d041":

this is 01.

>    cat /proc/bus/pnb/devices

01      0104d041        07:01:00        0080
02      0105d041        07:00:02        0180
06      0007d041        01:02:00        0003
08      010cd041        05:00:00        0003
09      0000d041        08:00:01        0003
0a      0001d041        08:02:01        0003
0b      000bd041        08:03:01        0003
0c      0303d041        09:00:00        000b
0d      040cd041        0b:01:00        0003
0e      0002d041        08:01:01        0003
0f      0008d041        08:80:00        0003
10      030ad041        06:04:00        0003
11      020cd041        08:80:ff        0003

> 2) Send cat /proc/bus/pnp/01 | od -tx1

0000000 2a 00 00 22 80 00 47 01 78 03 78 03 00 08 47 01
0000020 78 07 78 07 00 08 79 00 30 2a 0a 00 22 80 00 47
0000040 01 bc 03 bc 03 00 03 47 01 bc 07 bc 07 00 03 30
0000060 2a 0a 00 22 80 00 47 01 78 03 78 03 00 08 47 01
0000100 78 07 78 07 00 08 30 2a 0a 00 22 20 00 47 01 78
0000120 02 78 02 00 08 47 01 78 06 78 06 00 08 38 79 00
0000140 79 00

Settings:
Parallel port mode: ECP+EPP
ECP DMA select: 3

-- 
Regards,
Pavel Roskin

