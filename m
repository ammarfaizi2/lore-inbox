Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBCOQC>; Sat, 3 Feb 2001 09:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129056AbRBCOPx>; Sat, 3 Feb 2001 09:15:53 -0500
Received: from atlante.atlas-iap.es ([194.224.1.3]:5129 "EHLO
	atlante.atlas-iap.es") by vger.kernel.org with ESMTP
	id <S129051AbRBCOPp>; Sat, 3 Feb 2001 09:15:45 -0500
From: "Ricardo Galli" <gallir@uib.es>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.1 eats RAM  or /proc/meminfo  bug
Date: Sat, 3 Feb 2001 15:15:38 +0100
Message-ID: <LOEGIBFACGNBNCDJMJMOMENFCDAA.gallir@uib.es>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed in my server that the memory consumption with 2.4.1 it much higher
than 2.2.18 and it gets worse over time.

Free was reporting up to 140MB of RAM with no user/X session (50-60MB with
2.2.18, same software). I've upgraded to procps 2.0.7, but the problem
persists. After few minutes of rebooting the server, the memory usage was
40-50MB, but after 24 hours the used memory grew to 120MB. I though it could
be Apache or Postgres servers, so I've stopped them but the memory decreased
just few megabytes.

I did then another check, I summed the RSS of all processes (which should
give more than free) and it is reporting _less_ that free.

Find the figures and sys info below. Please note that the used memory it's
about 120MB, with 2.2.x it never passed 60MB with the same conf.

[root@m3d /root]# uname -a
Linux m3d.uib.es 2.4.1 #2 Thu Feb 1 12:22:17 MET 2001 i686 unknown

[root@m3d /root]# free -V
procps version 2.0.7

[root@m3d /root]# free
             total       used       free     shared    buffers     cached
Mem:        255340     232444      22896          0      16988      93212
-/+ buffers/cache:     122244     133096
Swap:       208804          0     208804

[root@m3d /root]# cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  261468160 238030848 23437312        0 17395712 95453184
Swap: 213815296        0 213815296
MemTotal:       255340 kB
MemFree:         22888 kB
MemShared:           0 kB
Buffers:         16988 kB
Cached:          93216 kB
Active:          15424 kB
Inact_dirty:     92172 kB
Inact_clean:      2608 kB
Inact_target:       60 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       255340 kB
LowFree:         22888 kB
SwapTotal:      208804 kB
SwapFree:       208804 kB

[root@m3d /proc]# modprobe -l
/lib/modules/2.4.1/kernel/drivers/net/dummy.o
/lib/modules/2.4.1/kernel/drivers/net/eepro100.o
/lib/modules/2.4.1/kernel/drivers/parport/parport.o
/lib/modules/2.4.1/kernel/drivers/parport/parport_pc.o
/lib/modules/2.4.1/kernel/drivers/sound/ac97_codec.o
/lib/modules/2.4.1/kernel/drivers/sound/ad1848.o
/lib/modules/2.4.1/kernel/drivers/sound/es1370.o
/lib/modules/2.4.1/kernel/drivers/sound/es1371.o
/lib/modules/2.4.1/kernel/drivers/sound/esssolo1.o
/lib/modules/2.4.1/kernel/drivers/sound/maestro.o
/lib/modules/2.4.1/kernel/drivers/sound/mpu401.o
/lib/modules/2.4.1/kernel/drivers/sound/sound.o
/lib/modules/2.4.1/kernel/drivers/sound/soundcore.o
/lib/modules/2.4.1/kernel/drivers/sound/sscape.o
/lib/modules/2.4.1/kernel/fs/msdos/msdos.o
/lib/modules/2.4.1/kernel/fs/vfat/vfat.o


[root@m3d /root]#  ps axlh |  awk '{i+=$7; j+=$8}; END{ print i, j }'
254592 99748

Note in the last command that the total RSS is lower thet the used memory
reported by free/meminfo. The machine is a plain PIII with IDE disks adn
3Com905 etherboard.

Just tell me if you need for info or reports.

Regards.

--ricardo
http://m3d.uib.es/~gallir/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
