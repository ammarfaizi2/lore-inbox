Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262067AbUKJUhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262067AbUKJUhF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 15:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbUKJUhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 15:37:04 -0500
Received: from hell.sks3.muni.cz ([147.251.210.30]:21481 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S262067AbUKJUgq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 15:36:46 -0500
Date: Wed, 10 Nov 2004 21:35:47 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, zaphodb@zaphods.net,
       linux-kernel@vger.kernel.org, piggin@cyberone.com.au
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-ID: <20041110203547.GA25410@mail.muni.cz>
References: <20041103222447.GD28163@zaphods.net> <20041104121722.GB8537@logos.cnet> <20041104181856.GE28163@zaphods.net> <20041109164113.GD7632@logos.cnet> <20041109223558.GR1309@mail.muni.cz> <20041109144607.2950a41a.akpm@osdl.org> <20041109224423.GC18366@mail.muni.cz> <20041109203348.GD8414@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041109203348.GD8414@logos.cnet>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Lukas,
> 
> So you can be hitting the e1000/TSO issue - care to retest with 
> 2.6.10-rc1-mm3/4 please?

2.6.10-rc1-mm3 with CONFIG_PREEMPT=y and  CONFIG_PREEMPT_BKL=y
results with: (and many more xfs related calls)

Nov 10 21:21:05 undomiel1 kernel: BUG: using smp_processor_id() in preemptible [00000001] code: swapper/1
Nov 10 21:21:05 undomiel1 kernel: caller is xfs_dir2_lookup+0x26/0x157
Nov 10 21:21:05 undomiel1 kernel:  [<c025dbf4>] smp_processor_id+0xa8/0xb8
Nov 10 21:21:05 undomiel1 kernel:  [<c020679b>] xfs_dir2_lookup+0x26/0x157
Nov 10 21:21:05 undomiel1 kernel:  [<c020679b>] xfs_dir2_lookup+0x26/0x157
Nov 10 21:21:05 undomiel1 kernel:  [<c025a4e7>] send_uevent+0x148/0x1a0
Nov 10 21:21:05 undomiel1 kernel:  [<c025a61a>] do_kobject_uevent+0xdb/0x109
Nov 10 21:21:05 undomiel1 kernel:  [<c023ba15>] xfs_access+0x4d/0x5b
Nov 10 21:21:05 undomiel1 kernel:  [<c023766e>] xfs_dir_lookup_int+0x4c/0x12b
Nov 10 21:21:05 undomiel1 kernel:  [<c01611a3>] link_path_walk+0xd4a/0xe17
Nov 10 21:21:05 undomiel1 kernel:  [<c023ce74>] xfs_lookup+0x50/0x88
Nov 10 21:21:05 undomiel1 kernel:  [<c0249300>] linvfs_lookup+0x58/0x96
Nov 10 21:21:05 undomiel1 kernel:  [<c016017a>] real_lookup+0xc20xe3
Nov 10 21:21:05 undomiel1 kernel:  [<c016044e>] do_lookup+0x96/0xa1

-- 
Luká¹ Hejtmánek
