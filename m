Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286776AbRL1HRT>; Fri, 28 Dec 2001 02:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286778AbRL1HRK>; Fri, 28 Dec 2001 02:17:10 -0500
Received: from hal.astr.lu.lv ([195.13.134.67]:54912 "EHLO hal.astr.lu.lv")
	by vger.kernel.org with ESMTP id <S286776AbRL1HRB>;
	Fri, 28 Dec 2001 02:17:01 -0500
Message-Id: <200112280716.fBS7GlE01979@hal.astr.lu.lv>
From: Andris Pavenis <pavenis@latnet.lv>
To: Nathan Bryant <nbryant@optonline.net>
Subject: Re: i810_audio driver version 0.13 still broken
Date: Fri, 28 Dec 2001 09:16:47 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Doug Ledford <dledford@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.A41.4.05.10112081022560.23064-100000@ieva06> <200112271110.fBRBA5S00309@hal.astr.lu.lv> <3C2B9649.7090503@optonline.net>
In-Reply-To: <3C2B9649.7090503@optonline.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_ZJL12EN7QFI7NRFXA133"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_ZJL12EN7QFI7NRFXA133
Content-Type: text/plain;
  charset="iso-8859-13"
Content-Transfer-Encoding: 8bit

On Thursday 27 December 2001 23:44, Nathan Bryant wrote:
> Andris Pavenis wrote:
> >It still hanged machine after playing KDE startup sound. Didn't tried much
> >more and moved to my modified version of 0.12 which worked
>
> please send me your modified version again. full file would be best, not
> patch.

Got also my patched 0.12 freezing system later (kernel 2.4.17). Didn't saw
that earlier with 2.4.17-pre2. Also tried to move port I/O stuff from
__i810_update_lvi() to start_adc() and start_dac() inside if block to 
avoid any possibility of doing wait loop when noting is done in start_dac()
and still get system locking up when loading driver. Perhaps I should
recheck with kernel 2.4.17-pre2 (I didn't have problems with it before
leaving to Finland now more than 2 weeks ago)

>
> i can't reproduce any problems here, so far, so i'm stabbing in the
> dark. if you can give more detailed information to reproduce, that would
> be nice: hardware versions, version of KDE, kde settings, (mine doesn't
> play a startup sound and artsd works fine for everything else i try),
> artsd settings. if i can reproduce, i can analyze on my own machine, if
> not, outlook is hazy ;-)

Kernel 2.4.17 compiled with gcc-2.95.3, devfs is enabled, ext3 filesystem (I
	 would prefer not to hang system with ext2, ext3 seems to
	handle that nicely)
XFree86-4.1.99.2 (cvs  update -r xf-4_1_99_2 xc; ....)
KDE-2.2.2 release (compiled here with gcc-2.95.3)
Contents of /proc/pci attached

KDE sound server settings:
	Start aRts soundserver on KDE startup - on
	Enable network transperancy - on
	Exchange security and reference info over the X11 server - on
	Run soundserver with realtime priority - off
	Autosuspend if idle for 5 seconds
	Display messages using artsmessage
	Message display: errors

	Sound I/O method: autodetect
	Enable full duplex operation: off
	Use custom sound device: off
	Use custom sampling rate: off
	Other custom options: off
	Audio buffer size: 278 millisoconds (12 fragments with 4096 bytes)

	I have setup to play one wav file from VFAT32 partition at KDE startup

Perhaps I'll look into that in next Year only. It seems I'll have to repeat 
enabling debug output from i810_audio driver and to put additional output 
there to see where I have the trouble.

Andris

--------------Boundary-00=_ZJL12EN7QFI7NRFXA133
Content-Type: text/plain;
  charset="iso-8859-13";
  name="proc_pci"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="proc_pci"

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corp. 82810 GMCH [Graphics Memory Controller Hub] (rev 3).
  Bus  0, device   1, function  0:
    VGA compatible controller: Intel Corp. 82810 CGC [Chipset Graphics Controller] (rev 3).
      IRQ 11.
      Prefetchable 32 bit memory at 0xe4000000 [0xe7ffffff].
      Non-prefetchable 32 bit memory at 0xe3800000 [0xe387ffff].
  Bus  0, device  30, function  0:
    PCI bridge: Intel Corp. 82801AA PCI Bridge (rev 2).
      Master Capable.  No bursts.  Min Gnt=6.
  Bus  0, device  31, function  0:
    ISA bridge: Intel Corp. 82801AA ISA Bridge (LPC) (rev 2).
  Bus  0, device  31, function  1:
    IDE interface: Intel Corp. 82801AA IDE (rev 2).
      I/O at 0xb800 [0xb80f].
  Bus  0, device  31, function  2:
    USB Controller: Intel Corp. 82801AA USB (rev 2).
      IRQ 9.
      I/O at 0xb400 [0xb41f].
  Bus  0, device  31, function  3:
    SMBus: Intel Corp. 82801AA SMBus (rev 2).
      IRQ 10.
      I/O at 0xe800 [0xe80f].
  Bus  0, device  31, function  5:
    Multimedia audio controller: Intel Corp. 82801AA AC'97 Audio (rev 2).
      IRQ 10.
      I/O at 0xe000 [0xe0ff].
      I/O at 0xe100 [0xe13f].
  Bus  1, device  10, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 16).
      IRQ 9.
      Master Capable.  Latency=64.  Min Gnt=32.Max Lat=64.
      I/O at 0xd800 [0xd8ff].
      Non-prefetchable 32 bit memory at 0xe3000000 [0xe30000ff].

--------------Boundary-00=_ZJL12EN7QFI7NRFXA133--
