Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbWGGR1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWGGR1x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 13:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWGGR1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 13:27:52 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:57350 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932188AbWGGR1v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 13:27:51 -0400
Date: Fri, 7 Jul 2006 19:25:55 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Jan Glauber <jan.glauber@de.ibm.com>, linux-kernel@vger.kernel.org,
       systemtap@sources.redhat.com
Subject: Re: [PATCH] kprobes for s390 architecture
Message-ID: <20060707172555.GA10452@osiris.ibm.com>
References: <20060623150344.GL9446@osiris.boeblingen.de.ibm.com> <OF44DB398C.F7A51098-ON88257196.007CD277-88257196.007DC8F0@us.ibm.com> <20060623222106.GA25410@osiris.ibm.com> <20060624113641.GB10403@osiris.ibm.com> <1151421789.5390.65.camel@localhost> <20060628055857.GA9452@osiris.boeblingen.de.ibm.com> <20060707172333.GA12068@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060707172333.GA12068@localhost.localdomain>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ok, I tried, but my "better ideas" made things worse. stop_machine_run() wins:
> 
> void __kprobes arch_arm_kprobe(struct kprobe *p)
> {
>         struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
>         unsigned long status = kcb->kprobe_status;
>         struct ins_replace_args args;
> 
>         args.ptr = p->addr;
>         args.old = p->opcode;
>         args.new = BREAKPOINT_INSTRUCTION;
> 
>         kcb->kprobe_status = KPROBE_SWAP_INST;
>         stop_machine_run(swap_instruction, &args, NR_CPUS);
>         kcb->kprobe_status = status;
> }
> 
> It works, and I guess at this point is the only way to do it. I'll send out a 
> full patch with this and the other cleanups later.

How fast is this if you have to exchange several hundred instructions?
