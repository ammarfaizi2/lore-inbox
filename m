Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267176AbSLRFwj>; Wed, 18 Dec 2002 00:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267182AbSLRFwj>; Wed, 18 Dec 2002 00:52:39 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:14514 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S267176AbSLRFwi>; Wed, 18 Dec 2002 00:52:38 -0500
Message-ID: <3E000EF9.8070001@quark.didntduck.org>
Date: Wed, 18 Dec 2002 01:00:25 -0500
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
CC: "Nakajima, Jun" <jun.nakajima@intel.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       hpa@transmeta.com
Subject: Re: Intel P6 vs P7 system call performance
References: <3014AAAC8E0930438FD38EBF6DCEB564419C95@fmsmsx407.fm.intel.com> <3DFFD55E.6020305@redhat.com>
In-Reply-To: <3DFFD55E.6020305@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> Nakajima, Jun wrote:
> 
>>AMD (at least Athlon, as far as I know) supports sysenter/sysexit. We tested it on an Athlon box as well, and it worked fine. And sysenter/sysexit was better than int/iret too (about 40% faster) there. 
> 
> 
> That's good to know but not what I meant.
> 
> I referred to syscall/sysret opcodes.  They are broken in their own way
> (destroying ecx on kernel entry) but at least they preserve eip.
> 

syscall is pretty much unusable unless the NMI is changed to a task 
gate.  syscall does not change %esp on entry to the kernel, so an NMI 
before the manual stack switch would still use the user stack, which is 
not guaranteed to be valid - oops.  x86-64 gets around this by using an 
interrupt stack, its replacement for task gates.

--
				Brian Gerst

