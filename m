Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263091AbTEGPKE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 11:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263931AbTEGPKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 11:10:03 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:43457 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP id S263091AbTEGPJf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 11:09:35 -0400
Subject: Re: 2.5.69-mm2 Kernel panic, possibly network related
From: Steven Cole <elenstev@mesatop.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Andrew Morton <akpm@digeo.com>
In-Reply-To: <20030507144100.GD8978@holomorphy.com>
References: <3EB8DBA0.7020305@aitel.hist.no>
	 <1052304024.9817.3.camel@rth.ninka.net> <3EB8E4CC.8010409@aitel.hist.no>
	 <20030507.025626.10317747.davem@redhat.com>
	 <20030507144100.GD8978@holomorphy.com>
Content-Type: text/plain
Organization: 
Message-Id: <1052320817.2163.159.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 07 May 2003 09:20:17 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-05-07 at 04:49, Helge Hafting wrote:
> >    No, I compile everything into a monolithic kernel.
> >    I don't even enable module support.
> 
> On Wed, May 07, 2003 at 02:56:26AM -0700, David S. Miller wrote:
> > Andrew, color me stumped.  mm2/linux.patch doesn't have anything
> > really interesting in the networking.  Maybe it's something in
> > the SLAB and/or pgd/pmg re-slabification changes?
> 
> The i810 bits would be a failure case of the original slabification.
> At first glance the re-slabification doesn't seem to conflict with the
> unmapping-based slab poisoning.
> 
> In another thread, you mentioned that a certain netfilter cset had
> issues; I think it might be good to add that as a second possible cause.
> 
> I'm trying to track down testers with i810's to reproduce the issue,
> but the usual suspects and helpers aren't awake yet (most/all of my
> target systems are headless, though I regularly abuse my laptop, which
> appears to S3/Savage -based and so isn't useful for this).

Hey, I've got one of those.  Well, an i810 anyway.

[steven@spc1 linux-2.5.69-mm2]$ dmesg | grep 810
agpgart: Detected an Intel i810 E Chipset.
[drm] Initialized i810 1.2.1 20020211 on minor 0

[steven@spc1 steven]$ uname -r
2.5.69-mm2
[steven@spc1 steven]$ /sbin/lspci
00:00.0 Host bridge: Intel Corp. 82810E DC-133 GMCH [Graphics Memory Controller Hub] (rev 03)
00:01.0 VGA compatible controller: Intel Corp. 82810E DC-133 CGC [Chipset Graphics Controller] (rev 03)
00:1e.0 PCI bridge: Intel Corp. 82801AA PCI Bridge (rev 02)
00:1f.0 ISA bridge: Intel Corp. 82801AA ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801AA IDE (rev 02)
00:1f.2 USB Controller: Intel Corp. 82801AA USB (rev 02)
00:1f.3 SMBus: Intel Corp. 82801AA SMBus (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801AA AC'97 Audio (rev 02)
01:0c.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)
[steven@spc1 steven]$ uptime
 09:00:52  up 35 min,  4 users,  load average: 0.18, 0.06, 0.08

It hasn't gone boink yet.

[steven@spc1 linux-2.5.69-mm2]$ grep ^CONFIG_NET .config
CONFIG_NET=y
CONFIG_NETFILTER=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_NET_PCI=y

Steven








