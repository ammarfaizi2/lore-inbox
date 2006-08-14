Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752069AbWHNVCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbWHNVCa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 17:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752067AbWHNVCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 17:02:30 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:5244 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S1752069AbWHNVC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 17:02:29 -0400
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=JFA7ON/qPU2/acuxZjAisGr11c2bekuvsM2v/Ap+qFExa1NiltjEt9KNukO5Lid3ny40jggsSy8NKetr7tOLMQqT573brync1X/b3Yhm1Qwy1wej6FAUy4LFzcM67lqR;
X-IronPort-AV: i="4.08,122,1154926800"; 
   d="scan'208"; a="61258030:sNHT28372545"
Date: Mon, 14 Aug 2006 16:02:31 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Philipp Matthias Hahn <pmhahn@svs.Informatik.Uni-Oldenburg.de>
Cc: openipmi-developer@lists.sourceforge.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Soft lockup (and reboot): IPMI
Message-ID: <20060814210231.GB3637@lists.us.dell.com>
References: <44E0A176.8070907@svs.Informatik.Uni-Oldenburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E0A176.8070907@svs.Informatik.Uni-Oldenburg.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2006 at 06:14:46PM +0200, Philipp Matthias Hahn wrote:
> Hello!
> 
> While playing with "openipmigui", the server just rebooted with the
> following last message:
> 
> BUG: soft lockup detected on CPU#0!
> <c0103416> show_trace+0xd/0xf
> <c01034e5> dump_stack+0x15/0x17
> <c01382b0> softlockup_tick+0x9d/0xae
> <c012190a> run_local_timers+0x12/0x14
> <c0121748> update_process_times+0x3c/0x61
> <c010e1d9> smp_apic_timer_interrupt+0x57/0x5f
> <c010307c> apic_timer_interrupt+0x1c/0x24
> <f8aa8783> ipmi_thread+0x43/0x71 [ipmi_si]
> <c0129e62> kthread+0x78/0xa0
> <c0100e31> kernel_thread_helper+0x5/0xb
> 
> Any idea on what went wrong?

What kernel please?  If 2.6.17 or higher, this is new.  If < 2.6.17,
this is most likely due to the udelay(1) call in ipmi_thread() which
in 2.6.17 was replaced with a schedule().

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
