Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbVFFXQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbVFFXQj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 19:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbVFFXQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 19:16:38 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:10078 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S261731AbVFFWoA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 18:44:00 -0400
Message-ID: <42A4D1AB.3090508@tls.msk.ru>
Date: Tue, 07 Jun 2005 02:43:55 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adam Belay <ambx1@neo.rr.com>
CC: matthieu castet <castet.matthieu@free.fr>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: PNP parallel&serial ports: module reload fails (2.6.11)?
References: <20050602222400.GA8083@mut38-1-82-67-62-65.fbx.proxad.net> <429FA1F3.9000001@tls.msk.ru> <42A2D37A.5050408@free.fr> <42A46551.9010707@tls.msk.ru> <20050606211855.GA3289@neo.rr.com>
In-Reply-To: <20050606211855.GA3289@neo.rr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Belay wrote:

Hmm.. Strange I haven't received your email.  Looking at our
maillog, looks like your host is listed in SORBS DUHL --
cpe-24-93-172-51.neo.res.rr.com[24.93.172.51].  Is it really
dynamic IP?  I'm sorry for the noise, but it's a real PITA
to handle email and spam properly nowadays... ;)

> On Mon, Jun 06, 2005 at 07:01:37PM +0400, Michael Tokarev wrote:
> 
[]
>>[ it's in http://www.corpit.ru/mjt/hpml310.dsdt - apache ships it
>>  as Content-Type: text/plain, for some reason.  I grabbed iasl
>>  and converted that stuff into .dsls, available at:
>>  http://www.corpit.ru/mjt/hpml310.dsl and
>>  http://www.corpit.ru/mjt/hpml150.dsl ]
>>
[]
> I've been looking into the parport issue.
> 
> Your ACPI _PRS method does look a little unusual (and possibly broken), but
> it might work if we assume that all of the other resources not mentioned are
> to be disabled.

Broken - is it a broken bios (so I will ask HP for an update),
or is it just how things works? ;)

BTW, there are quite some resources mentioned at PNP init time,
like this:

pnp: 00:08: ioport range 0x680-0x6ff has been reserved
pnp: 00:0c: ioport range 0x400-0x47f could not be reserved
pnp: 00:0c: ioport range 0x680-0x6ff has been reserved
pnp: 00:0c: ioport range 0x500-0x53f has been reserved
pnp: 00:0c: ioport range 0x500-0x53f has been reserved
pnp: 00:0c: ioport range 0x400-0x47f could not be reserved
pnp: 00:0c: ioport range 0x295-0x296 has been reserved
pnp: 00:0c: ioport range 0x3e0-0x3e7 has been reserved

> I'd like to see how the PnP layer is interpreting this, and also what your
> _CRS method is giving us.
> 
> Could I see the output of:
> 
> /sys/devices/pnp0/00:XX/resources
> 
> and:
> 
> /sys/bus/pnp/devices/00:XX/options
> 
> where XX is the function number of your parport device...  In one of your
> earlier emails it was "08".

Sure.  With one exception: I can't find a machine where this is
really "08" now.  I think I grabbed all that info from our machine
here at office (HPML150), but now it is reporting id 00:07, not
00:08 (maybe after we experimented with various modes of parallel
port - ECP/EPP/Standard - in bios).  Maybe it was from another
machine (in a remote office) where I first tried to deal with
the problem.  I checked current dsdt - it's still the same as on
the URL above.

Here's all the stuff from /sys/bus/pnp/devices/*/{resources,options}
on this machine (HPML150), devices 00:06 (serial port) and 00:07
(parallel port) are on top, after first load of parport_pc and 8250_pnp
modules (for all other devices, options file is empty):

00:06
state = active
io 0x3f8-0x3ff
irq 4

irq 3,4,5,6,7,10,11,12 High-Edge
Dependent: 01 - Priority acceptable
    port 0x3f8-0x3f8, align 0x0, size 0x8, 16-bit address decoding
Dependent: 02 - Priority acceptable
    port 0x2f8-0x2f8, align 0x0, size 0x8, 16-bit address decoding
Dependent: 03 - Priority acceptable
    port 0x3e8-0x3e8, align 0x0, size 0x8, 16-bit address decoding
Dependent: 04 - Priority acceptable
    port 0x2e8-0x2e8, align 0x0, size 0x8, 16-bit address decoding

00:07
state = active
io 0x378-0x37f
irq 7

Dependent: 01 - Priority acceptable
    port 0x378-0x378, align 0x0, size 0x8, 16-bit address decoding
    irq 3,4,5,6,7,10,11,12 High-Edge
Dependent: 02 - Priority acceptable
    port 0x278-0x278, align 0x0, size 0x8, 16-bit address decoding
    irq 3,4,5,6,7,10,11,12 High-Edge
Dependent: 03 - Priority acceptable
    port 0x3bc-0x3bc, align 0x0, size 0x4, 16-bit address decoding
    irq 3,4,5,6,7,10,11,12 High-Edge
Dependent: 04 - Priority acceptable
    port 0x378-0x378, align 0x0, size 0x8, 16-bit address decoding
Dependent: 05 - Priority acceptable
    port 0x278-0x278, align 0x0, size 0x8, 16-bit address decoding
Dependent: 06 - Priority acceptable
    port 0x3bc-0x3bc, align 0x0, size 0x4, 16-bit address decoding

00:00
state = active
io 0x0-0xf
io 0x81-0x83
io 0x87-0x87
io 0x89-0x8b
io 0x8f-0x8f
io 0xc0-0xdf
dma 4

00:01
state = active
io 0x70-0x71
irq 8

00:02
state = active
io 0x60-0x60
io 0x64-0x64
irq 1

00:03
state = active
irq 12

00:04
state = active
io 0x61-0x61

00:05
state = active
io 0xf0-0xff
irq 13

00:08
state = active
io disabled
io 0x680-0x6ff

00:09
state = active
io 0x10-0x1f
io 0x22-0x3f
io 0x44-0x5f
io 0x62-0x63
io 0x65-0x6f
io 0x72-0x7f
io 0x80-0x80
io 0x84-0x86

00:0a
state = active
mem 0xffb00000-0xffbfffff
mem 0xfff00000-0xffffffff

00:0b
state = active
mem 0xffc00000-0xffefffff

00:0c
state = active
io 0x400-0x47f
io disabled
io 0x680-0x6ff
io 0x500-0x53f
io 0x500-0x53f
io 0x400-0x47f
io 0x295-0x296
io 0x3e0-0x3e7
mem 0xfec00000-0xfecfffff
mem 0xfee00000-0xfee00fff

00:0d
state = active
mem 0x0-0x9ffff
mem 0xc0000-0xdffff
mem 0xe0000-0xfffff
mem 0x100000-0x7fffffff


Additionally, here's /proc/ioports after re-load of
parport_pc and 8250_pnp modules:

0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0295-0296 : pnp 00:0c
# 0378-037a : parport0 - it WAS here before parport_pc unload
03c0-03df : vga+
03e0-03e7 : pnp 00:0c
0400-047f : 0000:00:1f.0
   0400-0403 : PM1a_EVT_BLK
   0404-0405 : PM1a_CNT_BLK
   0408-040b : PM_TMR
   0420-0420 : PM2_CNT_BLK
   0428-042b : GPE0_BLK
   042c-042f : GPE1_BLK
0500-053f : 0000:00:1f.0
   0500-053f : pnp 00:0c
     0500-053f : pnp 00:0c
0540-055f : 0000:00:1f.3
0680-06ff : pnp 00:08
   0680-06ff : pnp 00:0c
0cf8-0cff : PCI conf1
8800-880f : 0000:01:00.0
9000-9007 : 0000:01:00.0
9400-9407 : 0000:01:00.0
9800-9807 : 0000:01:00.0
a000-a007 : 0000:01:00.0
a400-a407 : 0000:01:00.0
a800-a8ff : 0000:01:02.0
b000-dfff : PCI Bus #02
   b000-dfff : PCI Bus #04
     c400-c43f : 0000:04:01.0
       c400-c43f : e1000
     c800-c8ff : 0000:04:04.0
       c800-c8ff : aic79xx
     d000-d0ff : 0000:04:04.0
       d000-d0ff : aic79xx
     d400-d4ff : 0000:04:04.1
       d400-d4ff : aic79xx
     d800-d8ff : 0000:04:04.1
       d800-d8ff : aic79xx
e800-e81f : 0000:00:1d.0
ffa0-ffaf : 0000:00:1f.1
   ffa0-ffa7 : ide0
   ffa8-ffaf : ide1


And here's the same from hpml350 machine (the one Matthieu was
referring to when looking at the dsdt stuff) -- with just-loaded
(for the first time) parport_pc and 8250_pnp modules:

00:00
state = active
io 0xf50-0xf58
io 0x408-0x40f
io 0x92-0x92
io 0x900-0x903
io 0x904-0x904
io 0x910-0x911
io 0x920-0x923
io 0x930-0x937


00:01
state = active
io 0x0-0xf
io 0x80-0x8f
io 0xc0-0xdf
io 0x40b-0x40b
io 0x4d6-0x4d6
dma 7

00:02
state = active
io 0x61-0x61

00:03
state = active
io 0x60-0x60
io 0x64-0x64
irq 1

00:04
state = active
irq 12

00:05
state = active
io 0x2e-0x2f
io 0x220-0x223
io 0x240-0x25f
io 0x70-0x73

00:06
state = active
io 0x378-0x37f
io 0x778-0x77d
irq 7
dma 0

Dependent: 01 - Priority preferred
    port 0x378-0x378, align 0x0, size 0x8, 16-bit address decoding
Dependent: 02 - Priority preferred
    port 0x3bc-0x3bc, align 0x0, size 0x3, 16-bit address decoding
Dependent: 03 - Priority preferred
    port 0x278-0x278, align 0x0, size 0x8, 16-bit address decoding

00:07
state = active
io 0x3f8-0x3ff
irq 4

Dependent: 01 - Priority preferred
    port 0x3f8-0x3f8, align 0x7, size 0x8, 16-bit address decoding
    irq 4 High-Edge
Dependent: 02 - Priority acceptable
    port 0x2f8-0x2f8, align 0x7, size 0x8, 16-bit address decoding
    irq 3 High-Edge
Dependent: 03 - Priority functional
    port 0x3e8-0x3f8, align 0x7, size 0x8, 16-bit address decoding
    irq 4 High-Edge
Dependent: 04 - Priority functional
    port 0x2e8-0x2f8, align 0x7, size 0x8, 16-bit address decoding
    irq 3 High-Edge

00:08
state = active
io 0x2f8-0x2ff
irq 3

Dependent: 01 - Priority preferred
    port 0x3f8-0x3f8, align 0x7, size 0x8, 16-bit address decoding
    irq 4 High-Edge
Dependent: 02 - Priority acceptable
    port 0x2f8-0x2f8, align 0x7, size 0x8, 16-bit address decoding
    irq 3 High-Edge
Dependent: 03 - Priority functional
    port 0x3e8-0x3f8, align 0x7, size 0x8, 16-bit address decoding
    irq 4 High-Edge
Dependent: 04 - Priority functional
    port 0x2e8-0x2f8, align 0x7, size 0x8, 16-bit address decoding
    irq 3 High-Edge

00:09
state = active
io 0x3f2-0x3f5
irq 6
dma 2

port 0x3f0-0x3f0, align 0x0, size 0x6, 16-bit address decoding
port 0x3f7-0x3f7, align 0x0, size 0x1, 16-bit address decoding
irq 6 High-Edge
dma 2 8-bit compatible


/proc/ioports:

0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0220-0223 : PM1b_EVT_BLK
0230-0233 : PM1a_CNT_BLK
02f8-02ff : serial
0378-037a : parport0
03c0-03df : vga+
03f8-03ff : serial
0408-040f : pnp 00:00
0900-0903 : PM1a_EVT_BLK
0904-0904 : pnp 00:00
0910-0913 : PM1b_CNT_BLK
0920-0923 : PM_TMR
0930-0937 : pnp 00:00
0cf8-0cff : PCI conf1
0f50-0f58 : pnp 00:00
1800-18ff : 0000:00:05.0
2000-200f : 0000:00:0f.1
2400-24ff : 0000:00:01.0
2800-28ff : 0000:00:04.0

I'm sorry for alot of digits...  As I already mentioned, I know
right to nothing about acpi and pnp subsystems to know if all this
is useless or not... ;)

Thank you.

/mjt
