Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031705AbWLASdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031705AbWLASdx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 13:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031709AbWLASdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 13:33:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:38544 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1031705AbWLASdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 13:33:53 -0500
X-Authenticated: #24128601
Date: Fri, 1 Dec 2006 19:28:55 +0100
From: Sebastian Kemper <sebastian_ml@gmx.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: [OHCI] BIOS handoff failed (BIOS bug?)
Message-ID: <20061201182855.GA7867@section_eight>
Mail-Followup-To: Sebastian Kemper <sebastian_ml@gmx.net>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Pete Zaitcev <zaitcev@redhat.com>
References: <20061201130359.GA3999@section_eight>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061201130359.GA3999@section_eight>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 02:03:59PM +0100, Sebastian Kemper wrote:
> Hello all,
> 
> I sometimes get this message when I boot kernel 2.6.19. Could this be
> related to the BIOS option "USB keyboard support"? When I turn it off I
> never get the "handoff failed" message afaik. But I need it to access
> lilo. Now I use an USB->PS2 adapter and turn "USB keyboard support" off.
> 
> If "handoff failed" and "USB keyboard support" are related wouldn't it
> make sense to change the USB error handling?
> 
> Regards
> Sebastian

I digged deeper:

* the same happens with older kernels (I tried 2.6.17.13 for instance)
* the handoff works every time when "USB Keyboard Support" is disabled
  in my BIOS
* the handoff doesn't work when I enable "USB Keyboard Support" and use
  the keyboard at the lilo prompt (up, down, enter ...). It does work,
  though, when I keep my hands afk.

I also increased the wait time from 5 seconds to 20 in
drivers/usb/host/pci-quirks.c but that didn't change anything. I guess
the bios won't release OHCI in order to be able to serve keyboard input
without usb hid drivers once I hit a key when bios is still in charge.
But I looked around and couldn't see any ill effects so I'll stop
bothering you with this ;-)

Regards
Sebastian

Hardware:

* 32bit Sempron
* Shutte AN35N NForce2 mainboard

...
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
Machine check exception polling timer started.
io scheduler noop registered
io scheduler cfq registered (default)

0000:00:02.0 OHCI: BIOS handoff failed (BIOS bug ?) 00000784
############################################################

ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNK4] -> GSI 11 (level,
low) -> IRQ 11
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retrieved PLL infos from BIOS
...

/usr/src/linux/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux section_eight 2.6.19 #3 Fri Dec 1 19:04:08 CET 2006 i686 AMD
Sempron(tm)   2400+ AuthenticAMD GNU/Linux

Gnu C                  4.1.1
Gnu make               3.81
binutils               2.16.1
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.39
Linux C Library        > libc.2.4
Dynamic linker (ldd)   2.4
Procps                 3.2.6
Net-tools              1.60
Kbd                    1.12
Sh-utils               6.4
udev                   103
Modules Loaded         rt61 lirc_serial lirc_dev
