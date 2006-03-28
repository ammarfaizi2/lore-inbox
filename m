Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbWC1Bxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWC1Bxv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 20:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWC1Bxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 20:53:51 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:60548 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751098AbWC1Bxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 20:53:50 -0500
Subject: OOM kills if swappiness set to 0, swap storms otherwise
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 27 Mar 2006 20:53:47 -0500
Message-Id: <1143510828.1792.353.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am simply trying to run a Gnome desktop (Gnome 2.14, Evolution,
Firefox, gtk-gnutella usually open) without swapping or getting OOM
killed.

I have to set the swappiness to 0 or else I get swap storms when simply
browsing the web and reading my mail.  I think this is insane as I have
512MB of RAM.  It seems as if the kernel will OOM kill firefox rather
than shrink the file cache!

What is the problem here?  Is the modern Linux desktop really too
bloated to run in half a gig of RAM, or is the kernel overzealous with
its OOM killing?

Lee

oom-killer: gfp_mask=0x280d2, order=0
Mem-info:
DMA per-cpu:
cpu 0 hot: high 0, batch 1 used:0
cpu 0 cold: high 0, batch 1 used:0
DMA32 per-cpu: empty
Normal per-cpu:
cpu 0 hot: high 186, batch 31 used:23
cpu 0 cold: high 62, batch 15 used:46
HighMem per-cpu: empty
Free pages:        4476kB (0kB HighMem)
Active:84715 inactive:9418 dirty:0 writeback:0 unstable:0 free:1119
slab:4615 mapped:93948 pagetables:662
DMA free:1252kB min:96kB low:120kB high:144kB active:0kB inactive:0kB
present:16384kB pages_scanned:10238 all_unreclaimable? yes
lowmem_reserve[]: 0 0 431 431
DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 431 431
Normal free:3224kB min:2608kB low:3260kB high:3912kB active:338860kB
inactive:37672kB present:442304kB pages_scanned:61895 all_unreclaim
able? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 3*4kB 3*8kB 2*16kB 1*32kB 2*64kB 2*128kB 1*256kB 1*512kB 0*1024kB
0*2048kB 0*4096kB = 1252kB
DMA32: empty
Normal: 174*4kB 28*8kB 0*16kB 2*32kB 1*64kB 1*128kB 0*256kB 0*512kB
0*1024kB 1*2048kB 0*4096kB = 3224kB
HighMem: empty
Swap cache: add 635780, delete 617326, find 164667/241301, race 0+0
Free swap  = 315164kB
Total swap = 499928kB
Free swap:       315164kB
114672 pages of RAM
0 pages of HIGHMEM
5150 reserved pages
41086 pages shared
18438 pages swap cached
0 pages dirty
0 pages writeback
93765 pages mapped
4615 pages slab
662 pages pagetables
Out of Memory: Killed process 32663 (firefox-bin).

rlrevell@mindpipe:~$ vmstat 1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2  0 248992   5612   4072  75268    3    2    41    49   12    33 82  4 14  1
 0  0 248992   5364   4084  75300    0    0     0   128 1273   640 34  3 63  0
 0  0 248992   5356   4084  75464    0    0     0     0 1257   611 23  4 73  0
 0  0 248992   5356   4084  75496    0    0     0     0 1292   635 21  2 77  0
 0  0 248992   5356   4084  75532    0    0     0     0 1277   599 22  3 75  0
 0  0 248992   5356   4084  75532    0    0     0     0 1270   610 23  2 75  0
 1  0 248992   5232   4092  75564    0    0     0   200 1274   596 21  2 77  0
 0  0 248992   5232   4092  75564    0    0     0     0 1280   648 22  2 76  0
 0  0 248992   5108   4092  75696    0    0     0     0 1296   621 21  4 75  0

USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
rlrevell  1792  4.1 37.9 320340 166724 ?       Sl   Mar21 353:33 evolution --component=mail
rlrevell  2298  9.2 18.9 200556 83112 ?        Sl   15:16  30:55 /usr/lib/firefox/firefox-bin -a firefox
rlrevell  1794  0.0  2.1  92704  9344 ?        Sl   Mar21   0:47 /usr/lib/evolution/evolution-data-server-1.6 --oaf-activate-iid=OAFIID:GNOME_Evolution_DataServer_InterfaceCheck --oaf-ior-fd=41
pdnsd    10545  0.0  0.1  75676   600 ?        Sl   18:55   0:00 /usr/sbin/pdnsd --daemon -p /var/run/pdnsd.pid
rlrevell  1805  0.0  0.6  65236  2740 ?        Sl   Mar21   0:06 /usr/lib/evolution/2.6/evolution-alarm-notify --oaf-activate-iid=OAFIID:GNOME_Evolution_Calendar_AlarmNotify_Factory:2.6 --oaf-ior-fd=43
root      2295 70.3  4.5  58160 19908 tty7     Ss+  Mar18 9207:34 /usr/bin/X :0 -br -audit 0 -auth /var/lib/gdm/:0.Xauth -nolisten tcp vt7
rlrevell  2759  0.0  1.0  57716  4832 ?        Ssl  Mar18   2:48 nautilus --sm-config-prefix /nautilus-kFkhxG/ --sm-client-id 106281f446000113283283500000043730002 --screen 0 --no-default-window
rlrevell  2749  0.0  0.5  33720  2404 ?        Sl   Mar18   3:09 /usr/lib/control-center/gnome-settings-daemon --oaf-activate-iid=OAFIID:GNOME_SettingsDaemon --oaf-ior-fd=25
rlrevell 11452 17.2  3.9  31828 17348 ?        S    20:15   5:49 gtk-gnutella
rlrevell  2934  0.1  1.7  28736  7548 ?        Sl   Mar18  20:09 /usr/lib/gnome-panel/wnck-applet --oaf-activate-iid=OAFIID:GNOME_Wncklet_Factory --oaf-ior-fd=33
rlrevell 11751  0.0  0.1  27180   524 pts/0    S+   20:49   0:00 sort -k5 -rn
rlrevell  2757  0.0  1.8  24220  8148 ?        Ssl  Mar18   5:54 gnome-panel --sm-config-prefix /gnome-panel-daqxPK/ --sm-client-id 106281f446000113283283400000043730001 --screen 0
rlrevell  2785  0.0  0.7  20784  3400 ?        S    Mar18   1:10 /usr/lib/gnome-panel/clock-applet --oaf-activate-iid=OAFIID:GNOME_ClockApplet_Factory --oaf-ior-fd=35
rlrevell  2669  0.0  0.6  17212  2704 ?        Ss   Mar18   0:22 x-session-manager
rlrevell  2783  0.0  0.5  15288  2328 ?        S    Mar18   0:17 /usr/lib/gnome-panel/notification-area-applet --oaf-activate-iid=OAFIID:GNOME_NotificationAreaApplet_Factory --oaf-ior-fd=34
rlrevell 11453  0.0  0.1  14088   480 ?        S    20:15   0:00 DNS helper for gtk-gnutella
rlrevell  2860  0.0  0.5  13732  2512 ?        Ss   Mar18   2:29 gnome-screensaver
rlrevell  2755  0.1  1.1  13484  5216 ?        Ss   Mar18  13:17 metacity --sm-save-file 1132974963-4486-1014928945.ms
root      2291  0.0  0.0  10148   388 ?        S    Mar18   0:04 /usr/sbin/gdm
root      2286  0.0  0.0   9668   256 ?        Ss   Mar18   0:00 /usr/sbin/gdm


