Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268985AbUIMV4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268985AbUIMV4z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 17:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268989AbUIMV4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 17:56:55 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:19612 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268985AbUIMV4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 17:56:51 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc1-mm5 bug in tcp_recvmsg?
Date: Mon, 13 Sep 2004 14:56:31 -0700
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20040913015003.5406abae.akpm@osdl.org>
In-Reply-To: <20040913015003.5406abae.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409131456.31265.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shortly after the backtrace I've already posted, I got one panic that looked 
like this:

Warning: kfree_skb on hard IRQ a0000001006443d0
Unable to handle kernel paging request at virtual address 600000000001e8e0
Warning: kfree_skb on hard IRQ a0000001006443d0
Unable to handle kernel paging request at virtual address 600000000001e8e0
sshd[8790]: Oops 8804682956800 [1]
Modules linked in:

Pid: 8790, CPU 1, comm:                 sshd
psr : 0000101308526030 ifs : 80000028b0815428 ip  : [<2000000000573670>]    
Not tainted
ip is at 0x2000000000573670
unat: 0000000000000000 pfs : c000000000000288 rsc : 000000000000000f
rnat: 0000000000000000 bsps: 60000fff7fffc418 pr  : 000000000001a529
ldrs: 0000000002100000 ccv : 0000000000000000 fpsr: 0009804c8a74433f
csd : 0000000000000000 ssd : 0000000000000000
b0  : 4000000000042010 b6  : 2000000000573520 b7  : 0000000000000000
f6  : 000000000000000000000 f7  : 000000000000000000000
f8  : 000000000000000000000 f9  : 000000000000000000000
f10 : 000000000000000000000 f11 : 000000000000000000000
r1  : 2000000000684200 r2  : c000000000000288 r3  : 0000000000000001
r8  : 600000000001e8e0 r9  : 0000000000000000 r10 : 0000000000000000
r11 : 60000fffffffafa0 r12 : 60000fffffff7020 r13 : 20000000007392e0
r14 : 0000000000000000 r15 : 0000000000000006 r16 : 0000000005a6a5a9
r17 : 0000000000000000 r18 : 600000000001e8f0 r19 : 600000000001e8e0
r20 : 60000fffffff7040 r21 : 60000fffffff7050 r22 : 0000000000000010
r23 : 60000fff7fffc418 r24 : 0000000000000000 r25 : 0000000000000000
r26 : c00000000000038a r27 : 000000000000000f r28 : 2000000000617e20
r29 : 00001213085a6010 r30 : 60000fffffff7244 r31 : 600000000001eaf4
r32 : 0000000000000002 r33 : 0000000000000000 r34 : 200000000009ae00
r35 : 6000000000024b28 r36 : 6000000000024c10 r37 : 2000000000086610
r38 : c000000000000288 r39 : 6000000000024b20 r40 : 0000000000000002
r41 : 600000000001dcd0 r42 : 200000000009ae00 r43 : 0000000000000001
r44 : 0000000000000000 r45 : 0000000000000000 r46 : 0000000000000006
r47 : 0000000000000000 r48 : 2000000000083060 r49 : c00000000000048e
r50 : 6000000000024b20 r51 : 0000000000000002 r52 : 6000000000027db0
r53 : 6000000000024c38 r54 : 0000000000000002 r55 : 0000000000000000
r56 : 2000000000a647c0 r57 : 0000000000000000 r58 : 60000000000349d0
r59 : 2000000000a540d8 r60 : 60000fffffffaff8 r61 : 0000000000000000
r62 : 6000000000024b70 r63 : 2000000000082d90 r64 : c00000000000058f
r65 : 0000000005a5a969 r66 : 6000000000027e60 r67 : 0000000000000002
r68 : 0000000000000002 r69 : 0000000000000000 r70 : 200000000009ae00
r71 : 6000000000027e68
Kernel panic - not syncing: Aiee, killing interrupt handler!
Rebooting in 5 seconds..

The ip above is in sshd presumably, and the warning message corresponds to 
somewhere in tcp_recvmsg:

a0000001006434e0 T tcp_recvmsg
a000000100644760 t tcp_close_state

Is this a known problem?

Thanks,
Jesse

