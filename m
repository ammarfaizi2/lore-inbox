Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261836AbUKJCFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbUKJCFB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 21:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbUKJCFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 21:05:01 -0500
Received: from shinjuku.zaphods.net ([194.97.108.52]:60549 "EHLO
	shinjuku.zaphods.net") by vger.kernel.org with ESMTP
	id S261836AbUKJCDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 21:03:40 -0500
Date: Wed, 10 Nov 2004 03:03:27 +0100
From: Stefan Schmidt <zaphodb@zaphods.net>
To: Andrew Morton <akpm@osdl.org>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       piggin@cyberone.com.au, netdev@oss.sgi.com
Subject: Re: 2.6.10-rc1-mm4 -1 EAGAIN after allocation failure was: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-ID: <20041110020327.GE20754@zaphods.net>
References: <20041103222447.GD28163@zaphods.net> <20041104121722.GB8537@logos.cnet> <20041104181856.GE28163@zaphods.net> <20041109164113.GD7632@logos.cnet> <20041109223558.GR1309@mail.muni.cz> <20041109144607.2950a41a.akpm@osdl.org> <20041109235201.GC20754@zaphods.net> <20041110012733.GD20754@zaphods.net> <20041109173920.08746dbd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="WhfpMioaduB5tiZL"
Content-Disposition: inline
In-Reply-To: <20041109173920.08746dbd.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: 194.97.1.3
X-SA-Exim-Mail-From: zaphodb@boombox.zaphods.net
X-SA-Exim-Scanned: No (on shinjuku.zaphods.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 09, 2004 at 05:39:20PM -0800, Andrew Morton wrote:
> Well you've definitely used up all the memory which is available for atomic
> allocations.  Are you using an increased /proc/sys/vm/min_free_kbytes there?
Yes, vm.min_free_kbytes=8192.
For other vm-settings find sysctl.conf attached.

Netdev: tg3 BCM5704r03, TSO off, ~32kpps rx, ~35kpps tx, ~2 rx errors/s

> As for the application collapse: dunno.  Maybe networking broke.  It would
> be interesting to test Linus's current tree, at
> ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.10-rc1-bk19.gz
Will try that tomorrow. Would you suggest printing out show_free_areas();
there too? I don't know what kind of an overhead that will generate on
subsequent stack traces.

	Stefan

--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sysctl.conf"

#
# /etc/sysctl.conf - Configuration file for setting system variables
# See sysctl.conf (5) for information.
#
#kernel.domainname = example.com
#net/ipv4/icmp_echo_ignore_broadcasts=1
vm.min_free_kbytes=8192
vm.dirty_expire_centisecs=1000
#vm.dirty_expire_centisecs=3000
vm.dirty_writeback_centisecs=250
#vm.dirty_writeback_centisecs=500
vm.dirty_ratio=10
#vm.dirty_ratio=40
vm.dirty_background_ratio=2
#vm.dirty_background_ratio=10
vm.swappiness=0
#vm.swappiness=60
vm.overcommit_ratio=0
#vm.overcommit_ratio=50
#default:
#vm.bdflush=30 500     0       0       500     3000    60      20      0
#vm.bdflush=10 500 0 0 500 1500 60 5 0
net.ipv4.tcp_rmem=4096 87380 174760
net.ipv4.tcp_wmem=4096 16384 131072
net.core.rmem_default=108544
net.core.wmem_default=108544
net.core.wmem_max=1048576
#net.core.wmem_max=131071
net.core.rmem_max=1048576
#net.core.rmem_max=131071
net.core.somaxconn=1024
#net.core.somaxconn=128
net.ipv4.tcp_max_syn_backlog=2048
#net.ipv4.tcp_max_syn_backlog=1024
net.ipv4.tcp_ecn=0
net.ipv4.tcp_abort_on_overflow=1
#net.ipv4.tcp_abort_on_overflow=0
et.core.netdev_max_backlog=300
#net.ipv4.tcp_keepalive_time=600
net.ipv4.tcp_moderate_rcvbuf=1
net.ipv4.netfilter.ip_conntrack_max=65536
fs.xfs.age_buffer_centisecs=300
#fs.xfs.age_buffer_centisecs=1500
fs.xfs.xfsbufd_centisecs=200
#fs.xfs.xfsbufd_centisecs=100
fs.xfs.xfssyncd_centisecs=600
#fs.xfs.xfssyncd_centisecs=3000
fs.aio-max-nr=131072
#fs.aio-max-nr=65536

--WhfpMioaduB5tiZL--
