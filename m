Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264526AbTDYVmy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 17:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264533AbTDYVmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 17:42:54 -0400
Received: from zero.aec.at ([193.170.194.10]:13581 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264526AbTDYVmw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 17:42:52 -0400
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TASK_UNMAPPED_BASE & stack location
From: Andi Kleen <ak@muc.de>
Date: Fri, 25 Apr 2003 23:54:56 +0200
In-Reply-To: <20030425204012$4424@gated-at.bofh.it> ("Martin J. Bligh"'s
 message of "Fri, 25 Apr 2003 22:40:12 +0200")
Message-ID: <m3sms644zz.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <20030425204012$4424@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:

> Is there any good reason we can't remove TASK_UNMAPPED_BASE, and just shove
> libraries directly above the program text? Red Hat seems to have patches to
> dynamically tune it on a per-processes basis anyway ...

Yes. You won't get a continuous sbrk/brk heap then anymore. Not sure it is a 
big problem though.

But apparently Solaris/x86 is doing that.

It's probably worth a sysctl at least.

> Moreover, can we put the stack back where it's meant to be, below the
> program text, in that wasted 128MB of virtual space? Who really wants 
>> 128MB of stack anyway (and can't fix their app)?

You could, but I bet it would break some programs
(e.g. just moving __PAGE_OFFSET on amd64 to 4GB for 32bit broke some things)

-Andi
