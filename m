Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbULFP2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbULFP2v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 10:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbULFP2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 10:28:51 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:18327 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261538AbULFP2X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 10:28:23 -0500
Date: Mon, 6 Dec 2004 20:58:03 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] kprobes: dont steal interrupts from vm86
Message-ID: <20041206152803.GC28861@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20041109130407.6d7faf10.akpm@osdl.org> <20041110104914.GA3825@in.ibm.com> <4192638C.6040007@aknet.ru> <20041117131552.GA11053@in.ibm.com> <41AF6CE0.4090500@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41AF6CE0.4090500@aknet.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Thu, Dec 02, 2004 at 10:28:32PM +0300, Stas Sergeev wrote:
> Hello.
> 
> Prasanna S Panchamukhi wrote:
> >Yes, there is a small bug in kprobes. Kprobes int3 handler
> >was returning wrong value. Please check out if the patch
> >attached with this mail fixes your problem.
> >Please let me know if you have any issues.
> Yes. After several days of debugging,
> I am pointing to this problem again.
> Unfortunately your patch appeared not
> to work. It only masks the problem.
> I was surprised that you check VM_MASK
> after you already used "addr" a couple
> of times - this "addr" is completely
> bogus and should not be used. Now this
> turned out more important. The problem
> is that the "addr" calculated only from
> the value of EIP, is bogus not only when
> VM flag is set. It is also bogus if the
> program uses segmentation and the
> CS_base!=0. I have many of the like
> programs here and they all are broken
> because kprobes still steal the int3 from
> them. They do not use V86, but they use
> segments instead of the flat layout, so
> the address cannot be calculated by the
> EIP value.

Well, a test program is always better. I 
would appreciate if you can sent me the
test program.

> I would suggest something like the attached
> patch. I know nothing about kprobes (sorry)
> so I don't know what CS you need. If you
> need not only __KERNEL_CS, you probably
> want the (regs->xcs & 4) check to see if
> the CS is not from LDT at least. Does this
> make sense?
> Anyway, would be nice to get this fixed.
> This can cause Oopses because you deref
> the completely bogus pointer later in the
> code.
> Writing a test-case for this problem is
> not a several-minutes work, but if you
> really need one, I may try to hack it out.
> 
> Thanks.
> 



Thanks
Prasanna

-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
