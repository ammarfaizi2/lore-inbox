Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbTFKRqc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 13:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbTFKRqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 13:46:32 -0400
Received: from smtp.inet.fi ([192.89.123.192]:34705 "EHLO smtp.inet.fi")
	by vger.kernel.org with ESMTP id S262316AbTFKRq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 13:46:28 -0400
From: Kimmo Sundqvist <rabbit80@mbnet.fi>
Organization: Unorganized
To: linux-kernel@vger.kernel.org
Subject: [2.5.70-mm7] Badness in local_bh_enable at kernel/softirq.c:117
Date: Wed, 11 Jun 2003 21:00:52 +0300
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306112100.52924.rabbit80@mbnet.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This been with us (or me) since 2.7.65

Someone said something about this having to do with IPv6, but I'm not using it 
now.  It's not even compiled, not in, not as a module.  It was when I tried 
2.5.67 and some other versions.

Jun 11 16:33:41 minjami pppd[208]: sent [LCP TermReq id=0x2 "User request"]
Jun 11 16:33:41 minjami pppoe[209]: Received signal 15.
Jun 11 16:33:41 minjami pppoe[209]: Sent PADT
Jun 11 16:33:41 minjami kernel: Badness in local_bh_enable at 
kernel/softirq.c:117
Jun 11 16:33:41 minjami kernel: Call Trace:
Jun 11 16:33:41 minjami kernel:  [local_bh_enable+53/108] 
local_bh_enable+0x35/0x6c
Jun 11 16:33:41 minjami kernel:  [__crc_pci_enable_device+2304814/5226744] 
ppp_async_push+0x190/0x19c
 [ppp_async]
Jun 11 16:33:41 minjami kernel:  [__crc_pci_enable_device+2302830/5226744] 
ppp_asynctty_wakeup+0x28/0
x4c [ppp_async]
Jun 11 16:33:41 minjami kernel:  [pty_unthrottle+35/72] 
pty_unthrottle+0x23/0x48
Jun 11 16:33:41 minjami kernel:  [check_unthrottle+50/56] 
check_unthrottle+0x32/0x38
Jun 11 16:33:41 minjami kernel:  [reset_buffer_flags+136/144] 
reset_buffer_flags+0x88/0x90
Jun 11 16:33:41 minjami kernel:  [n_tty_flush_buffer+11/64] 
n_tty_flush_buffer+0xb/0x40
Jun 11 16:33:41 minjami kernel:  [pty_flush_buffer+26/72] 
pty_flush_buffer+0x1a/0x48
Jun 11 16:33:41 minjami kernel:  [do_tty_hangup+441/992] 
do_tty_hangup+0x1b9/0x3e0
Jun 11 16:33:41 minjami kernel:  [tty_vhangup+10/16] tty_vhangup+0xa/0x10
Jun 11 16:33:41 minjami kernel:  [pty_close+254/260] pty_close+0xfe/0x104
Jun 11 16:33:41 minjami kernel:  [release_dev+506/1360] 
release_dev+0x1fa/0x550
Jun 11 16:33:41 minjami kernel:  [tty_release+74/140] tty_release+0x4a/0x8c
Jun 11 16:33:41 minjami kernel:  [__fput+48/160] __fput+0x30/0xa0
Jun 11 16:33:41 minjami kernel:  [fput+20/24] fput+0x14/0x18
Jun 11 16:33:41 minjami kernel:  [filp_close+208/220] filp_close+0xd0/0xdc
Jun 11 16:33:41 minjami kernel:  [put_files_struct+84/188] 
put_files_struct+0x54/0xbc
Jun 11 16:33:41 minjami kernel:  [do_exit+523/1064] do_exit+0x20b/0x428
Jun 11 16:33:41 minjami pppd[208]: Modem hangup

/proc/pci says:

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, In VT82C693A/694x [Apol (rev 196).
      Master Capable.  Latency=8.
      Prefetchable 32 bit memory at 0xd0000000 [0xd1ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, In VT82C598/694x [Apoll (rev 0).
      Master Capable.  No bursts.  Min Gnt=12.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, In VT82C686 [Apollo Sup (rev 64).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, In VT82C586/B/686A/B PI (rev 6).
      Master Capable.  Latency=16.
      I/O at 0xc000 [0xc00f].
  Bus  0, device   7, function  2:
    USB Controller: VIA Technologies, In USB (rev 22).
      IRQ 19.
      Master Capable.  Latency=16.
      I/O at 0xc400 [0xc41f].
  Bus  0, device   7, function  3:
    USB Controller: VIA Technologies, In USB (#2) (rev 22).
      IRQ 19.
      Master Capable.  Latency=16.
      I/O at 0xc800 [0xc81f].
  Bus  0, device   7, function  4:
    Bridge: VIA Technologies, In VT82C686 [Apollo Sup (rev 64).
      IRQ 9.
  Bus  0, device  11, function  0:
    Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 2).
      IRQ 17.
      Master Capable.  Latency=16.  Min Gnt=12.Max Lat=128.
      I/O at 0xcc00 [0xcc3f].
  Bus  0, device  12, function  0:
    Ethernet controller: 3Com Corporation 3c900 Combo [Boomera (rev 0).
      IRQ 19.
      Master Capable.  Latency=16.  Min Gnt=3.Max Lat=8.
      I/O at 0xd000 [0xd03f].
  Bus  0, device  14, function  0:
    Unknown mass storage controller: Triones Technologies HPT366/368/370/370A/ 
(rev 3).
      IRQ 18.
      Master Capable.  Latency=120.  Min Gnt=8.Max Lat=8.
      I/O at 0xd400 [0xd407].
      I/O at 0xd800 [0xd803].
      I/O at 0xdc00 [0xdc07].
      I/O at 0xe000 [0xe003].
      I/O at 0xe400 [0xe4ff].
  Bus  1, device   0, function  0:
    VGA compatible controller: Matrox Graphics, Inc MGA G200 AGP (rev 3).
      IRQ 16.
      Master Capable.  Latency=64.  Min Gnt=16.Max Lat=32.
      Prefetchable 32 bit memory at 0xd5000000 [0xd5ffffff].
      Non-prefetchable 32 bit memory at 0xd2000000 [0xd2003fff].
      Non-prefetchable 32 bit memory at 0xd3000000 [0xd37fffff].

*** and /proc/modules says:
snd 50368 - - Live 0xf8d2e000
soundcore 9088 - - Live 0xf8d19000
ppp_async 11520 - - Live 0xf8d0e000
microcode 6464 - - Live 0xf8d12000
nls_iso8859_1 4192 - - Live 0xf8c5f000
nls_cp437 5824 - - Live 0xf8c47000
vfat 16512 - - Live 0xf8c4a000
fat 46688 - - Live 0xf8c52000
videodev 9792 - - Live 0xf8948000
msr 3936 - - Live 0xf8946000
minix 34148 - - Live 0xf8991000
via686a 18084 - - Live 0xf895f000
i2c_sensor 3200 - - Live 0xf8944000
hfs 94048 - - Live 0xf8979000
ppp_synctty 9504 - - Live 0xf8940000
ppp_generic 30088 - - Live 0xf8956000
slhc 7040 - - Live 0xf8935000
3c59x 32360 - - Live 0xf894d000
i2c_core 22724 - - Live 0xf8939000

Btw, sensors-detect adds the following:
i2c_dev 10048 - - Live 0xfa652000
i2c_viapro 6028 - - Live 0xfa64f000

And then complains:
Couldn't open /proc/bus/i2c?!? at /usr/sbin/sensors-detect line 2584, <STDIN> 
line 5.

Is this the expected behavior for now?

-Kimmo S.

