Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271487AbRH1P2V>; Tue, 28 Aug 2001 11:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271505AbRH1P2P>; Tue, 28 Aug 2001 11:28:15 -0400
Received: from paloma14.e0k.nbg-hannover.de ([62.159.219.14]:25032 "HELO
	paloma14.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S271487AbRH1P2A>; Tue, 28 Aug 2001 11:28:00 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Date: Tue, 28 Aug 2001 17:28:07 +0200
X-Mailer: KMail [version 1.3]
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Mike Galbraith <mikeg@wen-online.de>, Robert Love <rml@tech9.net>,
        ReiserFS List <reiserfs-list@namesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20010828152807Z271487-760+6800@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 28. August 2001 03:08 schrieb Dieter Nützel:
> Are you like some numbers?
>
> I've generated some max-readahead numbers (dbench-1.1 32 clients) with
> 2.4.8-ac11,  2.4.8-ac12 (+ memory.c fix) and 2.4.8-ac12 (+ memory.c fix +
> low latency)
>
> system:
> Athlon I 550
> MSI MS-6167 Rev 1.0B, AMD Irongate C4 (without bypass)
> 640 MB PC100-2-2-2 SDRAM
> AHA-2940UW
> IBM U160 DDYS 18 GB, 10.000 rpm (in UW mode)
> all filesystems ReiserFS 3.6.25
>
> * readahead do not show dramatic differences
> * killall -STOP kupdated DO

> 2.4.8-ac12 + The Right memory.c fix + low latency patch
>
> max-readahead 31 (default)
> Throughput 20.3505 MB/sec (NB=25.4381 MB/sec  203.505 MBit/sec)
> 25.430u 75.250s 3:28.58 48.2%   0+0k 0+0io 911pf+0w
>
> killall -STOP kupdated
>
> max-readahead 31 (default)
> Throughput 29.25 MB/sec (NB=36.5625 MB/sec  292.5 MBit/sec)
> 24.600u 86.370s 2:25.42 76.3%   0+0k 0+0io 911pf+0w
>
> max-readahead 511
> Throughput 30.0372 MB/sec (NB=37.5465 MB/sec  300.372 MBit/sec)
> 25.590u 75.910s 2:21.64 71.6%   0+0k 0+0io 911pf+0w

Argh, every one have from time to time some minutes...
I've patched with the low latency patch (patch-rml-2.4.8-ac12-preempt- 
kernel-1) , compiled and run it (see above) but didn't enabled it....

So here are the right numbers, now.
They are not much different but it is good to see that low latency do not 
harm disk troughput for this test.

* I never saw such low numbers for context switches (GREAT).
* load hardly only reach half the numbers (~16, for 32 processes)
   compared to the normal kernel
* system is very smooth and snappy

Drawbacks:
There are several (most/all) modules missing preempt_schedule symbol.
See the end of this mail.

Regards,
	Dieter

PS Should I redo my test with 2.4.9/2.410-pre1 + max-readahead patch or is 
it useless like Daniel mentioned?

2.4.8-ac12 + The Right memory.c fix + low latency patch
The Real Test (CONFIG_PREEMPT=y)
 
max-readahead 31 (default)
Throughput 19.9584 MB/sec (NB=24.948 MB/sec  199.584 MBit/sec)
26.480u 79.570s 3:32.66 49.8%   0+0k 0+0io 911pf+0w
 
killall -STOP kupdated
 
max-readahead 31 (default)
Throughput 29.6149 MB/sec (NB=37.0186 MB/sec  296.149 MBit/sec)
26.590u 78.830s 2:23.65 73.3%   0+0k 0+0io 911pf+0w
 
max-readahead 511
Throughput 30.3902 MB/sec (NB=37.9878 MB/sec  303.902 MBit/sec)
26.510u 78.430s 2:20.00 74.9%   0+0k 0+0io 911pf+0w

depmod -aev
[-]
xftw starting at /lib/modules/2.4 lstat on /lib/modules/2.4 failed
xftw starting at /lib/modules/kernel lstat on /lib/modules/kernel failed
xftw starting at /lib/modules/fs lstat on /lib/modules/fs failed
xftw starting at /lib/modules/net lstat on /lib/modules/net failed
xftw starting at /lib/modules/scsi lstat on /lib/modules/scsi failed
xftw starting at /lib/modules/block lstat on /lib/modules/block failed
xftw starting at /lib/modules/cdrom lstat on /lib/modules/cdrom failed
xftw starting at /lib/modules/ipv4 lstat on /lib/modules/ipv4 failed
xftw starting at /lib/modules/ipv6 lstat on /lib/modules/ipv6 failed
xftw starting at /lib/modules/sound lstat on /lib/modules/sound failed
xftw starting at /lib/modules/fc4 lstat on /lib/modules/fc4 failed
xftw starting at /lib/modules/video lstat on /lib/modules/video failed
xftw starting at /lib/modules/misc lstat on /lib/modules/misc failed
xftw starting at /lib/modules/pcmcia lstat on /lib/modules/pcmcia failed
xftw starting at /lib/modules/atm lstat on /lib/modules/atm failed
xftw starting at /lib/modules/usb lstat on /lib/modules/usb failed
xftw starting at /lib/modules/ide lstat on /lib/modules/ide failed
xftw starting at /lib/modules/ieee1394 lstat on /lib/modules/ieee1394 failed
xftw starting at /lib/modules/mtd lstat on /lib/modules/mtd failed
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/drivers/block/floppy.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/drivers/block/floppy.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/drivers/block/loop.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/drivers/block/loop.o
/lib/modules/2.4.8-ac12/kernel/drivers/cdrom/cdrom.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/drivers/char/drm/tdfx.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/drivers/char/drm/tdfx.o
/lib/modules/2.4.8-ac12/kernel/drivers/char/joystick/analog.o
/lib/modules/2.4.8-ac12/kernel/drivers/char/joystick/emu10k1-gp.o
/lib/modules/2.4.8-ac12/kernel/drivers/char/joystick/gameport.o
/lib/modules/2.4.8-ac12/kernel/drivers/char/joystick/sidewinder.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/drivers/char/lp.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/drivers/char/lp.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/drivers/char/ppdev.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/drivers/char/ppdev.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/drivers/char/serial.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/drivers/char/serial.o
/lib/modules/2.4.8-ac12/kernel/drivers/i2c/i2c-core.o
/lib/modules/2.4.8-ac12/kernel/drivers/i2c/i2c-dev.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/drivers/ide/ide-disk.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/drivers/ide/ide-disk.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/drivers/ide/ide-mod.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/drivers/ide/ide-mod.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/drivers/ide/ide-probe-mod.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/drivers/ide/ide-probe-mod.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/drivers/input/evdev.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/drivers/input/evdev.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/drivers/input/input.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/drivers/input/input.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/drivers/input/joydev.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/drivers/input/joydev.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/drivers/input/mousedev.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/drivers/input/mousedev.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/drivers/net/3c509.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/drivers/net/3c509.o
/lib/modules/2.4.8-ac12/kernel/drivers/net/bsd_comp.o
/lib/modules/2.4.8-ac12/kernel/drivers/net/dummy.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/drivers/net/eepro100.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/drivers/net/eepro100.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/drivers/net/ppp_async.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/drivers/net/ppp_async.o
/lib/modules/2.4.8-ac12/kernel/drivers/net/ppp_deflate.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/drivers/net/ppp_generic.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/drivers/net/ppp_generic.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/drivers/net/pppoe.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/drivers/net/pppoe.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/drivers/net/pppox.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/drivers/net/pppox.o
/lib/modules/2.4.8-ac12/kernel/drivers/net/slhc.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/drivers/parport/parport.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/drivers/parport/parport.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/drivers/parport/parport_pc.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/drivers/parport/parport_pc.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/drivers/pnp/isa-pnp.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/drivers/pnp/isa-pnp.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/drivers/scsi/sg.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/drivers/scsi/sg.o
/lib/modules/2.4.8-ac12/kernel/drivers/scsi/sr_mod.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/drivers/scsi/st.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/drivers/scsi/st.o
/lib/modules/2.4.8-ac12/kernel/drivers/sound/ac97_codec.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/drivers/sound/emu10k1/emu10k1.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/drivers/sound/emu10k1/emu10k1.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/drivers/sound/soundcore.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/drivers/sound/soundcore.o
/lib/modules/2.4.8-ac12/kernel/drivers/usb/dc2xx.o
/lib/modules/2.4.8-ac12/kernel/drivers/usb/hid.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/drivers/usb/scanner.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/drivers/usb/scanner.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/drivers/usb/usb-ohci.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/drivers/usb/usb-ohci.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/drivers/usb/usbcore.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/drivers/usb/usbcore.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/fs/autofs/autofs.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/fs/autofs/autofs.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/fs/autofs4/autofs4.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/fs/autofs4/autofs4.o
/lib/modules/2.4.8-ac12/kernel/fs/binfmt_aout.o
depmod: *** Unresolved symbols in /lib/modules/2.4.8-ac12/kernel/fs/fat/fat.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/fs/fat/fat.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/fs/isofs/isofs.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/fs/isofs/isofs.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/fs/lockd/lockd.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/fs/lockd/lockd.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/fs/minix/minix.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/fs/minix/minix.o
/lib/modules/2.4.8-ac12/kernel/fs/msdos/msdos.o
depmod: *** Unresolved symbols in /lib/modules/2.4.8-ac12/kernel/fs/nfs/nfs.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/fs/nfs/nfs.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/fs/nfsd/nfsd.o depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/fs/nfsd/nfsd.o
/lib/modules/2.4.8-ac12/kernel/fs/nls/nls_cp437.o
/lib/modules/2.4.8-ac12/kernel/fs/nls/nls_cp850.o
/lib/modules/2.4.8-ac12/kernel/fs/nls/nls_iso8859-1.o
/lib/modules/2.4.8-ac12/kernel/fs/nls/nls_iso8859-15.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/fs/romfs/romfs.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/fs/romfs/romfs.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/fs/smbfs/smbfs.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/fs/smbfs/smbfs.o
depmod: *** Unresolved symbols in /lib/modules/2.4.8-ac12/kernel/fs/udf/udf.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/fs/udf/udf.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/fs/vfat/vfat.o depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/fs/vfat/vfat.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/net/ipv4/netfilter/ip_conntrack.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/net/ipv4/netfilter/ip_conntrack.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/net/ipv4/netfilter/ip_conntrack_ftp.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/net/ipv4/netfilter/ip_conntrack_ftp.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/net/ipv4/netfilter/ip_nat_ftp.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/net/ipv4/netfilter/ip_nat_ftp.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/net/ipv4/netfilter/ip_tables.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/net/ipv4/netfilter/ip_tables.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/net/ipv4/netfilter/ipchains.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/net/ipv4/netfilter/ipchains.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/net/ipv4/netfilter/ipt_LOG.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/net/ipv4/netfilter/ipt_LOG.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/net/ipv4/netfilter/ipt_MASQUERADE.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/net/ipv4/netfilter/ipt_MASQUERADE.o
/lib/modules/2.4.8-ac12/kernel/net/ipv4/netfilter/ipt_REDIRECT.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/net/ipv4/netfilter/ipt_limit.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/net/ipv4/netfilter/ipt_limit.o
/lib/modules/2.4.8-ac12/kernel/net/ipv4/netfilter/ipt_state.o
/lib/modules/2.4.8-ac12/kernel/net/ipv4/netfilter/ipt_tos.o
/lib/modules/2.4.8-ac12/kernel/net/ipv4/netfilter/iptable_filter.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/net/ipv4/netfilter/iptable_nat.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/net/ipv4/netfilter/iptable_nat.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/net/ipv6/ipv6.odepmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/net/ipv6/ipv6.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/net/ipv6/netfilter/ip6_tables.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/net/ipv6/netfilter/ip6_tables.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/net/ipv6/netfilter/ip6t_limit.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/net/ipv6/netfilter/ip6t_limit.o
/lib/modules/2.4.8-ac12/kernel/net/ipv6/netfilter/ip6table_filter.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/net/khttpd/khttpd.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/net/khttpd/khttpd.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/net/packet/af_packet.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/net/packet/af_packet.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.8-ac12/kernel/net/sunrpc/sunrpc.o
depmod:         preempt_schedule
/lib/modules/2.4.8-ac12/kernel/net/sunrpc/sunrpc.o
/lib/modules/2.4.8-ac12/misc/mssclampfw.o
