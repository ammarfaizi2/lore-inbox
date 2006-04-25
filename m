Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbWDYIdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWDYIdz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 04:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbWDYIdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 04:33:55 -0400
Received: from odin2.bull.net ([129.184.85.11]:2261 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S1751004AbWDYIdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 04:33:54 -0400
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: RT_PREEMPT, nfsd and reboot.
Date: Tue, 25 Apr 2006 10:34:37 +0200
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_e8dTEn+v1ngjulD"
Message-Id: <200604251034.38050.Serge.Noiraud@bull.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_e8dTEn+v1ngjulD
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

	I get the following messages when I reboot my system :
Is it a misconfiguration problem ?
Another question : Can we use SLOB with rt ? apparently I can't anymore !

kernel 2.6.16 + rt16 

-- 
Serge Noiraud

--Boundary-00=_e8dTEn+v1ngjulD
Content-Type: text/plain;
  charset="iso-8859-15";
  name="preempt-rt-nfsd.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="preempt-rt-nfsd.txt"

nfsd: last server has exited
nfsd: unexporting all filesystems
BUG: using smp_processor_id() in preemptible [00000000] code: nfsd/6145
caller is drain_array_locked+0x1f/0xd0
 [<c0104496>] show_trace+0x26/0x30 (20)
 [<c01045e3>] dump_stack+0x23/0x30 (20)
 [<c0291aeb>] debug_smp_processor_id+0xab/0xc0 (32)
 [<c017782f>] drain_array_locked+0x1f/0xd0 (44)
 [<c01760dd>] drain_cpu_caches+0x8d/0xc0 (44)
 [<c0176206>] __cache_shrink+0x26/0xc0 (40)
 [<c0176372>] kmem_cache_destroy+0x72/0x1e0 (28)
 [<f8b9e3d8>] nfsd4_free_slab+0x28/0x60 [nfsd] (24)
 [<f8b9e427>] nfsd4_free_slabs+0x17/0x40 [nfsd] (12)
 [<f8ba281c>] nfs4_state_shutdown+0x1c/0x30 [nfsd] (8)
 [<f8b8369b>] nfsd+0x32b/0x350 [nfsd] (68)
 [<c0101545>] kernel_thread_helper+0x5/0x10 (161480732)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c0291aa0>] .... debug_smp_processor_id+0x60/0xc0
.....[<c017782f>] ..   ( <= drain_array_locked+0x1f/0xd0)

------------------------------
| showing all locks held by: |  (nfsd/6145 [f6cfb070, 116]):
------------------------------

#001:             [f8bb5cc4] {client_sema.lock}
... acquired at:               rt_down+0x1e/0x40

#002:             [c0422164] {kernel_sem.lock}
... acquired at:               rt_down+0x1e/0x40

#003:             [c207b6c0] {mm/slab.c:150}
... acquired at:               drain_cpu_caches+0x64/0xc0

#004:             [f6b61c6c] {&parent->list_lock}
... acquired at:               drain_cpu_caches+0x6f/0xc0

BUG: nfsd:6145 task might have lost a preemption check!
 [<c0104496>] show_trace+0x26/0x30 (20)
 [<c01045e3>] dump_stack+0x23/0x30 (20)
 [<c012174f>] preempt_enable_no_resched+0x5f/0x70 (20)
 [<c0291af0>] debug_smp_processor_id+0xb0/0xc0 (32)
 [<c017782f>] drain_array_locked+0x1f/0xd0 (44)
 [<c01760dd>] drain_cpu_caches+0x8d/0xc0 (44)
 [<c0176206>] __cache_shrink+0x26/0xc0 (40)
 [<c0176372>] kmem_cache_destroy+0x72/0x1e0 (28)
 [<f8b9e3d8>] nfsd4_free_slab+0x28/0x60 [nfsd] (24)
 [<f8b9e427>] nfsd4_free_slabs+0x17/0x40 [nfsd] (12)
 [<f8ba281c>] nfs4_state_shutdown+0x1c/0x30 [nfsd] (8)
 [<f8b8369b>] nfsd+0x32b/0x350 [nfsd] (68)
 [<c0101545>] kernel_thread_helper+0x5/0x10 (161480732)
---------------------------
| preempt count: 00000000 ]
| 0-level deep critical section nesting:
----------------------------------------

------------------------------
| showing all locks held by: |  (nfsd/6145 [f6cfb070,  59]):
------------------------------

#001:             [f8bb5cc4] {client_sema.lock}
... acquired at:               rt_down+0x1e/0x40

#002:             [c0422164] {kernel_sem.lock}
... acquired at:               rt_down+0x1e/0x40

#003:             [c207b6c0] {mm/slab.c:150}
... acquired at:               drain_cpu_caches+0x64/0xc0

#004:             [f6b61c6c] {&parent->list_lock}
... acquired at:               drain_cpu_caches+0x6f/0xc0

BUG: using smp_processor_id() in preemptible [00000000] code: nfsd/6145
caller is drain_array_locked+0x1f/0xd0
 [<c0104496>] show_trace+0x26/0x30 (20)
 [<c01045e3>] dump_stack+0x23/0x30 (20)
 [<c0291aeb>] debug_smp_processor_id+0xab/0xc0 (32)
 [<c017782f>] drain_array_locked+0x1f/0xd0 (44)
 [<c01760dd>] drain_cpu_caches+0x8d/0xc0 (44)
 [<c0176206>] __cache_shrink+0x26/0xc0 (40)
 [<c0176372>] kmem_cache_destroy+0x72/0x1e0 (28)
 [<f8b9e3d8>] nfsd4_free_slab+0x28/0x60 [nfsd] (24)
 [<f8b9e433>] nfsd4_free_slabs+0x23/0x40 [nfsd] (12)
 [<f8ba281c>] nfs4_state_shutdown+0x1c/0x30 [nfsd] (8)
 [<f8b8369b>] nfsd+0x32b/0x350 [nfsd] (68)
 [<c0101545>] kernel_thread_helper+0x5/0x10 (161480732)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c0291aa0>] .... debug_smp_processor_id+0x60/0xc0
.....[<c017782f>] ..   ( <= drain_array_locked+0x1f/0xd0)

------------------------------
| showing all locks held by: |  (nfsd/6145 [f6cfb070, 115]):
------------------------------

#001:             [f8bb5cc4] {client_sema.lock}
... acquired at:               rt_down+0x1e/0x40

#002:             [c0422164] {kernel_sem.lock}
... acquired at:               rt_down+0x1e/0x40

#003:             [c20cb6c0] {mm/slab.c:150}
... acquired at:               drain_cpu_caches+0x64/0xc0

#004:             [f7229c6c] {&parent->list_lock}
... acquired at:               drain_cpu_caches+0x6f/0xc0

BUG: using smp_processor_id() in preemptible [00000000] code: nfsd/6145
caller is drain_array_locked+0x1f/0xd0
 [<c0104496>] show_trace+0x26/0x30 (20)
 [<c01045e3>] dump_stack+0x23/0x30 (20)
 [<c0291aeb>] debug_smp_processor_id+0xab/0xc0 (32)
 [<c017782f>] drain_array_locked+0x1f/0xd0 (44)
 [<c01760dd>] drain_cpu_caches+0x8d/0xc0 (44)
 [<c0176206>] __cache_shrink+0x26/0xc0 (40)
 [<c0176372>] kmem_cache_destroy+0x72/0x1e0 (28)
 [<f8b9e3d8>] nfsd4_free_slab+0x28/0x60 [nfsd] (24)
 [<f8b9e43f>] nfsd4_free_slabs+0x2f/0x40 [nfsd] (12)
 [<f8ba281c>] nfs4_state_shutdown+0x1c/0x30 [nfsd] (8)
 [<f8b8369b>] nfsd+0x32b/0x350 [nfsd] (68)
 [<c0101545>] kernel_thread_helper+0x5/0x10 (161480732)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c0291aa0>] .... debug_smp_processor_id+0x60/0xc0
.....[<c017782f>] ..   ( <= drain_array_locked+0x1f/0xd0)

------------------------------
| showing all locks held by: |  (nfsd/6145 [f6cfb070, 116]):
------------------------------

#001:             [f8bb5cc4] {client_sema.lock}
... acquired at:               rt_down+0x1e/0x40

#002:             [c0422164] {kernel_sem.lock}
... acquired at:               rt_down+0x1e/0x40

#003:             [c207b6c0] {mm/slab.c:150}
... acquired at:               drain_cpu_caches+0x64/0xc0

#004:             [f7229bec] {&parent->list_lock}
... acquired at:               drain_cpu_caches+0x6f/0xc0

BUG: using smp_processor_id() in preemptible [00000000] code: nfsd/6145
caller is drain_array_locked+0x1f/0xd0
 [<c0104496>] show_trace+0x26/0x30 (20)
 [<c01045e3>] dump_stack+0x23/0x30 (20)
 [<c0291aeb>] debug_smp_processor_id+0xab/0xc0 (32)
 [<c017782f>] drain_array_locked+0x1f/0xd0 (44)
 [<c01760dd>] drain_cpu_caches+0x8d/0xc0 (44)
 [<c0176206>] __cache_shrink+0x26/0xc0 (40)
 [<c0176372>] kmem_cache_destroy+0x72/0x1e0 (28)
 [<f8b9e3d8>] nfsd4_free_slab+0x28/0x60 [nfsd] (24)
 [<f8b9e44b>] nfsd4_free_slabs+0x3b/0x40 [nfsd] (12)
 [<f8ba281c>] nfs4_state_shutdown+0x1c/0x30 [nfsd] (8)
 [<f8b8369b>] nfsd+0x32b/0x350 [nfsd] (68)
 [<c0101545>] kernel_thread_helper+0x5/0x10 (161480732)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c0291aa0>] .... debug_smp_processor_id+0x60/0xc0
.....[<c017782f>] ..   ( <= drain_array_locked+0x1f/0xd0)

------------------------------
| showing all locks held by: |  (nfsd/6145 [f6cfb070, 118]):
------------------------------

#001:             [f8bb5cc4] {client_sema.lock}
... acquired at:               rt_down+0x1e/0x40

#002:             [c0422164] {kernel_sem.lock}
... acquired at:               rt_down+0x1e/0x40

#003:             [c20cb6c0] {mm/slab.c:150}
... acquired at:               drain_cpu_caches+0x64/0xc0

#004:             [f7229b6c] {&parent->list_lock}
... acquired at:               drain_cpu_caches+0x6f/0xc0

Synchronizing SCSI cache for disk sda: 
Restarting system.

--Boundary-00=_e8dTEn+v1ngjulD--
