Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267508AbSLLVLc>; Thu, 12 Dec 2002 16:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267509AbSLLVLc>; Thu, 12 Dec 2002 16:11:32 -0500
Received: from dial-213-168-73-241.netcologne.de ([213.168.73.241]:5099 "EHLO
	antity.dummy.de") by vger.kernel.org with ESMTP id <S267508AbSLLVLa>;
	Thu, 12 Dec 2002 16:11:30 -0500
Date: Thu, 12 Dec 2002 22:19:54 +0100
From: Johnny =?iso-8859-1?Q?Teve=DFen?= <j.tevessen@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.4.x hanging in CPU init(?) and memory size strangeness
Message-ID: <20021212211954.GA28604@antity.dummy.de>
Mail-Followup-To: Johnny =?iso-8859-1?Q?Teve=DFen?= <j.tevessen@gmx.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-ZC-PGP-KEY-AVAIL: http://netcat.upb.de:11371/pks/lookup?op=get&search=0x5C77B04D
X-GPG-KeyID: 0x5C77B04D
X-GPG-Fingerprint: 0E F9 6C 8B E4 DB 46 09  46 3C 25 DE E0 8B 56 C6
X-GPG-Key: http://netcat.upb.de:11371/pks/lookup?op=get&search=0x5C77B04D
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(According to REPORTING-BUGS, although I'm not sure whether it's
a bug or not or what is happening at all)

Dear core developers,

I just experienced something rather strange with a 2.4.19pre8 kernel
(yes, 2.4.20 is installed but I didn't update all dependent modules
yet and since I wasn't able to find something about this in a
Changelog, it's probably the same effect with 2.4.20):

WindowsXP running, reset, LILO, boot to 2.4.19pre8 with "mem=nopentium"
set. CPU is:

  vendor_id	: AuthenticAMD
  cpu family	: 6
  model		: 8
  model name	: AMD Athlon(tm) XP 2200+
  stepping	: 0
  cpu MHz	: 1794.951

Well, for the first time (I've been using this kernel for quite
a while now), Linux hung on bootup, somewhere within CPU initialization,
I think (see below). This was reproducable with several hard-resets -
Always the same. When I physically switched off power, waited some
seconds and restarted my hardware from-scratch, Linux booted again.

Please note that while the CPU (or whatever) was in this special
state, even WindowsXP wouldn't boot anymore. According to
motherboard diagnostics (Epox 8K7A+), CPU temperature was always
around 45, 46 degrees C. All fans are working, no OC or similar dirt.

Here's my dmesg output after the first successful boot after
the cold-restart:

  Memory: 126776k/131008k available (1050k kernel code, 3844k reserved, 272k
  data, 212k init, 0k highmem)
  Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
  Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
  Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
  Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
  Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
[**Here** is where booting always stopped before]
  CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
  CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
  CPU: L2 Cache: 256K (64 bytes/line)
  CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
  Intel machine check architecture supported.
  Intel machine check reporting enabled on CPU#0.

Please note that this kernel only recognized 128MB of memory at the
moment, but both /proc/meminfo and and free(1) state that I
have in fact 256MB installed:

          total:    used:    free:  shared: buffers:  cached:
  Mem:  263147520 258695168  4452352        0 130617344 29917184
  Swap: 419446784 31510528 387936256
               total       used       free     shared    buffers     cached
  Mem:        256980     252240       4740          0     127692      25024
  -/+ buffers/cache:      99524     157456
  Swap:       409616      30772     378844

There is a single 256MB brick installed on the board (DDR RAM).
Second question: How is it possible that the kernel only "sees"
128MB but later uses 256MB without problems?

What exactly is happening between initializing the page cache
and "vendor init" that could lead the kernel to quietly halt
within the boot process? I tried to trace it from init/main.c,
but it seems I'm not good enough in this code yet.

kind regards from Cologne/Germany
johannes

Linux aris.dummy.de 2.4.19-pre8 #1 Sam Mai 4 18:10:42 CEST 2002 i686 unknown
 
Gnu C                  3.2
Gnu make               3.80rc2
util-linux             2.11f
mount                  2.11g
modutils               2.4.2
e2fsprogs              1.23
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.33
PPP                    2.4.0
isdn4k-utils           3.1pre1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Linux C++ Library      5.0.0
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         snd-emu10k1 snd-ac97-codec snd-rawmidi snd-seq-device
snd-util-mem snd-hwdep agpgart NVdriver usb-storage snd-pcm-oss snd-pcm
snd-timer snd-mixer-oss snd sound tvmixer soundcore tuner tvaudio msp3400
bttv videodev i2c-algo-bit i2c-core 8139too mii ipt_REJECT ipt_limit
ipt_state ipt_LOG ip_conntrack_ftp iptable_mangle iptable_nat ip_conntrack
iptable_filter ip_tables ipv6 ide-cd ide-scsi scsi_mod cdrom nls_cp437 vfat
fat nls_iso8859-1 ntfs usb-uhci usbcore
