Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161120AbWJDHj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161120AbWJDHj3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 03:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161118AbWJDHj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 03:39:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44201 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030548AbWJDHj2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 03:39:28 -0400
Date: Wed, 4 Oct 2006 00:32:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch] clockevents: drivers for i386, fix #2
Message-Id: <20061004003228.98ec3b39.akpm@osdl.org>
In-Reply-To: <20061004064620.GA22364@elte.hu>
References: <20061001225720.115967000@cruncher.tec.linutronix.de>
	<20061002210053.16e5d23c.akpm@osdl.org>
	<20061003084729.GA24961@elte.hu>
	<20061003103503.GA6350@elte.hu>
	<20061003203620.d85df9c6.akpm@osdl.org>
	<20061004064620.GA22364@elte.hu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2006 08:46:20 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > Disabling LOCAL_APIC does fix it.
> 
> thanks, that narrows it down quite a bit. (We've double-checked the 
> lapic path and it seemed all our changes are NOP, but obviously it isnt 
> and we'll check it all again.)
> 
> (if you have that kernel still booted by any chance then do you see the 
> 'LOC' IRQ count in /proc/interrupts or any other count in /proc/stats 
> increasing at an alarming rate? That would narrow it down to lapic timer 
> misprogramming.)
> 

None of the interrupts are doing anything wrong.  oprofile shows nothing
alarming.

Disabling cpufreq in config doesn't fix it.

Userspace can count to a billion in 3.9 seconds when this problem is
present, which is the same time as it takes on a non-slow kernel.

`sleep 5' takes 5 seconds.

Yet initscripts take a long time (especially applying the ipfilter firewall
rues for some reason), and `startx' takes a long time, etc.  This kernel
takes 112 seconds to boot to a login prompt - other kernels take 56 seconds
(interesting ratio..)

Weird.
