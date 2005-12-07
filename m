Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030371AbVLGVuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030371AbVLGVuU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 16:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030373AbVLGVuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 16:50:19 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:30227 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1030371AbVLGVuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 16:50:18 -0500
Date: Wed, 7 Dec 2005 22:50:14 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Jan =?iso-8859-1?Q?Oberl=E4nder?= <mindriot@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.32 Oops in scsi_dispatch_cmd
Message-ID: <20051207215014.GB15993@alpha.home.local>
References: <20051207093747.GA1154@hek501.hek.uni-karlsruhe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051207093747.GA1154@hek501.hek.uni-karlsruhe.de>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 07, 2005 at 10:37:47AM +0100, Jan Oberländer wrote:
> Hi,
> 
> [please Cc:, I'm not on the list!]
> 
> I've been receiving Oops repeatedly in scsi_dispatch_cmd, in different
> kernels (2.4.{27,31,32}).  At first I thought that a non-free module for
> an ATA RAID card was responsible, but in 2.4.32 I've seen it without
> using that as well (in a non-tainted kernel).  I can't exactly rule out
> that it's a hardware problem, but since it's very repeatable I'm really
> not sure.  The box doesn't recover from the Oops, but I was still able
> to see the Oops message in /var/log/messages.  See the attached file for
> ksymoops output.

could you send your .config and gcc version please ? I've checked the
code and it's not easy to find what data is accessed in your oopses.

> The tar process is run from a backup scripts that mounts an IDE drive
> partition, writes a backup to it and unmounts it.  It's always been the
> tar process behind this crash.  Some system details:

could you please also tell us what partition tar reads data from ? I've
understood that you have some disks on your adaptec card and some software
RAID, so if you could roughly explain the setup, it would be great.

> $ uname -a
> Linux server 2.4.32 #1 Tue Dec 6 10:55:41 CET 2005 i686 GNU/Linux
> $ cat /proc/cpuinfo
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 6
> model           : 7
> model name      : AMD Duron(tm) Processor
> stepping        : 1
> cpu MHz         : 1197.726
> cache size      : 64 KB
>  [...]
> $ lspci
> 0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
> 0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP]
> 0000:00:0d.0 SCSI storage controller: Adaptec AHA-2940U2/U2W
> 0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
> 0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
> 0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
> 0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
> 0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
> 0000:00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
> 0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
> 0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
> 0000:01:00.0 VGA compatible controller: nVidia Corporation NV5M64 [RIVA TNT2 Model 64/Model 64 Pro] (rev 15)
> $ 
> 
> There are no modules loaded.  The IDE HDD is on the VIA controller,
> several other disks are behind the Adaptec controller (several of them
> on Software RAID).
> 
> Maybe you have an idea what's going on (or who to talk to instead)?  I'm
> stuck.

It may be doable with a few more info. Please also confirm that your
System.map really matches your kernel (for the oops report).

> Thanks in advance & keep up the good work!
> 
> Jan

Regards,
Willy

