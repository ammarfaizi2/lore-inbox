Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWAQQwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWAQQwu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 11:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWAQQwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 11:52:50 -0500
Received: from mail.cs.umn.edu ([128.101.33.102]:16634 "EHLO mail.cs.umn.edu")
	by vger.kernel.org with ESMTP id S932190AbWAQQwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 11:52:49 -0500
Date: Tue, 17 Jan 2006 10:52:44 -0600
From: Dave C Boutcher <sleddog@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, anton@au1.ibm.com,
       linux-kernel@vger.kernel.org, michael@ellerman.id.au,
       linuxppc64-dev@ozlabs.org, serue@us.ibm.com, paulus@au1.ibm.com
Subject: Re: 2.6.15-mm4 failure on power5
Message-ID: <20060117165244.GA23254@cs.umn.edu>
Reply-To: boutcher@cs.umn.edu
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@osdl.org>, anton@au1.ibm.com,
	linux-kernel@vger.kernel.org, michael@ellerman.id.au,
	linuxppc64-dev@ozlabs.org, serue@us.ibm.com, paulus@au1.ibm.com
References: <20060116063530.GB23399@sergelap.austin.ibm.com> <20060115230557.0f07a55c.akpm@osdl.org> <200601170000.58134.michael@ellerman.id.au> <20060116153748.GA25866@sergelap.austin.ibm.com> <20060116215252.GA10538@cs.umn.edu> <20060116170907.60149236.akpm@osdl.org> <20060117081749.GA10135@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060117081749.GA10135@elte.hu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2006 at 09:17:49AM +0100, Ingo Molnar wrote:
> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > > If I revert just that patch, mm4 boots fine.  Its really not obvious to
> > > me at all why that patch is breaking things though...
> > 
> > Yes, that is strange.  I do recall that if something accidentally 
> > enables interrupts too early in boot, ppc64 machines tend to go 
> > comatose.  But if we'd been running that code under 
> > local_irq_disable(), down() would have spat a warning.
> 
> perhaps it was just luck it worked so far, and the bug could have had 
> worse incarnations that the current clear hang if a certain generic 
> codepath is touched in a perfectly valid way. Does CONFIG_DEBUG_MUTEXES 
> (or any of the other debugging options) make any noise?

Well, it turns out that I've been running with CONFIG_DEBUG_MUTEXES all
along...so no noise.  My console output is a little different that
Serge's, so I think this is timing related.  Also note that I'm dying in
the timer interrupt...

Please wait, loading kernel...
   Elf64 kernel loaded...
Loading ramdisk...
ramdisk loaded at 02600000, size: 1212 Kbytes
OF stdout device is: /vdevice/vty@30000000
Hypertas detected, assuming LPAR !
command line: root=/dev/sda3 selinux=0 elevator=cfq
memory layout at init:
  memory_limit : 0000000000000000 (16 MB aligned)
  alloc_bottom : 000000000272f000
  alloc_top    : 0000000008000000
  alloc_top_hi : 0000000100000000
  rmo_top      : 0000000008000000
  ram_top      : 0000000100000000
Looking for displays
found display   : /pci@800000020000002/pci@2,6/pci@1/display@0, opening
... doneinstantiating rtas at 0x0000000007734000 ... done
0000000000000000 : boot cpu     0000000000000000
0000000000000002 : starting cpu hw idx 0000000000000002... done
0000000000000004 : starting cpu hw idx 0000000000000004... done
0000000000000006 : starting cpu hw idx 0000000000000006... done
copying OF device tree ...
Building dt strings...
Building dt structure...
Device tree strings 0x0000000002a30000 -> 0x0000000002a313f5
Device tree struct  0x0000000002a32000 -> 0x0000000002a42000
Calling quiesce ...
returning from prom_init
Page orders: linear mapping = 24, others = 12
Found initrd at 0xc000000002600000:0xc00000000272f000
cpu 0x0: Vector: 300 (Data Access) at [c000000000577520]
    pc: c000000000021064: .timer_interrupt+0xf4/0x440
    lr: c000000000021020: .timer_interrupt+0xb0/0x440
    sp: c0000000005777a0
   msr: 8000000000001032
   dar: 10
 dsisr: 40000000
  current = 0xc0000000005c1150
  paca    = 0xc0000000005c1d00
    pid   = 0, comm = swapper
enter ? for help
0:mon>


-- 
Dave Boutcher
