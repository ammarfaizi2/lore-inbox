Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbVCIOVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbVCIOVW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 09:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVCIOVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 09:21:22 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:11488 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261681AbVCIOVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 09:21:19 -0500
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Dave Anderson <anderson@redhat.com>,
       gdb <gdb@sources.redhat.com>, fastboot <fastboot@lists.osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] Re: Query: Kdump: Core Image ELF Format
References: <1110286210.4195.27.camel@wks126478wss.in.ibm.com>
	<m1br9um313.fsf@ebiederm.dsl.xmission.com>
	<1110350629.31878.7.camel@wks126478wss.in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 09 Mar 2005 07:17:49 -0700
In-Reply-To: <1110350629.31878.7.camel@wks126478wss.in.ibm.com>
Message-ID: <m1ll8wlx82.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

> On Tue, 2005-03-08 at 11:00 -0700, Eric W. Biederman wrote: 
> That sounds good. But we loose the advantage of doing limited debugging
> with gdb. Crash (or other analysis tools) will still take considerable
> amount of time before before they are fully ready and tested.
> 
> How about giving user the flexibility to choose. What I mean is
> introducing a command line option in kexec-tools to choose between ELF32
> and ELF64 headers. For the users who are not using PAE systems, they can
> very well go with ELF32 headers and do the debugging using gdb.
> 
> This also requires, setting the kernel virtual addresses while preparing
> the headers. KVA for linearly mapped region is known in advance and can
> be filled at header creation time and gdb can directly operate upon this
> region.

I have no problems decorating the ELF header you are generating
in user space with virtual addresses assuming we can reliably
get that information.  And before a kernel crashes looks like a reasonable
time to ask that question.  I don't currently see where you could
derive that information.

Beyond that I prefer a little command line tool that will do the
ELF64 to ELF32 conversion and possibly add in the kva mapping to
make the core dump usable with gdb.  Doing it in a separate tool
means it is the developer who is doing the analysis who cares
not the user who is capturing the system core dump.

But I do agree that it a use case worth solving.

Eric
