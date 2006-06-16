Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751456AbWFPPbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbWFPPbU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 11:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbWFPPbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 11:31:20 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:45516 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1751453AbWFPPbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 11:31:19 -0400
Message-ID: <4492CEC0.2080102@bull.net>
Date: Fri, 16 Jun 2006 17:31:12 +0200
From: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en, fr, hu
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: Jes Sorensen <jes@sgi.com>, Tony Luck <tony.luck@intel.com>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org,
       libc-alpha@sourceware.org, vojtech@suse.cz, linux-ia64@vger.kernel.org
Subject: Re: FOR REVIEW: New x86-64 vsyscall vgetcpu()
References: <200606140942.31150.ak@suse.de> <44929CE6.4@sgi.com> <4492A5E4.9050702@bull.net> <200606161656.40930.ak@suse.de>
In-Reply-To: <200606161656.40930.ak@suse.de>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 16/06/2006 17:35:06,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 16/06/2006 17:35:06,
	Serialize complete at 16/06/2006 17:35:06
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> That is not how user space TLS works. It usually has a base a register.

Can you please give me a real life (simplified) example?

> This means it cannot be cache colored (because you would need a static
> offset) and you couldn't share task_structs on a page.

I do not see the problem. Can you explain please?
E.g. the scheduler pulls a task instead of the current one. The CPU
will see "current->thread_info.cpu"-s of all the tasks at the same
offset anyway.

> Also you would make task_struct part of the userland ABI which
> seems like a very very bad idea to me. It means we couldn't change
> it anymore.

We can make some wrapper, e.g.:

	user_per_cpu_var(name, offset)

"vgetcpu()" would also be added to the ABI which we couldn't change
easily either.

Thanks,

Zoltan
