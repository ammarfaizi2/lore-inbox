Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbUC3XUs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 18:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbUC3XUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 18:20:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:56514 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261661AbUC3XUh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 18:20:37 -0500
Date: Tue, 30 Mar 2004 15:17:29 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: hari@in.ibm.com
Cc: akpm@osdl.org, mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: BUG_ON(!cpus_equal(cpumask, tmp));
Message-Id: <20040330151729.1bd0c5d0.rddunlap@osdl.org>
In-Reply-To: <20040330132832.GA5552@in.ibm.com>
References: <006701c415a4$01df0770$d100000a@sbs2003.local>
	<20040329162123.4c57734d.akpm@osdl.org>
	<20040329162555.4227bc88.akpm@osdl.org>
	<20040330132832.GA5552@in.ibm.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2004 18:58:32 +0530 Hariprasad Nellitheertha wrote:

| Hello Andrew,
| 
| We faced this problem starting 2.6.3 while working on kexec. 
| 
| The problem is because we now initialize cpu_vm_mask for init_mm with 
| CPU_MASK_ALL (from 2.6.3 onwards) which makes all bits in cpumask 1 (on SMP). 
| Hence BUG_ON(!cpus_equal(cpumask,tmp) fails. The change to set
| cpu_vm_mask to CPU_MASK_ALL was done to remove tlb flush optimizations 
| for ppc64. 
| 
| I had posted a patch for this in the earlier thread. Reposting the same
| here. This patch removes the assertion and uses "tmp" instead of cpumask. 
| Otherwise, we will end up sending IPIs to offline CPUs as well.
| 
| Comments please.

I'll just say that kexec fails without this patch and works with
it applied, so I'd like to see it merged.  If this patch isn't
acceptable, let's find out why and try to make one that is.

Thanks for the patch, Hari.

--
~Randy
"You can't do anything without having to do something else first."
-- Belefant's Law
