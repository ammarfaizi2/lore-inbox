Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318371AbSGaNp0>; Wed, 31 Jul 2002 09:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318372AbSGaNp0>; Wed, 31 Jul 2002 09:45:26 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:17654 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318371AbSGaNpZ>; Wed, 31 Jul 2002 09:45:25 -0400
Subject: RE: Linux 2.4.19ac3rc3 on IBM x330/x340 SMP - "ps" time skew
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Luyer <david@luyer.net>
Cc: "'Dana Lacoste'" <dana.lacoste@peregrine.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <00c901c23897$9593e530$638317d2@pacific.net.au>
References: <00c901c23897$9593e530$638317d2@pacific.net.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 31 Jul 2002 16:04:51 +0100
Message-Id: <1028127891.8510.79.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-31 at 14:38, David Luyer wrote:
> Yes, the problem is in the -ac train only.  It's the "processor id"
> field that has been added to /proc/cpuinfo which is confusing libc's
> way of counting CPUs.
> 
> That's a libc bug.  But there's also a kernel bug with that field
> it appears.

Currently yes - it got broken during the Summit rearrangements

> The kernel bug: the "processor id" fields are both printing zero.
> 
> Possibly because show_cpuinfo() in arch/i386/kernel/setup.c prints
> directly out of phys_proc_id as at the time it's called, but
> smpboot.c declates phys_proc_id as __initdata (either that, or
> phys_proc_id is actually zero for both CPUs?).

The former is the problem. Thanks for spotting it. As to the text
string, I'll have a chat with Ulrich about it and see what he thinks

