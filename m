Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261713AbSJZABE>; Fri, 25 Oct 2002 20:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261714AbSJZABE>; Fri, 25 Oct 2002 20:01:04 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:19432 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261713AbSJZABD>;
	Fri, 25 Oct 2002 20:01:03 -0400
Date: Fri, 25 Oct 2002 17:02:21 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>, Michael Hohnbaum <hohnbaum@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Crunch time -- the musical.  (2.5 merge candidate list 1.5)
Message-ID: <519740000.1035590541@flay>
In-Reply-To: <515310000.1035588399@flay>
References: <200210242351.56719.efocht@ess.nec.de> <2862423467.1035473915@[10.10.2.3]> <200210251015.46388.efocht@ess.nec.de> <515310000.1035588399@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I thought this problem is well understood! For some reasons independent of
>> my patch you have to boot your machines with the "notsc" option. This
>> leaves the cache_decay_ticks variable initialized to zero which my patch
>> doesn't like. I'm trying to deal with this inside the patch but there is
>> still a small window when the variable is zero. In my opinion this needs
>> to be fixed somewhere in arch/i386/kernel/smpboot.c. Booting a machine
>> with cache_decay_ticks=0 is pure nonsense, as it switches off cache
>> affinity which you absolutely need! So even if "notsc" is a legal option,
>> it should be fixed such that it doesn't leave your machine without cache
>> affinity. That would anyway give you a falsified behavior of the O(1)
>> scheduler.

> EIP is at task_to_steal+0x118/0x260

This turned out to be:

weight = (jiffies - tmp->sleep_timestamp)/cache_decay_ticks;

So I guess that window is still biting you. I'll see if I can fix it properly.

M.

