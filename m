Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbWHHG7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbWHHG7k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 02:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbWHHG7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 02:59:40 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:40378
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932476AbWHHG7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 02:59:39 -0400
Message-Id: <44D852A8.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Tue, 08 Aug 2006 08:00:24 +0100
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: "Chuck Ebbert" <76306.1226@compuserve.com>,
       "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>,
       "Andrew Morton" <akpm@osdl.org>, "Dave Jones" <davej@redhat.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc3-g3b445eea BUG: warning at 
	/usr/src/linux-git/kernel/cpu.c:51
References: <200608072042_MC3-1-C764-3AF7@compuserve.com>
 <44D84D1F.76E4.0078.0@novell.com> <200608080849.38012.ak@suse.de>
In-Reply-To: <200608080849.38012.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Andi Kleen <ak@suse.de> 08.08.06 08:49 >>>
>
>> >include/asm-i386/unwind.h::arch_unw_user_mode():
>> >        return info->regs.eip < PAGE_OFFSET
>> >               || (info->regs.eip >= __fix_to_virt(FIX_VDSO)
>> >                    && info->regs.eip < __fix_to_virt(FIX_VDSO) + PAGE_SIZE)
>> >               || info->regs.esp < PAGE_OFFSET;
>> 
>> Hmm, indeed. Then I'm unclear what the problem might be here.
>
>That code will check for the vsyscall page, but sysenter_entry isn't 
>in the vsyscall page, but in the kernel proper.
>
>So it means the EIP never actually reached the vsyscall page. It should
>have gone up another level, but didn't.

I think we had seen sysenter_past_esp in the stack trace, so it did reach
that function. The next outer level should be the VDSO page, shouldn't it?

Jan
