Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262493AbUJ0PMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbUJ0PMN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 11:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbUJ0PKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 11:10:17 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:22489 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262503AbUJ0PHB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 11:07:01 -0400
Subject: 2.6.9 page allocation failures
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1098888880.20643.130.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Oct 2004 07:54:40 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I see following page allocation failures while running IO intensive
tests on 2.6.9. My tests didn't fail, so I guess its okay. But
I never saw this before.

Its on a 4-way AMD64 machine with 7GB RAM. Tests create 10 4GB files
on 10 disks (one filesystem per disk) in parallel. (dd if=/dev/zero ...)

Thanks,
Badari


swapper: page allocation failure. order:0, mode:0x20
                                                                                                          
Call Trace:<IRQ> <ffffffff8015fd9f>{__alloc_pages+815}
<ffffffff8015fa20>{__get_free_pages+16}
       <ffffffff801635c6>{kmem_getpages+38}
<ffffffff801639e9>{cache_alloc_refill+665}
       <ffffffff80163b96>{kmem_cache_alloc+54}
<ffffffff8031a85d>{scsi_get_command+45}
       <ffffffff8031edb0>{scsi_prep_fn+272}
<ffffffff802d62e8>{elv_next_request+72}
       <ffffffff8031f0a8>{scsi_request_fn+72}
<ffffffff802d96a1>{blk_run_queue+49}
       <ffffffff8031f6af>{scsi_end_request+223}
<ffffffff8031f90d>{scsi_io_completion+573}
       <ffffffff80319c26>{scsi_finish_command+214}
<ffffffff8031a56a>{scsi_softirq+234}
       <ffffffff8013dc11>{__do_softirq+113}
<ffffffff8013dcc5>{do_softirq+53}
       <ffffffff80113f1f>{do_IRQ+335}
<ffffffff80110d27>{ret_from_intr+0}
        <EOI> <ffffffff8010f5d0>{default_idle+0}
<ffffffff8010f5f0>{default_idle+32}
       <ffffffff8010f9fd>{cpu_idle+29}


