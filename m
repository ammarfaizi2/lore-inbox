Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422834AbWJPTG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422834AbWJPTG2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 15:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422835AbWJPTG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 15:06:28 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55731 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1422834AbWJPTG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 15:06:27 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Lu, Yinghai" <yinghai.lu@amd.com>
Cc: "Andi Kleen" <ak@muc.de>,
       "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       yhlu.kernel@gmail.com
Subject: Re: Fwd: [PATCH] x86_64: typo in __assign_irq_vector when update pos for vector and offset
References: <5986589C150B2F49A46483AC44C7BCA412D6E2@ssvlexmb2.amd.com>
Date: Mon, 16 Oct 2006 13:03:17 -0600
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA412D6E2@ssvlexmb2.amd.com>
	(Yinghai Lu's message of "Mon, 16 Oct 2006 11:27:08 -0700")
Message-ID: <m1irikaxsa.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Lu, Yinghai" <yinghai.lu@amd.com> writes:

> With phys_flat mode, the apic will be delivered in phys mode, we only
> can use cpu real apic id as target instead of apicid mask. Because that
> only has 8 bits. 

Yes but the linux abstraction is a cpu mask.  The current vector allocator
will keep going until it finds a cpu with a free vector if you give it
a mask with multiple cpus.

So to get things going making TARGET_CPUS cpu_online_map looks like
the right thing to do.

> For io apic controllers, it seems the kernel didn't have pci_dev
> corresponding, and we can use address stored in mpc_config.

My question is are your io_apics pci devices?  Not does the kernel
have them.

So the truth is we really don't care about where the io_apics are.  We
care about the source of the irqs, but in general they will all
be on the same NUMA node.  As for using the addresses that doesn't feel
quite right as it doesn't sound like a general solution.

There are a lot of ways we can approach assigning irqs to cpus and there
is a lot of work there.  I think Adrian Bunk has been doing some work
with the user space irq balancer, and should probably be involved.

Anyway this is all 2.6.20+ work to get the kernel to have a sane default.
As soon as 2.6.19 is solid I will worry about the future.

Eric

