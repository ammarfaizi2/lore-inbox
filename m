Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272136AbTHIA2f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 20:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272144AbTHIA2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 20:28:35 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:21007
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S272136AbTHIA2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 20:28:20 -0400
Date: Fri, 8 Aug 2003 17:28:17 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test2-mm1
Message-ID: <20030809002817.GA1027@matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030727233716.56fb68d2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030727233716.56fb68d2.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 27, 2003 at 11:37:16PM -0700, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test2/2.6.0-test2-mm1/
> 
> - More CPU scheduler tweaks.
> 
> - Some changes to the VM which are designed to further reduce the amount of
>   writeout which happens off the tail of the page LRU.
> 
>   Some small benefits have been observed in the usual benchmarks.  Needs
>   careful testing.
> 
> - Various other fixes from various people.

Hi there Andrew.

I have 2.6.0-test2-mm1 running on two (XP2600 & PII300 named 10.6) machines in this
scenario, and a pIII500 named fs running 2.4.20-rmap15e-fs196-1.4, and a
PIII550 named 10.4 running 2.4.21-rc1-rmap15g.

I have the xp2600 copying large directory trees from each of the three
systems over the network.

I get nfs errors from the activity with the 2.4 systems, but not from the
slowest system that's also running 2.6.

I also got an error "NFS: giant filename in readdir (len                 
792b9a88)!" but it doesn't attribute it to a certain client...

I see this all the time on my 2.4 nfs clients too, so it's not 2.6 specific.
Though it was interesting that there weren't any errors reported from the
2.6 nfs server.

Anyway, I'd like to know what the trouble is with this that I've been having
for a while now.

Thanks

xp2600:
00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge
00:0a.0 VGA compatible controller: Trident Microsystems TGUI 9660/938x/968x
(rev d3)
00:0e.0 RAID bus controller: CMD Technology Inc PCI0680 (rev 02)
00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus
Master IDE (rev 06)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)


xp2600 syslog:
Aug  8 16:55:18 srv-lr2600 kernel: nfs: server 10.4 OK
Aug  8 16:56:22 srv-lr2600 kernel: nfs: server 10.4 not responding, still
trying
Aug  8 16:56:22 srv-lr2600 kernel: nfs: server 10.4 OK
Aug  8 16:56:47 srv-lr2600 kernel: nfs: server fs not responding, still trying
Aug  8 16:56:47 srv-lr2600 kernel: nfs: server fs OK
Aug  8 16:56:50 srv-lr2600 kernel: nfs: server fs not responding, still trying
Aug  8 16:56:50 srv-lr2600 kernel: nfs: server fs OK
Aug  8 16:57:15 srv-lr2600 kernel: nfs: server 10.4 not responding, still
trying
Aug  8 16:57:15 srv-lr2600 kernel: nfs: server 10.4 OK
Aug  8 16:57:17 srv-lr2600 kernel: nfs: server 10.4 not responding, still
trying
Aug  8 16:57:17 srv-lr2600 kernel: nfs: server 10.4 OK
Aug  8 16:57:21 srv-lr2600 kernel: nfs: server 10.4 not responding, still
trying
Aug  8 16:57:21 srv-lr2600 kernel: nfs: server 10.4 OK
Aug  8 16:57:31 srv-lr2600 kernel: nfs: server 10.4 not responding, still
trying
Aug  8 16:57:31 srv-lr2600 kernel: nfs: server 10.4 not responding, still
trying
Aug  8 16:57:31 srv-lr2600 kernel: nfs: server 10.4 OK
Aug  8 16:57:31 srv-lr2600 kernel: nfs: server 10.4 OK
Aug  8 16:57:51 srv-lr2600 kernel: nfs: server fs not responding, still trying
Aug  8 16:57:51 srv-lr2600 kernel: nfs: server fs OK
Aug  8 16:58:42 srv-lr2600 kernel: nfs: server fs not responding, still trying
Aug  8 16:58:42 srv-lr2600 kernel: nfs: server fs OK
Aug  8 16:58:54 srv-lr2600 kernel: nfs: server 10.4 not responding, still
trying
Aug  8 16:58:54 srv-lr2600 kernel: nfs: server 10.4 OK
Aug  8 16:59:07 srv-lr2600 kernel: nfs: server 10.4 not responding, still
trying
Aug  8 16:59:07 srv-lr2600 kernel: nfs: server 10.4 OK
Aug  8 16:59:50 srv-lr2600 kernel: nfs: server fs not responding, still trying
Aug  8 16:59:50 srv-lr2600 kernel: nfs: server fs OK
Aug  8 16:59:51 srv-lr2600 kernel: nfs: server fs not responding, still trying
Aug  8 16:59:51 srv-lr2600 kernel: nfs: server fs OK
Aug  8 17:00:58 srv-lr2600 kernel: nfs: server fs not responding, still trying
Aug  8 17:00:58 srv-lr2600 kernel: nfs: server fs OK
Aug  8 17:01:22 srv-lr2600 kernel: nfs: server 10.4 not responding, still
trying
Aug  8 17:01:22 srv-lr2600 kernel: nfs: server 10.4 OK
Aug  8 17:01:26 srv-lr2600 kernel: NFS: giant filename in readdir (len
792b9a88)!
Aug  8 17:01:59 srv-lr2600 kernel: nfs: server 10.4 not responding, still
trying
Aug  8 17:01:59 srv-lr2600 last message repeated 2 times
Aug  8 17:01:59 srv-lr2600 kernel: nfs: server 10.4 OK
Aug  8 17:01:59 srv-lr2600 last message repeated 2 times
Aug  8 17:02:11 srv-lr2600 kernel: nfs: server fs not responding, still trying
Aug  8 17:02:11 srv-lr2600 kernel: nfs: server fs OK

vmstat:
 0  2      0   7552 1478928  32724    0    0     5  4774 5856  1674  0 14  0 86
 0  1      0  97024 1389524  32764    0    0     0  4735 6046  1734  0 14  0 85
 0  1      0   8200 1478228  32860    0    0     0  5824 6110  1744  0 15  0 85
 0  2      0   7040 1478104  34016    0    0     4  5292 6112  1770  0 15  0 85
 0  2      0 192460 1284440  39600    0    0     0  6996 8789  3082  0 24  0 75
 0  2      0  15092 1454596  45632    0    0     3  7851 9797  3301  0 28  0 72
 0  3      0  53296 1407600  53768    0    0     3  8697 8521  3085  0 28  0 72
 0  5      0   6696 1450928  56264    0    0     2  7903 10747  3853  0 32 0 68
 0  7      0   7656 1451404  56308    0    0     1  9772 11195  4079  0 36 0 64
 0  6      0  35712 1422992  56668    0    0     1 10428 11105  4117  0 37 0 63
 0  5      0   7320 1446636  60580    0    0    47  9266 10373  3909  0 37 0 63
 0  5      0   8068 1445088  61300    0    0     2  7959 10872  4021  0 33 0 67
 0  5      0   6864 1446200  61076    0    0     0  9735 10713  3971  0 35 0 64
 0  8      0  32300 1414148  66872    0    0     0  8824 11027  4200  0 36 0 64
 0  7      0   5788 1436968  68768    0    0     0  9944 11230  4332  0 39 0 61
 0  5      0   5784 1438292  67292    0    0     0 10764 11122  4184  0 39 0 61
 0  5      0   6360 1434940  70472    0    0     5 11552 10707  4052  0 38 2 59
 0  5      0   7532 1434312  70156    0    0     0  7860 11021  4111  0 35 0 65
 0  4      0   7528 1435300  69288    0    0     5 10776 11244  4242  0 39 0 61
 0  6      0   7080 1436852  68300    0    0     0  9002 11108  4143  0 36 0 64
 0  3      0   7176 1439128  65928    0    0     0 11320 11264  4228  0 39 0 60
 0  5      0  58536 1388564  65304    0    0     2  8709 10707  3988  0 35 0 64
 0  3      0  31676 1416804  63980    0    0     0  9620 11173  4110  0 37 0 63
 0  5      0   6360 1443248  62880    0    0     0 11070 11306  4156  0 39 0 61
 0  5      0   6936 1443752  62012    0    0     0  8965 11151  4124  0 36 0 64
 0  4      0   7528 1445472  59796    0    0     0 11077 11293  4196  0 39 0 61
 0  5      0  15852 1434576  62800    0    0     0 10615 11199  4158  0 38 0 62
 0  6      0   7224 1442660  63412    0    0     0  9675 11185  4127  0 37 0 63
 0  5      0   7144 1444804  61592    0    0     0  9662 11146  4129  0 37 0 63
 0  4      0   7580 1446844  59108    0    0     0 10283 11309  4144  0 38 0 62
 0  6      0   4972 1452864  56176    0    0     1 10481 11256  4159  0 38 0 62
 0  5      0   6424 1454372  53964    0    0     0 10686 11190  4066  0 37 0 63
 0  6      0   5324 1459288  50328    0    0     0  9117 11137  4063  0 35 0 65
 0  5      0   6412 1460396  48228    0    0     0 10657 11244  4159  0 38 0 62
 0  6      0   5004 1463616  46492    0    0     6  9593 11127  4095  0 36 0 64
 0  4      0   5132 1463024  46496    0    0     0 10694 11166  4133  0 38 0 62
 
