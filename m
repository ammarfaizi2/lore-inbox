Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264242AbRFOEmo>; Fri, 15 Jun 2001 00:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264244AbRFOEm0>; Fri, 15 Jun 2001 00:42:26 -0400
Received: from paloma16.e0k.nbg-hannover.de ([62.159.219.16]:23491 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S264242AbRFOEmJ>; Fri, 15 Jun 2001 00:42:09 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: John Cavan <johnc@damncats.org>
Subject: Re: Linux 2.4.5-ac14
Date: Fri, 15 Jun 2001 06:55:57 +0200
X-Mailer: KMail [version 1.2.2]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        "DRI-Devel" <dri-devel@lists.sourceforge.net>,
        Alan Cox <alan@redhat.com>
In-Reply-To: <20010615022033Z261561-17720+4111@vger.kernel.org> <3B29734A.738A95D5@damncats.org> 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20010615044215Z264242-17720+4117@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 15. Juni 2001 05:32 schrieb Dieter Nützel:
> Am Freitag, 15. Juni 2001 04:30 schrieb John Cavan:
> > Dieter Nützel wrote:
> > > Hello Alan,
> > >
> > > I see 4.29 GB under shm with your latest try.
> > > something wrong?
> >
> >         total:    used:    free:  shared: buffers:  cached:
> > Mem:  1053483008 431419392 622063616   122880 24387584 260923392
> > Swap: 394764288        0 394764288
> > MemTotal:      1028792 kB
> > MemFree:        607484 kB
> > MemShared:         120 kB
> > Buffers:         23816 kB
> > Cached:         254808 kB
> > Active:         225536 kB
> > Inact_dirty:     53208 kB
> > Inact_clean:         0 kB
> > Inact_target:       44 kB
> > HighTotal:      131056 kB
> > HighFree:         1048 kB
> > LowTotal:       897736 kB
> > LowFree:        606436 kB
> > SwapTotal:      385512 kB
> > SwapFree:       385512 kB
> >
> > I don't seem to have the problem...
>
> You are using HIGHMEM?!

I tested some more and found this.

It is XFree86 4.1.0 DRI (tdfx driver) related.
During my first run I used the 2.4.5-ac14 kernel DRM module.
Now I am running with the latest DRI trunk DRM module.
Both show the same symptoms.

After system and first Xserver start everything is fine.

SunWave1>cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  327802880 256114688 71688192   487424 60665856 106491904
Swap: 1052794880        0 1052794880
MemTotal:       320120 kB
MemFree:         70008 kB
MemShared:         476 kB
Buffers:         59244 kB
Cached:         103996 kB
Active:         156332 kB
Inact_dirty:      7384 kB
Inact_clean:         0 kB
Inact_target:     1092 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       320120 kB
LowFree:         70008 kB
SwapTotal:     1028120 kB
SwapFree:      1028120 kB

Then after the first DRI (OpenGL/Mesa) app was running I get this:

SunWave1>l /dev/dri/card0
crw-rw----    1 root     video    226,   0 Jun 15 06:40 /dev/dri/card0

NO double /dev/dri entry. OK.

SunWave1>cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  327802880 222384128 105418752 4294873088  2973696 168341504
Swap: 1052794880 72327168 980467712
MemTotal:       320120 kB
MemFree:        102948 kB
MemShared:    4294967204 kB
Buffers:          2904 kB
Cached:         164396 kB
Active:         124212 kB
Inact_dirty:      3692 kB
Inact_clean:     39304 kB
Inact_target:       76 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       320120 kB
LowFree:        102948 kB
SwapTotal:     1028120 kB
SwapFree:       957488 kB

4.29 GB shm...

SunWave1>cat /proc/dri/0/*
a dev   pid    uid      magic     ioctls
 
y   0   693     0          0         25
                  total counts                   |    outstanding
type       alloc freed fail     bytes      freed | allocs      bytes
 
system        0     0    0     320120 kB         |
locked        0     0    0          0 kB         |
 
dmabufs       0     0    0          0          0 |      0          0
sareas        0     0    0          0          0 |      0          0
driver        2     0    0         25          0 |      2         25
magic         1     0    0         12          0 |      1         12
ioctltab      0     0    0          0          0 |      0          0
maplist      10     2    0        144         12 |      8        132
vmalist       8     7    0         96         84 |      1         12
buflist       0     0    0          0          0 |      0          0
seglist       0     0    0          0          0 |      0          0
pagelist      0     0    0          0          0 |      0          0
files         2     1    0         80         40 |      1         40
queues        0     0    0          0          0 |      0          0
commands      0     0    0          0          0 |      0          0
mappings      2     0    0  100663296          0 |      2  100663296
buflists      0     0    0          0          0 |      0          0
agplist       0     0    0          0          0 |      0          0
totalagp      0     0    0          0          0 |      0          0
boundagp      0     0    0          0          0 |      0          0
ctxbitmap     1     0    0       4096          0 |      1       4096
stub          1     0    0        192          0 |      1        192
tdfx 0xe200 PCI:1:5:0
  ctx/flags   use   fin   blk/rw/rwf  wait    flushed      queued      locks
 
slot     offset       size type flags    address mtrr
 
   0 0xd8000000 0x02000000  REG  0x00 0xd9099000 none
   1 0xe0000000 0x04000000   FB  0x00 0xd5098000    3
   2 0xd5096000 0x00001000  SHM  0x20 0xd5096000 none
vma use count: 1, high_memory = d3ff0000, 0x13ff0000
 
  693 0x46182000-0x46183000 rw-sl- 0xd5096000 pwubca-kl

Who is to blame?
XFree? DRI? Kernel?

-Dieter
