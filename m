Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317855AbSHaSWV>; Sat, 31 Aug 2002 14:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317859AbSHaSWU>; Sat, 31 Aug 2002 14:22:20 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:36828 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S317855AbSHaSWT>;
	Sat, 31 Aug 2002 14:22:19 -0400
Date: Sat, 31 Aug 2002 20:26:45 +0200
From: bert hubert <ahu@ds9a.nl>
To: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: keyboard slowdown regression in 2.5.32 (right .config) Re: FIXED in 2.5.29 Re: keyboard ONLY functions in 2.5.27 with local APIC on for UP
Message-ID: <20020831182645.GA8812@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
References: <20020720222905.GA15288@outpost.ds9a.nl> <20020728204051.A15238@ucw.cz> <20020728203211.GA20082@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020728203211.GA20082@outpost.ds9a.nl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech, list, I think we may have a small regression in the keyboard
support.

In 2.5.27 my keyboard only worked when I turned on Local APIC on UP, which
was fixed in 2.5.29 (original message below).

In 2.5.32 I'm back to almost the exact same problem, but the APIC setting
does not matter.

It boots fine without keyboard support, which I had initially after make
oldconfig (except no keyboard). When I turn on the keyboard support, just
after 'Freeing unused kernel memory', my harddisk light starts to blink
roughly once every .75 seconds and the boot proceeds *very* slowly.
Furthermore, I can feel that the CPU is hard at work, the fan exhaust of my
laptop gets pretty hot.

Numlock does not react and keystrokes do not appear on the screen. I do see
some keyboard related printk's early in the bootprocess but they are gone
quickly and do not look like errors.

This is the exact same behaviour I had with 2.5.27 and APIC *off*.

2.5.31 works fine. This is a nearly-completely-SiS laptop from a company
called 'Gericom'.

Booted with 2.5.31:
$ cat /proc/interrupts 
           CPU0       
  0:     475860          XT-PIC  timer
  1:       2572          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          3          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:       3141          XT-PIC  eth0
 12:        526          XT-PIC  PS/2 Mouse
 14:       4879          XT-PIC  ide0
 15:         11          XT-PIC  ide1
NMI:          0 
ERR:          0

$ cat /proc/ioports 
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
a000-afff : PCI Bus #01
  ac80-acff : Silicon Integrated Systems [SiS] SiS630 GUI Accelerator+3D
d000-d0ff : Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet
  d000-d0ff : sis900
d400-d4ff : Silicon Integrated Systems [SiS] SiS PCI Audio Accelerator
d800-d87f : PCI device 1039:7013 (Silicon Integrated Systems [SiS])
dc00-dcff : PCI device 1039:7013 (Silicon Integrated Systems [SiS])
ff00-ff0f : Silicon Integrated Systems [SiS] 5513 [IDE]
  ff00-ff07 : ide0
  ff08-ff0f : ide1

ahu@snapcount:/mnt/linux-2.5.32$ egrep 'KEY|INPUT' .config
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_JOYDUMP is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
# CONFIG_INPUT_UINPUT is not set
# CONFIG_USB_HIDINPUT is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19QW is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19QI is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set

Let me know if there are further things I can try. I think I know where my
nullmodem cable is, so I could try that.

Kind regards,

bert hubert


On Sun, Jul 28, 2002 at 10:32:12PM +0200, bert hubert wrote:
> On Sun, Jul 28, 2002 at 08:40:51PM +0200, Vojtech Pavlik wrote:
> 
> > > I find that my keyboard only works if I turn on the local APIC on UP on my
> > > laptop. The only clue I see scrolling past is something about 'AT keyboard
> > > timeout, not present?'. I don't have my nullmodem cable handy to check it
> > > out further.
> 
> > Can you check with 2.5.29? Several bugs in the keyboard support were
> > fixed.
> 
> Including mine, thanks! I just tested without local APIC on UP and my
> keyboard works just fine. 
> 
> Regards,
> 
> bert
> 
> -- 
> http://www.PowerDNS.com          Versatile DNS Software & Services
> http://www.tk                              the dot in .tk
> http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
