Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262087AbVD1PDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbVD1PDH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 11:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbVD1PDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 11:03:07 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:57959 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S262087AbVD1PC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 11:02:59 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.92,136,1112565600"; 
   d="scan'208"; a="8302990:sNHT21872256"
Message-ID: <4270FB20.50202@fujitsu-siemens.com>
Date: Thu, 28 Apr 2005 17:02:56 +0200
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
CC: Martin Schwidefsky <schwidefsky@de.ibm.com>, Jeff Dike <jdike@addtoit.com>,
       linux-kernel@vger.kernel.org,
       user-mode-linux devel 
	<user-mode-linux-devel@lists.sourceforge.net>
Subject: Re: [uml-devel] Re: Again: UML on s390 (31Bit)
References: <OF7DA21BA7.6A0D6C67-ONC1256FF1.003C86C5-C1256FF1.0047B648@de.ibm.com> <4270E813.50706@fujitsu-siemens.com>
In-Reply-To: <4270E813.50706@fujitsu-siemens.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Stroesser wrote:
> Martin Schwidefsky wrote:
> 
>> So (!entryexit & regs->gprs[2] < 0) translates to the debugger changed 
>> the
>> guest
>> system call to something illegal on the first of the two ptrace calls. So
>> the
>> patch doesn't hurt for normal, non-ptraced operation but it might hurt
>> other
>> users of ptrace.
> 
> I don't think, it hurts. If a debugger willingly sets the syscall number
> to -1, what would happen without the patch?
> The kernel will set the result -ENOSYS into grps[2]. So, even if trap
> still indicates a syscall and a signal is pending, no syscall restarting
> will be done.
> With the patch, a debugger would observe changed behavior of the kernel
> *only*, if it writes the syscall number to -1 on the first syscall
> interception and then writes the result to ERESTARTXXXXX on the second,
> while at the same time a signal is pending for the debugged process.
> 
> I assumed, that non of the current users of ptrace exactly does this.
> If I'm wrong here, the patch *really* is bad.
Addendum:
To avoid any conflicts as far as possible, the -1 written and checked
as the syscall number to reset trap could be replaced by some magic
value, which then should defined in asm/ptrace.h
In terms of performance, any method, that allows to reset trap
without an additional ptrace call, is fine.

	Bodo
