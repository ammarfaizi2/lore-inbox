Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284700AbRLDAUw>; Mon, 3 Dec 2001 19:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284865AbRLDASN>; Mon, 3 Dec 2001 19:18:13 -0500
Received: from TYO202.gate.nec.co.jp ([202.247.6.41]:58381 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S284415AbRLCKdC>; Mon, 3 Dec 2001 05:33:02 -0500
To: akpm@zip.com.au
Cc: j-nomura@ce.jp.nec.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.16 kernel/printk.c (per processor initialization
 check)
From: j-nomura@ce.jp.nec.com
In-Reply-To: <3C0B43DC.7A8F582A@zip.com.au>
In-Reply-To: <20011203144615C.nomura@hpc.bs1.fc.nec.co.jp>
	<3C0B43DC.7A8F582A@zip.com.au>
X-Mailer: Mew version 1.94.2 on XEmacs 21.4 (Copyleft)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20011203193235S.nomura@hpc.bs1.fc.nec.co.jp>
Date: Mon, 03 Dec 2001 19:32:35 +0900
X-Dispatcher: imput version 20000414(IM141)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for commenting.

From: Andrew Morton <akpm@zip.com.au>
Subject: Re: [PATCH] 2.4.16 kernel/printk.c (per processor initialization check)
Date: Mon, 03 Dec 2001 01:20:28 -0800

> Seems that there is some sort of ordering problem here - someone
> is calling printk before the MMU is initialised, but after some
> console drivers have been installed.

Yes.
Because smp_init() is later in place than console_init(), printk() can be
called in such a situation.
For example, in IA-64, identify_cpu() is called before ia64_mmu_init(),
while identify_cpu() calls printk() in it.
I don't think the ordering itself is a problem.

> I suspect the real fix is elsewhere, but I'm not sure where.
> 
> Probably a clearer place to put this test would be within
> printk itself, immediately before the down_trylock.  Does that
> work?

The reason I put it in release_console_sem() is that release_console_sem()
can be called from other functions than printk(), e.g. console_unblank().
I agree with you that it is clearer but I think it is not sufficient.

Best regards.
--
NOMURA, Jun'ichi <j-nomura@ce.jp.nec.com, nomura@hpc.bs1.fc.nec.co.jp>
HPC Operating System Group, 1st Computers Software Division,
Computers Software Operations Unit, NEC Solutions.
