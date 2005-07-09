Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVGIO3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVGIO3b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 10:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVGIO3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 10:29:31 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.21]:3146 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S261182AbVGIO33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 10:29:29 -0400
Subject: linux-2.6.12-RT-V0.7.51-18: RT task yield()-ing!
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sat, 09 Jul 2005 16:29:26 +0200
Message-Id: <1120919366.14404.5.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

I got the following BUG while playing a nice tune 
with xmms. Shortly after the BUG the machine froze 
hard and I had to reach over and press the reset button.

PS. there is a simple compile error in 51-18 when
CONFIG_DEBUG_STACKOVERFLOW is undefined.

BUG: xmms:2200 RT task yield()-ing!
 [<c0104203>] dump_stack+0x23/0x30 (20)
 [<c035d6cb>] yield+0x5b/0x60 (20)
 [<c0126c16>] tasklet_kill+0x26/0x70 (16)
 [<f09ce1a4>] emu10k1_audio_release+0x114/0x210 [emu10k1] (40)
 [<c016e76d>] __fput+0x14d/0x1a0 (36)
 [<c016cdb5>] filp_close+0x55/0x90 (28)
 [<c016ce60>] sys_close+0x70/0xa0 (32)
 [<c0103208>] sysenter_past_esp+0x61/0x89 (-4020)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c01422cc>] .... add_preempt_count+0x1c/0x20
....
.[<c01436cb>] ..   ( <= print_traces+0x1b/0x60)

------------------------------
| showing all locks held by: |  (xmms/2200 [c50018f0,  53]):
------------------------------

-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

