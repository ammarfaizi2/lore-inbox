Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266762AbUG1BzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266762AbUG1BzU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 21:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266763AbUG1BzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 21:55:20 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:3509 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S266762AbUG1BzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 21:55:13 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Keith Owens <kaos@sgi.com>, linux-kernel@vger.kernel.org,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, fastboot@osdl.org
Subject: Re: Announce: dumpfs v0.01 - common RAS output API
References: <16734.1090513167@ocs3.ocs.com.au>
	<20040725235705.57b804cc.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 27 Jul 2004 19:53:01 -0600
In-Reply-To: <20040725235705.57b804cc.akpm@osdl.org>
Message-ID: <m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Keith Owens <kaos@sgi.com> wrote:
> >
> >  * How do we get a clean API to do polling mode I/O to disk?
> 
> We hope to not have to.  The current plan is to use kexec: at boot time, do
> a kexec preload of a small (16MB) kernel image.  When the main kernel
> crashes or panics, jump to the kexec kernel.  The kexec kernel will hold a
> new device driver for /dev/hmem through which applications running under
> the kexec'ed kernel can access the crashed kernel's memory.

Hmm.  I think this will require one of the kernels to run at a
non-default address in physical memory.

> Write the contents of /dev/hmem to stable storage using whatever device
> drivers are in the kexeced kernel, then reboot into a real kernel
> again.

And at this point I don't quite see why you would need /dev/hmem,
as opposed to just using /dev/mem.

Or will the crashing kernel save and compress the core dump to
somewhere in ram and the dump kernel read it out from there? 

> That's all pretty simple to do, and the quality of the platform's crash
> dump feature will depend only upon the quality of the platform's kexec
> support.

Which will largely depend on the quality of it's device drivers...
 
> People have bits and pieces of this already - I'd hope to see candidate
> patches within a few weeks.  The main participants are rddunlap, suparna
> and mbligh.

I'm sorry I missed you then.  Unfortunately this is my busiest season at work
so I wasn't able to make it to OLS this year :(

Does anyone have a proof of concept implementation?  I have been able to find
a little bit of time for this kind of thing lately and have just done
the x86-64 port.  (You can all give me a hard time about taking a year
to get back to it :)  I am in the process of breaking everything up
into their individual change patches and doing a code review so I feel
comfortable with sending the code to Andrew.  So this would be a very
good time for me to look at any code for reporting a crash dump with
a kernel started with kexec.

Eric
