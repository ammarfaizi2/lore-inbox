Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267103AbSKMHB1>; Wed, 13 Nov 2002 02:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267116AbSKMHB1>; Wed, 13 Nov 2002 02:01:27 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:6127 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267103AbSKMHB1>;
	Wed, 13 Nov 2002 02:01:27 -0500
Date: Wed, 13 Nov 2002 12:52:33 +0530
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: Rusty Lynch <rusty@linux.co.intel.com>
Cc: rusty@rustcorp.com.au, lkml <linux-kernel@vger.kernel.org>,
       rddunlap@osdl.org, richard <richardj_moore@uk.ibm.com>,
       tom <hanrahat@us.ibm.com>
Subject: Re: [PATCH] kprobes for 2.5.47
Message-ID: <20021113125233.A3135@in.ibm.com>
Reply-To: vamsi@in.ibm.com
References: <20021112165053.A1342@in.ibm.com> <004b01c28ab8$2f89a2c0$77d40a0a@amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <004b01c28ab8$2f89a2c0$77d40a0a@amr.corp.intel.com>; from rusty@linux.co.intel.com on Tue, Nov 12, 2002 at 05:58:39PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2002 at 05:58:39PM -0800, Rusty Lynch wrote:
> When register_kprobe() is called with a bad addr, we crash the kernel.
> Should it be the reponsibility of the caller, or the kernel to make sure the
> addr is ok?
> 
kprobes is an in-kernel low-level interface for placing probes. The user
of the interface is going to be the kernel itself or a kernel module. It
is the responsibility of the caller (which too is in kernel space) to 
ensure that:

- register_kprobe is called with a valid address
- that address is at the beginning of an instruction.

So, IMO these address checks don't belong in register_kprobe.

> BTW, I have a stupid little sample char driver that reads in address/message
> pairs and then adds a probe that printk's the message at the address.  This
> was just my way of learning how to use kprobes.  Should I post it?  I would
> love to get feedback on what I did wrong, but I hate to spam the list.
> 
This driver gets input (address to put probe at) from user, like all user 
this address needs to be validated, in this driver. I am writing a kernel
module on top of kprobes that interacts with the user and provides 
higher level of functionality (similar to dprobes) than what is provided 
by the raw kprobes interface. It is in this module that all the user input
including addresses are validated before calling register_kprobe.

Regards,
Vamsi.
-- 
Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5044959
Internet: vamsi@in.ibm.com
