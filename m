Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbVIUP7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbVIUP7w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 11:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbVIUP7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 11:59:52 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:21199 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751109AbVIUP7v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 11:59:51 -0400
Date: Wed, 21 Sep 2005 08:59:23 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: Andrew Morton <akpm@osdl.org>, alokk@calsoftinc.com,
       linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849
In-Reply-To: <4330B5C2.3080300@vc.cvut.cz>
Message-ID: <Pine.LNX.4.62.0509210856410.10272@schroedinger.engr.sgi.com>
References: <4329A6A3.7080506@vc.cvut.cz> <20050916023005.4146e499.akpm@osdl.org>
 <432AA00D.4030706@vc.cvut.cz> <20050916230809.789d6b0b.akpm@osdl.org>
 <432EE103.5020105@vc.cvut.cz> <20050919112912.18daf2eb.akpm@osdl.org>
 <Pine.LNX.4.62.0509191141380.26105@schroedinger.engr.sgi.com>
 <20050919122847.4322df95.akpm@osdl.org> <Pine.LNX.4.62.0509191351440.26388@schroedinger.engr.sgi.com>
 <20050919221614.6c01c2d1.akpm@osdl.org> <43301578.8040305@vc.cvut.cz>
 <Pine.LNX.4.62.0509201800460.6792@schroedinger.engr.sgi.com>
 <4330B5C2.3080300@vc.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2005, Petr Vandrovec wrote:

> Simple... I just boot any kernel after 2.6.13, and it dies in front of me.
> Currently I'm using config below, which I boot with 'rootdelay=60' so panic
> in keventd happens before panic due to no root filesystem.  No ACPI.
> Nothing.  100% reproducible.  Maybe I should enable embedded options and
> remove all other device drivers still present in the kernel.
> 
> Below config is dmesg from 2.6.13, which has no problems with comming up.
> Maybe
> you'll find some clue there, but I see none.  Node #0 has 1GB of memory, so
> it should have no need to borrow blocks from node #1 when this kernel is able
> to boot in 16MB of memory...

Hmm. This likely has something to do with debugging code. I was unable to 
reproduce this on amd64 with your config. I get another failure with 
2.6.14-rc2 on ia64 if I enable all the debugging features that you have. 
The system works fine if no debugging is configured:

kernel BUG at kernel/workqueue.c:541!
swapper[1]: bugcheck! 0 [1]
Modules linked in:

Pid: 1, CPU 0, comm:              swapper
psr : 00001010085a6010 ifs : 8000000000000105 ip  : [<a0000001000e5b10>]    
Not tainted
ip is at init_workqueues+0x90/0xa0
unat: 0000000000000000 pfs : 0000000000000105 rsc : 0000000000000003
rnat: 0000000000000000 bsps: 000000000001003e pr  : 000000000000a541
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70433f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a0000001000e5b10 b6  : e000003002385ad0 b7  : e000000001fffc00
f6  : 1003e000000003f34da65 f7  : 1003e20c49ba5e353f7cf
f8  : 1003e00000000000000c8 f9  : 10006c7fffffffd73ea5c
f10 : 0fffdfffffffffaf00000 f11 : 1003e0000000000000000
r1  : a000000100cd7670 r2  : 0000000000000001 r3  : e00000b0057c0e00
r8  : 0000000000000029 r9  : 0000000000004000 r10 : 0000000000000001
r11 : 0000000000000002 r12 : e00000b0057c7de0 r13 : e00000b0057c0000
r14 : a0000001009690b0 r15 : e00000b0057c0df4 r16 : e00000b0057c0e00
r17 : 0000000000000001 r18 : 0000000000000002 r19 : a0000001009690b0
r20 : a000000100ad78f8 r21 : ffffffffffffffff r22 : e000000001fffc00
r23 : a000000100b11748 r24 : 0000000000000000 r25 : 0000000000000004
r26 : e00000b0057c0df0 r27 : e00000b0057c7cc8 r28 : e00000b0057c7cd0
r29 : 0000000000000c46 r30 : 0000000000000c46 r31 : 0000000000000308

