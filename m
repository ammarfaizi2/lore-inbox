Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964954AbVKHNMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbVKHNMg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 08:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbVKHNMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 08:12:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:58792 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964954AbVKHNMf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 08:12:35 -0500
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [PATCH 19/21] i386 Kprobes semaphore fix
Date: Tue, 8 Nov 2005 14:12:04 +0100
User-Agent: KMail/1.8
Cc: Zachary Amsden <zach@vmware.com>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
References: <200511080439.jA84diI6009951@zach-dev.vmware.com>
In-Reply-To: <200511080439.jA84diI6009951@zach-dev.vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511081412.05285.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 November 2005 05:39, Zachary Amsden wrote:
> IA-32 linear address translation is loads of fun.

Thanks for doing that audit work. Can you please double check x86-64 code is
ok? 

Actually giving all that complexity maybe it would be better to just
stop handling the case and remove all that. I'm not sure what kprobes needs it 
for - it doesn't even handle user space yet and even if it ever does it is 
unlikely that handling 16bit code makes much sense. And the prefetch 
workaround does it, but 16bit DOS code is unlikely to contain prefetches 
anyways. And for ptrace - well, who cares? I suppose dosemu has an own
debugger anyways and it could be handled in user space (i suppose
they still have that code from 2.4 anyways)

> While cleaning up the LDT code, I noticed that kprobes code was very bogus
> with respect to segment handling.  Many, many bugs are fixed here.  I chose
> to combine the three separate functions that try to do linear address
> conversion into one, nice and working functions.  All of the versions had
> bugs.
>
> 1) Taking an int3 from v8086 mode could cause the kprobes code to read a
>    non-existent LDT.
>
> 2) The CS value was not truncated to 16 bit, which could cause an access
>    beyond the bounds of the LDT.

That's a (small) security hole, isn't it?


-Andi
