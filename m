Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261436AbTCYEHX>; Mon, 24 Mar 2003 23:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261439AbTCYEHX>; Mon, 24 Mar 2003 23:07:23 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:48304 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id <S261436AbTCYEHW>; Mon, 24 Mar 2003 23:07:22 -0500
Date: Tue, 25 Mar 2003 15:18:03 +1100
From: CaT <cat@zip.com.au>
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Gerd Knorr <kraxel@bytesex.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.66
Message-ID: <20030325041802.GA535@zip.com.au>
References: <Pine.LNX.4.44.0303241524050.1741-100000@penguin.transmeta.com> <20030325012252.7aafee8c.us15@os.inf.tu-dresden.de> <20030325003048.GC10505@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030325003048.GC10505@kroah.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 04:30:48PM -0800, Greg KH wrote:
> Yes, I sent out some patches a few evenings ago to lkml that should fix
> this problem.  I'm resyncing them with 2.5.66 right now and will send
> them to Linus in a bit.

I have an oops of my very own to report, and this one is with the afore
mentioned patches applied:

mice: PS/2 mouse device common for all mice
logimb.c: Didn't find Logitech busmouse at 0x23c
input: PC Speaker
input: PS/2 Synaptics Touchpad on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
i2c-dev.o: i2c /dev entries driver module version 2.7.0 (20021208)
i2c-proc.o version 2.7.0 (20021208)
i2c-pixx4 version 2.7.0 (20021208)
piix4 smbus 00.07.3: Found Intel Corp. 82371AB/EM/MB PIIX4  device
Unable to handle kernel NULL pointer dereference at vertual address 00000000
 printing eip:
c02fb031
*pde = 00000000
Oops: 0000 [#1]
CPU:	0
EIP:	0060:[<c02fb831>]    Not tainted
EFLAGS:	00010202
EIP is at piix4_transaction+0x101/0x15c
eax: 00000000	ebx: 00000004	ecx: 00000000	edx: ffffffff
esi: 00000000	edi: ffffffff	ebp: c1299ee8	esp: c1299ed8
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c1298000 task=c12fe040)
Stack: c04cfdb6 00000000 00000000 00000000 c1299f00 c02fba7e 00000018 00000000
       00000000 00000648 c1299f4c c02f9a3b c04cfc60 00000018 00000000 00000000
       00000000 00000000 00000000 00000000 00000001 00000001 c04cfc78 0000ffff
Call Trace:
 [<c02fba7e>] piix4_access+0x1f2/0x2d0
 [<c02f9a3b>] i2c_smbus_xfer+0x123/0x1b8
 [<c02fb43c>] i2c_detect+0x44/0x494
 [<c02fbbe6>] adm1021_attach_adapter+0x16/0x1c
 [<c02fbbec>] adm1021_detect+0x0/0x2d8
 [<c02f7f31>] i2x_add_driver+0xdd/0x104
 [<c010502c>] init+0x0/0x144
 [<c0105049>] init+0x1d/0x144
 [<c010502c>] init+0x0/0x144
 [<c0107211>] kernel_thread_helper+0x5/0xc

Code: 8b 00 50 68 20 36 44 c0 e8 fa ff e1 ff 83 c4 0c 0f b7 15 08
 <0>Kernel panic: Attempted to kill init!

After a long pause it then looped, once per second with the call trace
repeating over and over again in the framebufer. Basically every time the
cursor was blinked. The end of these call traces is also the above call
trace. Also, the call trace was looping due to the code being called in
an illegal context in mm/slab.c:1723.

-- 
"Other countries of course, bear the same risk. But there's no doubt his
hatred is mainly directed at us. After all this is the guy who tried to
kill my dad."
        - George W. Bush Jr, Leader of the United States Regime
          September 26, 2002 (from a political fundraiser in Houston, Texas)
