Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbVCGWbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVCGWbM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 17:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbVCGWaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 17:30:46 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:64759 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261853AbVCGVsP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 16:48:15 -0500
Message-ID: <422CCC1D.1050902@mvista.com>
Date: Mon, 07 Mar 2005 13:48:13 -0800
From: Frank Rowand <frowand@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: [PATCH 0/5] ppc RT: Realtime preempt support for PPC
Content-Type: multipart/mixed;
 boundary="------------080809030600090704090906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------080809030600090704090906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ingo,

I have updated my patch of 16 Feb 2005 that adds realtime support for PowerPC
(32 bit only).  The patches will be sent in following emails.

The patch series applies over Ingo's real-time preempt patch:

   http://people.redhat.com/mingo/realtime-preempt/realtime-preempt-2.6.11-rc4-V0.7.39-02

The patches are:

  1/5 ppc_rt.patch          - the core realtime functionality for PPC

  2/5 ppc_cpu_khz.patch     - This is separated out from the first patch to
                              reduce the noise in the first patch.  It defines
                              cpu_khz, which is needed by usecs_to_cyles() in
                              kernel/latency.c.

  3/5 ppc_mcount.patch      - Implements mcount() and _mcount() for performance
                              instrumentation.


The following two patches should not be applied by anyone unless they want
to test the other three patches on the IBM PPC 405GP eval board:

  4/5 ibm_emac_core.patch   - This patch has been separately submitted to PPC.

  5/5 smp405.patch          - a hack to allow compiling a PPC 405 kernel with
                              CONFIG_SMP=y

The changes from the previous patch are:

   Added #ifdef CONFIG_PPC32 to raw_rwlock_t in include/linux/rt_lock.h.  The
   ppc lock is a signed int instead of an unsigned long.

   Replaced us_to_tb with cpu_khz to more consistent with i386 and to remove
   the #ifdef CONFIG_PPC in usecs_to_cycles().

   Added mcount() and _mcount() that I previously said was a work in progress.

   Added missing underscores in arch/ppc/lib/locks.c for __raw_read_trylock()
   and __raw_read_lock().

   Changed tlb->mm to tlb_mm(tlb) in include/asm-ppc/tlb.h.

   Reverted change of dma_spin_lock in include/asm-ppc/dma.h from
   raw_spinlock_t to spinlock_t to be consistent with kernel/dma.c.



This patch has been tested on the IBM PPC 405GP eval board only.
You might notice that this board is not an SMP board.  A few small
changes were required to build an SMP kernel, even though only one cpu
is actually active.

The testing has included a short (~ten minute) stress test for sixteen
configuration permutations.  The config files for the permutations are
in the attached tar in the following directories:

                        instrumentation off         instrumentation on
                        ----------------------      ----------------------

                        SMP=n       SMP=y           SMP=n       SMP=y
                        ----------  ----------      ----------  ----------
  PREEMPT_NONE          pn          pn_smp          lat_pn      lat_pn_smp
  PREEMPT_VOLUNTARY     pv          pv_smp          lat_pv      lat_pv_smp
  PREEMPT_DESKTOP       pd          pd_smp          lat_pd      lat_pd_smp
  PREEMPT_RT            pr          pr_smp          lat_pr      lat_pr_smp


Any comments, suggestions, needed changes, etc are welcome.

Thanks,

-Frank
-- 
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

--------------080809030600090704090906
Content-Type: application/x-gzip;
 name="config_tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config_tar.gz"

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
AA==
--------------080809030600090704090906--

