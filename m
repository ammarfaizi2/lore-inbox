Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262436AbVCJFDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbVCJFDT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 00:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbVCJFCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 00:02:44 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:3302 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262189AbVCJFBy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 00:01:54 -0500
Subject: Re: [Fastboot] Re: Query: Kdump: Core Image ELF Format
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, Dave Anderson <anderson@redhat.com>,
       gdb <gdb@sources.redhat.com>, fastboot <fastboot@lists.osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <m1ll8wlx82.fsf@ebiederm.dsl.xmission.com>
References: <1110286210.4195.27.camel@wks126478wss.in.ibm.com>
	 <m1br9um313.fsf@ebiederm.dsl.xmission.com>
	 <1110350629.31878.7.camel@wks126478wss.in.ibm.com>
	 <m1ll8wlx82.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Thu, 10 Mar 2005 10:32:35 +0530
Message-Id: <1110430955.3574.11.camel@wks126478wss.in.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-09 at 07:17 -0700, Eric W. Biederman wrote:
> Vivek Goyal <vgoyal@in.ibm.com> writes:
> 
> > On Tue, 2005-03-08 at 11:00 -0700, Eric W. Biederman wrote: 
> > That sounds good. But we loose the advantage of doing limited debugging
> > with gdb. Crash (or other analysis tools) will still take considerable
> > amount of time before before they are fully ready and tested.
> > 
> > How about giving user the flexibility to choose. What I mean is
> > introducing a command line option in kexec-tools to choose between ELF32
> > and ELF64 headers. For the users who are not using PAE systems, they can
> > very well go with ELF32 headers and do the debugging using gdb.
> > 
> > This also requires, setting the kernel virtual addresses while preparing
> > the headers. KVA for linearly mapped region is known in advance and can
> > be filled at header creation time and gdb can directly operate upon this
> > region.
> 
> I have no problems decorating the ELF header you are generating
> in user space with virtual addresses assuming we can reliably
> get that information.  And before a kernel crashes looks like a reasonable
> time to ask that question.  I don't currently see where you could
> derive that information.

I want to fill the virtual addresses of linearly mapped region. That is
physical addresses from 0 to MAXMEM (896 MB) are mapped by kernel at
virtual addresses PAGE_OFFSET to (PAGE_OFFSET + MAXMEM). Values of
PAGE_OFFSET and MAXMEM are already known and hard-coded.

I think I used the terminology kernel virtual address and that is adding
to the confusion. Kernel virtual addresses are not necessarily linearly
mapped. What I meant was kernel logical addresses whose associated
physical addresses differ only by a constant offset.

> 
> Beyond that I prefer a little command line tool that will do the
> ELF64 to ELF32 conversion and possibly add in the kva mapping to
> make the core dump usable with gdb.  Doing it in a separate tool
> means it is the developer who is doing the analysis who cares
> not the user who is capturing the system core dump.
> 
> But I do agree that it a use case worth solving.
> 
> Eric
> 

