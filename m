Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265843AbSLIRrj>; Mon, 9 Dec 2002 12:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265885AbSLIRrj>; Mon, 9 Dec 2002 12:47:39 -0500
Received: from mailnw.centurytel.net ([209.206.160.237]:2226 "EHLO
	mailnw.centurytel.net") by vger.kernel.org with ESMTP
	id <S265843AbSLIRrg>; Mon, 9 Dec 2002 12:47:36 -0500
Message-ID: <3DF549BC.8050806@centurytel.net>
Date: Mon, 09 Dec 2002 18:56:12 -0700
From: eric lin <fsshl@centurytel.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021208 Debian/1.2.1-2
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: debian-user@lists.debian.org
Subject: from intel onboard Lan and audo to install 2.4.50
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Colin Watson wrote:

 >On Mon, Dec 09, 2002 at 12:59:55AM -0700, eric lin wrote:
 >
 >
 >> the following dmesg seem to show it detect my ac97 is i810_audio but
 >>it said Primary codec not ready
 >>
 >>please help on this
 >>in 2.4.20 intel borad
 >>/* eepro is also not work, both I all put in my /etc/modules */
 >>
 >>sincere ERic
 >>www.linuxspice.com
 >>linux pc for sale
 >>
 >>eepro_init_module: Probe is very dangerous in ISA boards!
 >>eepro_init_module: Please add "autodetect=1" to force probe
 >>CSLIP: code copyright 1989 Regents of the University of California
 >>PPP generic driver version 2.4.2
 >>PPP Deflate Compression module registered
 >>PPP BSD Compression module registered
 >>Intel 810 + AC97 Audio, version 0.21, 23:23:34 Nov 30 2002
 >>PCI: Found IRQ 3 for device 00:1f.5
 >>PCI: Sharing IRQ 3 with 00:1f.3
 >>PCI: Setting latency timer of device 00:1f.5 to 64
 >>i810: Intel ICH4 found at IO 0xe080 and 0xe400, IRQ 3
 >>i810_audio: Audio Controller supports 6 channels.
 >>i810_audio: Primary codec not ready.
 >>
 >>
 >
 >As far as I can tell, this happens if the i810 doesn't have the ac97
 >codec. Assuming that it really is an i810 card [1], you might have
 >better luck getting a response from the linux-kernel mailing list.
 >
 >[1] You've explicitly put it in /etc/modules, so who knows! Note that I
 >    don't have to explicitly add i810_audio to /etc/modules or
 >    /etc/modutils/* for my laptop; instead the kernel works it out
 >    automatically.
 >
 >
 >
 >>eepro_init_module: Probe is very dangerous in ISA boards!
 >>eepro_init_module: Please add "autodetect=1" to force probe
 >>
 >>
 >
 >The eepro module needs at least an io argument to set the I/O base
 >address(es), and possibly an irq argument too. You can use 'options'
 >lines in /etc/modutils/* to set options that are always added when
 >probing named modules; see the modules.conf(5) man page and remember to
 >run update-modules after editing files in /etc/modutils.
 >
my lspci -v result related to intel onboard LAN(assume is eepro)

 >02:08.0 Ethernet controller: Intel Corp.: Unknown device 1039 (rev 82)
 >        Subsystem: Intel Corp.: Unknown device 3015
 >        Flags: bus master, medium devsel, latency 32, IRQ 11
 >        Memory at feafe000 (32-bit, non-prefetchable) [size=4K]
 >        I/O ports at d880 [size=64]
 >        Capabilities: <available only to root>
 >

 >If it's a PCI card, you might want eepro100 instead?
 >
 >
 >
I tried put a line in /etc/modutils/actions
insmod eepro autodetect=1 IO=d880 IRQ=11
reboot , still not work
(may be sytax is wrong, have any opinion? do see man page have its 
syntax on the option feature)

some say newest kernel 2.5.50 can solve all above hardware(intel board 
on board LAN and audio ) problem, so I download full tar.gz, choose what 
my hardware fit
make install

error happen, I justify one of it, first one, in 
linux-2.4.50/include/asm-i386/io_apic.h
containing sis_apic_bug  not include its .h file

then re do  make install
still error, this time I have no clue
-----------------------------------------------------
in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o 
--end-group  -o vmlinux
drivers/built-in.o(.text+0x11f15): In function `kd_nosound':
: undefined reference to `input_event'
drivers/built-in.o(.text+0x11f31): In function `kd_nosound':
: undefined reference to `input_event'
drivers/built-in.o(.text+0x11fc8): In function `kd_mksound':
: undefined reference to `input_event'
drivers/built-in.o(.text+0x12baa): In function `kbd_bh':
: undefined reference to `input_event'
drivers/built-in.o(.text+0x12bb8): In function `kbd_bh':
: undefined reference to `input_event'
drivers/built-in.o(.text+0x12bc9): more undefined references to 
`input_event' follow
drivers/built-in.o(.text+0x13003): In function `kbd_connect':
: undefined reference to `input_open_device'
drivers/built-in.o(.text+0x1301f): In function `kbd_disconnect':
: undefined reference to `input_close_device'
drivers/built-in.o(.init.text+0xd71): In function `kbd_init':
: undefined reference to `input_register_handler'
make: *** [vmlinux] Error 1
fsshl@www:~/linux-2.5.50$
------------------------------------------------------------

also I have difficult(unsuccess) patch 2.5.50
I did
gzip -cd patch-2.5.50-ac1.gz  | patch -p0
in my home direction which I untar unzip linux-2.5.50.tar.gz
it ask file to patch
I type patch-2.5.50-ac1.gz again,   not right, so produc .orig and .rej 
files, please help on that

highly appreciate your help and your time
sincere Eric
www.linuxspice.com
linux pc for sale




