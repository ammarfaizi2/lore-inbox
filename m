Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbUDAIrh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 03:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbUDAIrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 03:47:37 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:1149 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262788AbUDAIrf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 03:47:35 -0500
Date: Thu, 1 Apr 2004 00:42:51 -0800
From: Paul Jackson <pj@sgi.com>
To: hari@in.ibm.com
Cc: mbligh@aracnet.com, akpm@osdl.org, rddunlap@osdl.org,
       linux-kernel@vger.kernel.org, apw@shadowen.org, jamesclv@us.ibm.com
Subject: Re: BUG_ON(!cpus_equal(cpumask, tmp));
Message-Id: <20040401004251.6c36ffcf.pj@sgi.com>
In-Reply-To: <20040331044304.GA5167@in.ibm.com>
References: <20040330173620.6fa69482.akpm@osdl.org>
	<276260000.1080697873@flay>
	<20040331044304.GA5167@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hari,

I see code similar to what you are changing, also in the file:

	arch/x86_64/kernel/smp.c

Do your considerations apply here as well?

===

static void flush_tlb_others(cpumask_t cpumask, struct mm_struct *mm,
                                                unsigned long va)
{
        cpumask_t tmp;
	/* ... */
        BUG_ON(cpus_empty(cpumask));
        cpus_and(tmp, cpumask, cpu_online_map);
        BUG_ON(!cpus_equal(tmp, cpumask));
        BUG_ON(cpu_isset(smp_processor_id(), cpumask));
        if (!mm)
                BUG();
	/* ... */

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
