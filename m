Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318728AbSHERTp>; Mon, 5 Aug 2002 13:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318731AbSHERTp>; Mon, 5 Aug 2002 13:19:45 -0400
Received: from mail01d.rapidsite.net ([207.158.192.52]:40991 "HELO
	mail01d.rapidsite.net") by vger.kernel.org with SMTP
	id <S318728AbSHERTn>; Mon, 5 Aug 2002 13:19:43 -0400
Message-ID: <3D4EB494.3050406@theworld.com>
Date: Mon, 05 Aug 2002 13:23:32 -0400
From: John Muir Kumph <ninjo@theworld.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.1a) Gecko/20020611
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: un killable processes - stuck file system
References: <3D482E45.2040809@theworld.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Loop-Detect: 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm posting a follow-up to my original difficulty - because
the problem has become more um... interesting.

So I didn't reboot the system descibed below, until last
Friday night.   Rather an electrical storm took out power
to a good number of people in the New York region - including
me...

This Monday I noticed a great many corrupted files - with
much more corruption than I had hoped from a journalling
file system.  It seemed that something was terribly wrong.

Looking back at the logs I found:

Jul 31 08:39:27 lurch kernel: reiserfs: journal-837: IO error during
journal updat
e
Jul 31 08:39:27 lurch kernel: Process kupdated (pid: 7, stackpage=cffd5000)
Jul 31 08:39:27 lurch kernel:    [sync_supers+218/268]
[sync_old_buffers+12/64] [k
update+217/252] [kernel_thread+40/56]

I then ran the system for 3 days and then it was shutdown
by the power failure (it was a long one-several hours).

Could it be that the system ran without kupdated?  Looks like
the daemon might've exited from the system log.

If it did, would the disk buffers be horribly out of date -
and cause all the carnage when the system was shutdown
by the power failure?

I'm trying to play detective here so that this doesn't
happen again - to me or someone else.

--John

John Muir Kumph wrote:
 > Forgive me if this is the wrong place to send this bug report - but
 > here goes:
 >
 > I have a DVD-RAM with an IDE interface - currently /dev/hdc.
 > I foolishly ejected the disk while it was still mounted and
 > flipped the write protect tab - and lo!:
 >
 > cat > foo.tmp failed and got stuck
 >
 > In fact nothing could kill this process now listed as D.
 >
 > In fact the drive now can't be mounted or unmounted.  I
 > did some reading and it appears that a forced mount or
 > lazy mount might work - but umount -f fails with:
 >
 > umount2: Device or resource busy
 > umount: /dev/hdc: not mounted
 > umount: /media/cdrom: Illegal seek
 >
 > I'm sure that if I reboot - all will be fine...  But
 > we try to avoid rebooting
 >
 > Seems like:
 > - one shouldn't be able to eject media that's mounted
 > - if one does - it shouldn't take down the device
 > - if it does take down the device - it'd be nice to be
 >   able to fix it without rebooting
 >
 > I'll monitor the list for any questions - but feel free to
 > email too and I'll post a summary of the answers.
 >
 > John Muir Kumph
 >
 > Output of scripts/ver_linux
 > Linux lurch 2.4.18-4GB #1 Wed Mar 27 13:57:05 UTC 2002 i686 unknown
 >
 > Gnu C                  2.95.3
 > Gnu make               3.79.1
 > util-linux             2.11n
 > mount                  2.11n
 > modutils               2.4.12
 > e2fsprogs              1.26
 > PPP                    2.4.1
 > isdn4k-utils           3.1pre4
 > Linux C Library        x    1 root     root      1394238 Mar 23 13:34
 > /lib/libc.so
 > .6
 > Dynamic linker (ldd)   2.2.5
 > Procps                 2.0.7
 > Net-tools              1.60
 > Kbd                    1.06
 > Sh-utils               2.0
 > Modules Loaded         vmnet vmppuser vmmon iptable_mangle iptable_nat
 > ip_conntrac
 > k iptable_filter ip_tables nls_iso8859-1 ntfs vfat fat snd-pcm-oss
 > snd-mixer-oss p
 > arport_pc lp parport snd-cmipci snd-pcm snd-opl3-lib snd-hwdep snd-timer
 > snd-mpu40
 > 1-uart snd-rawmidi snd-seq-device snd soundcore ipv6 isa-pnp st sg
 > usb-storage joy
 > dev evdev input usb-uhci usbcore af_packet 8139too mii reiserfs
 >




