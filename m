Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265300AbTLMWFJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 17:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265302AbTLMWFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 17:05:09 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:48774 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S265300AbTLMWFA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 17:05:00 -0500
Date: Sat, 13 Dec 2003 23:04:59 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: linux-kernel@vger.kernel.org
Subject: Use-after-free in pte_chain in 2.6.0-test11
Message-ID: <20031213220459.GA22152@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  today I get this one while attempting to build new kernel. Running kernel is
2.6.0-test11-c1511 (bk as of 2003-12-05 23:35:35-08:00). Does anybody
have any clue what could happen, or should I start looking for a new
memory modules?

  AMD K7/1GHz box, 512MB RAM, no vmmon/vmnet loaded since reboot, gcc-3.3.2
as of last week Debian unstable. Kernel built with all possible memory 
debugging enabled... 

  Unfortunately I have no idea which process did this clone() call, and
whether it succeeded or died. 
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz

Slab corruption: start=da54d380, expend=da54d3ff, problemat=da54d3fc
Data: ****************************************************************************************************************************6A **A5
Next: 1D 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
slab error in check_poison_obj(): cache `pte_chain': object was modified after freeing
Call Trace:
 [<c0152658>] check_poison_obj+0x108/0x190
 [<c0166e3c>] pte_chain_alloc+0x3c/0x80
 [<c0154813>] kmem_cache_alloc+0x83/0x210
 [<c0166e3c>] pte_chain_alloc+0x3c/0x80
 [<c015d1b0>] copy_page_range+0x410/0x900
 [<c0152579>] check_poison_obj+0x29/0x190
 [<c0125c51>] copy_mm+0x571/0x730
 [<c0127369>] copy_process+0xcd9/0xee0
 [<c0126bc2>] copy_process+0x532/0xee0
 [<c01275cc>] do_fork+0x5c/0x1e0
 [<c01078d1>] sys_clone+0x41/0x50
 [<c0109dab>] syscall_call+0x7/0xb


