Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262626AbTJ3Qoa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 11:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262647AbTJ3Qoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 11:44:30 -0500
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:59473 "EHLO
	floyd.gotontheinter.net") by vger.kernel.org with ESMTP
	id S262626AbTJ3Qo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 11:44:26 -0500
Subject: Re: 2.4.23-preX oops and strange swappiness (nforce2 mobo)
From: Disconnect <lkml@sigkill.net>
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1067270203.4503.9.camel@slappy>
References: <1067270203.4503.9.camel@slappy>
Content-Type: text/plain
Message-Id: <1067532242.31027.4.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 30 Oct 2003 11:44:03 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updated info: I dropped the swap partition to 512M instead of 2G and it
seems to have stablized nicely.

At least, its been a day and a half without an oops, which is a record
for this machine...

On Mon, 2003-10-27 at 10:56, Disconnect wrote:
> Unfortunately, I really shouldn't run without nvnet so if thats a known
> issue then its not in google ;)  (If its highly likely to be related I
> can try it this week; it means I end up downing my wlan..)
> 
> It doesn't take long - couple of days at most - before there are a
> couple of oopses in the logs (decodes below) and swap usage begins
> climbing without ever being reclaimed.  (Similar problems occurred in
> 2.4.23-pre5, with the added bonus of processes cratering out in D state
> and never going away.)
> 
> These are from an unpatched 2.4.23-pre8:
> [10:49:24] [dis@floyd] $ uptime
>  10:49:26 up 2 days, 30 min,  2 users,  load average: 1.56, 1.57, 1.49
> [10:49:26] [dis@floyd] $ free
>              total       used       free     shared    buffers     cached
> Mem:        256932     254736       2196          0      13804      64932
> -/+ buffers/cache:     176000      80932
> Swap:      2000084     443248    1556836
> [10:49:27] [dis@floyd] $ cat /proc/slabinfo
> slabinfo - version: 1.1
> kmem_cache            62     72    108    2    2    1
> ip_conntrack         255    804    320   67   67    1
> fib6_nodes            12    112     32    1    1    1
> ip6_dst_cache         13     20    192    1    1    1
> ndisc_cache            3     30    128    1    1    1
> tcp_tw_bucket          6     30    128    1    1    1
> tcp_bind_bucket       72    448     32    4    4    1
> tcp_open_request       0     30    128    0    1    1
> inet_peer_cache        3     59     64    1    1    1
> ip_fib_hash           13    112     32    1    1    1
> ip_dst_cache        1850   1920    192   96   96    1
> arp_cache             22     30    128    1    1    1
> blkdev_requests     3072   3090    128  103  103    1
> journal_head        1468   5236     48   55   68    1
> revoke_table           3    250     12    1    1    1
> revoke_record          0    112     32    0    1    1
> dnotify_cache          0      0     20    0    0    1
> file_lock_cache       20     42     92    1    1    1
> fasync_cache           0      0     16    0    0    1
> uid_cache             12    112     32    1    1    1
> skbuff_head_cache    225    780    192   39   39    1
> sock                 240    336    896   83   84    1
> sigqueue               0     29    132    0    1    1
> kiobuf                 0      0     64    0    0    1
> cdev_cache            16    118     64    2    2    1
> bdev_cache             5     59     64    1    1    1
> mnt_cache             13     59     64    1    1    1
> inode_cache         6821   6825    512  975  975    1
> dentry_cache        5297   5310    128  177  177    1
> filp                2374   2400    128   80   80    1
> names_cache            0      2   4096    0    2    1
> buffer_head        17182  17790    128  592  593    1
> mm_struct             76     90    128    3    3    1
> vm_area_struct      3811   3930    128  131  131    1
> fs_cache              73    118     64    2    2    1
> files_cache           74     81    448    9    9    1
> signal_act            89     90   1344   30   30    1
> size-131072(DMA)       0      0 131072    0    0   32
> size-131072            0      0 131072    0    0   32
> size-65536(DMA)        0      0  65536    0    0   16
> size-65536             1      1  65536    1    1   16
> size-32768(DMA)        0      0  32768    0    0    8
> size-32768             4      4  32768    4    4    8
> size-16384(DMA)        0      0  16384    0    0    4
> size-16384             8      8  16384    8    8    4
> size-8192(DMA)         0      0   8192    0    0    2
> size-8192              2      2   8192    2    2    2
> size-4096(DMA)         0      0   4096    0    0    1
> size-4096            150    201   4096  150  201    1
> size-2048(DMA)         0      0   2048    0    0    1
> size-2048             63     78   2048   35   39    1
> size-1024(DMA)         0      0   1024    0    0    1
> size-1024             85     88   1024   22   22    1
> size-512(DMA)          0      0    512    0    0    1
> size-512             146    152    512   19   19    1
> size-256(DMA)          0      0    256    0    0    1
> size-256             517    525    256   35   35    1
> size-128(DMA)          0      0    128    0    0    1
> size-128            1810   1830    128   61   61    1
> size-64(DMA)           0      0     64    0    0    1
> size-64             3467   3481     64   59   59    1
> size-32(DMA)           0      0     64    0    0    1
> size-32             1612   2301     64   39   39    1
> [10:51:34] [dis@floyd] $ lsmod
> Module                  Size  Used by    Tainted: P
> ipt_mark                 472  46
> ipt_state                568   0 (unused)
> ipt_mac                  696   2
> ip_nat_irc              2192   0 (unused)
> ip_conntrack_irc        3056   1
> ip_conntrack_ftp        4016   1 (autoclean)
> ip_nat_ftp              2864   0 (unused)
> iptable_filter          1772   1
> iptable_mangle          2168   1
> ipt_LOG                 3416   0 (unused)
> ipt_TOS                 1048   0 (unused)
> ipt_REJECT              3544   0 (unused)
> ipt_MARK                 792   3
> ipt_MASQUERADE          1464   8
> ipt_REDIRECT             824   4
> iptable_nat            16014   3 [ip_nat_irc ip_nat_ftp ipt_MASQUERADE ipt_REDIRECT]
> ip_conntrack           19908   4 [ipt_state ip_nat_irc ip_conntrack_irc ip_conntrack_ftp ip_nat_ftp ipt_MASQUERADE ipt_REDIRECT iptable_nat]
> ip_tables              12288  14 [ipt_mark ipt_state ipt_mac iptable_filter iptable_mangle ipt_LOG ipt_TOS ipt_REJECT ipt_MARK ipt_MASQUERADE ipt_REDIRECT iptable_nat]
> nfsd                   72880   8 (autoclean)
> lockd                  50928   1 (autoclean) [nfsd]
> sunrpc                 68736   1 (autoclean) [nfsd lockd]
> sd_mod                 11084   0 (autoclean) (unused)
> sg                     27516   0 (autoclean) (unused)
> sr_mod                 15576   0 (autoclean) (unused)
> scsi_mod               85760   3 (autoclean) [sd_mod sg sr_mod]
> ide-cd                 32032   0 (autoclean)
> cdrom                  28320   0 (autoclean) [sr_mod ide-cd]
> hid                    21572   0 (unused)
> usbmouse                2264   0 (unused)
> ehci-hcd               17260   0 (unused)
> nvnet                  26272   1
> ipv6                  167124  -1
> tulip                  40608   1
> crc32                   2880   0 [tulip]
> usbkbd                  3640   0 (unused)
> usb-ohci               18888   0 (unused)
> usbcore                62892   1 [hid usbmouse ehci-hcd usbkbd usb-ohci]
> 
> Crash dump and config attached - if you need anything else let me know.
> 
> (I'm on the list, no need to CC)
> 
> Thanks!
-- 
Disconnect <lkml@sigkill.net>

