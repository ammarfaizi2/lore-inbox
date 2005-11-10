Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbVKJQSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbVKJQSF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 11:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbVKJQSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 11:18:04 -0500
Received: from terminus.zytor.com ([192.83.249.54]:1505 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750770AbVKJQSD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 11:18:03 -0500
Message-ID: <43737274.1060105@zytor.com>
Date: Thu, 10 Nov 2005 08:16:52 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: prasanna@in.ibm.com
CC: Zachary Amsden <zach@vmware.com>, Ingo Molnar <mingo@elte.hu>,
       Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org,
       Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>, ananth@in.ibm.com,
       anil.s.keshavamurthy@intel.com, davem@davemloft.net
Subject: Re: [PATCH 19/21] i386 Kprobes semaphore fix
References: <200511080439.jA84diI6009951@zach-dev.vmware.com> <200511081412.05285.ak@suse.de> <4370A9F5.4060103@vmware.com> <200511091438.11848.ak@suse.de> <437227FD.6040905@vmware.com> <20051109165804.GA15481@elte.hu> <43723768.2060103@vmware.com> <20051110180954.GD8514@in.ibm.com>
In-Reply-To: <20051110180954.GD8514@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prasanna S Panchamukhi wrote:
> 
> As Ingo mentioned above, Systemtap uses kprobes infrastructure to provide
> dynamic kernel instrumentation. Using which user can add lots of probes 
> easily, so we foreed to take care of this fast path.  
> 
> Instead of calling convert_eip_to_linear() for all cases, you can
> just check if it is in kernel mode and calculate the address directly
> 
> 	if (kernel mode)
>                 addr = regs->eip - sizeof(kprobe_opcode_t);
>         else
>                 addr = convert_eip_to_linear(..);
> 
> there by avoiding call to convert_eip_to_linear () for every kernel probes.
> 
> As Andi mentioned user space probes support is in progress and 
> this address conversion will help in case of user space probes as well.
> 

Would it make sense for this to be part of convert_eip_to_linear?

	-hpa
