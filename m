Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbVEBRF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbVEBRF6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 13:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbVEBRDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 13:03:45 -0400
Received: from ns2.suse.de ([195.135.220.15]:49071 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261538AbVEBRCe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 13:02:34 -0400
Date: Mon, 2 May 2005 19:02:28 +0200
From: Andi Kleen <ak@suse.de>
To: YhLu <YhLu@tyan.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: x86-64 dual core mapping
Message-ID: <20050502170228.GK7342@wotan.suse.de>
References: <3174569B9743D511922F00A0C943142309B075AF@TYANWEB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174569B9743D511922F00A0C943142309B075AF@TYANWEB>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2005 at 07:38:07PM -0700, YhLu wrote:
> Andi,
> 
> I tried 2.6.12-rc3 with dual way dual cpus.
> 
> It seems right mapping should be
> CPU 0(2) -> Node 0 -> Core 0
> CPU 1(2) -> Node 0 -> Core 1
> CPU 2(2) -> Node 1 -> Core 0
> CPU 3(2) -> Node 1 -> Core 1
> 
> instead of
> 
> CPU 0(2) -> Node 0 -> Core 0
> CPU 1(2) -> Node 0 -> Core 0
> CPU 2(2) -> Node 1 -> Core 1
> CPU 3(2) -> Node 1 -> Core 1

Hmm, yes, something seems wrong. The last time I tested 
it worked this way, but maybe the latest merge has broken 
it again. I will check it later.

Are you sure you dont have a broken SRAT table? The SRAT
table will overwrite the mappings, so if it is wrong
the one Linux reports will be too.

-Andi
> 
> YH
> 
> 
> 
> 
> CPU 0(2) -> Node 0 -> Core 0
> Using local APIC NMI watchdog using perfctr0
> enabled ExtINT on CPU#0
> ENABLING IO-APIC IRQs
> Using IO-APIC 4
> ...changing IO-APIC physical APIC ID to 4 ... ok.
> Using IO-APIC 5
> ...changing IO-APIC physical APIC ID to 5 ... ok.
> Using IO-APIC 6
> ...changing IO-APIC physical APIC ID to 6 ... ok.
> Using IO-APIC 7
> ...changing IO-APIC physical APIC ID to 7 ... ok.
> Synchronizing Arb IDs.
> ..TIMER: vector=0x31 pin1=0 pin2=2
> testing the IO APIC.......................
> 
> 
> 
> 
> .................................... done.
> Using local APIC timer interrupts.
> Detected 12.564 MHz APIC timer.
> Booting processor 1/1 rip 6000 rsp ffff81007ff99f58
> Initializing CPU#1
> masked ExtINT on CPU#1
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
> CPU 1(2) -> Node 0 -> Core 0
>  stepping 00
> Synced TSC of CPU 1 difference 30064769976
> Booting processor 2/2 rip 6000 rsp ffff81013ffa3f58
> Initializing CPU#2
> masked ExtINT on CPU#2
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
> CPU 2(2) -> Node 1 -> Core 1
>  stepping 00
> Synced TSC of CPU 2 difference 30064770021
> Booting processor 3/3 rip 6000 rsp ffff81007ff49f58
> Initializing CPU#3
> masked ExtINT on CPU#3
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
> CPU 3(2) -> Node 1 -> Core 1
>  stepping 00
> Synced TSC of CPU 3 difference 30064770021
> Brought up 4 CPUs
