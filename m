Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbVCHSEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVCHSEa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 13:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVCHSEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 13:04:30 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:41949 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261460AbVCHSDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 13:03:10 -0500
To: vivek goyal <vgoyal@in.ibm.com>
Cc: fastboot <fastboot@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       anderson@redhat.com, haren myneni <hbabu@us.ibm.com>,
       Maneesh Soni <maneesh@in.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: Query: Kdump: Core Image ELF Format
References: <1110286210.4195.27.camel@wks126478wss.in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 08 Mar 2005 11:00:08 -0700
In-Reply-To: <1110286210.4195.27.camel@wks126478wss.in.ibm.com>
Message-ID: <m1br9um313.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vivek goyal <vgoyal@in.ibm.com> writes:

> Hi,
> 
> Kdump (A kexec based crash dumping mechanism) is going to export the
> kernel core image in ELF format. ELF was chosen as a format, keeping in
> mind that gdb can be used for limited debugging and "Crash" can be used
> for advanced debugging.

When I suggested ELF for this purpose it was not so much that it was
directly usable.  But rather it was an existing file format that could
do the job, was well understood, and had enough extensibility
through the PT_NOTES segment to handle the weird cases.

> Core image ELF headers are prepared before crash and stored at a safe
> place in memory. These headers are retrieved over a kexec boot and final
> elf core image is prepared for analysis. 
> 
> Given the fact physical memory can be dis-contiguous, One program header
> of type PT_LOAD is created for every contiguous memory chunk present in
> the system. Other information like register states etc. is captured in
> notes section.
> 
> Now the issue is, on i386, whether to prepare core headers in ELF32 or
> ELF64 format. gdb can not analyze ELF64 core image for i386 system. I
> don't know about "crash". Can "crash" support ELF64 core image file for
> i386 system?
> 
> Given the limitation of analysis tools, if core headers are prepared in
> ELF32 format then how to handle PAE systems? 
> 
> Any thoughts or suggestions on this?

Generate it ELF64.  We also have the problem that the kernels virtual
addresses are not used in the core dump either.   Which a post-processing
tool will also have to address as well. 

What I aimed at was a simple picture of memory decorated with the
register state.  We should be able to derive everything beyond that.
And the fact that it is all in user space should make it straight
forward to change if needed.

Eric
