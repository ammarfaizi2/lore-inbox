Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbVCHPRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVCHPRh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 10:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVCHPRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 10:17:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44698 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261457AbVCHPRI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 10:17:08 -0500
Message-ID: <422DC166.BFFF3CC0@redhat.com>
Date: Tue, 08 Mar 2005 10:14:46 -0500
From: Dave Anderson <anderson@redhat.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-e.49.4nmi_enterprise i686)
X-Accept-Language: en
MIME-Version: 1.0
To: vivek goyal <vgoyal@in.ibm.com>
CC: fastboot <fastboot@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       haren myneni <hbabu@us.ibm.com>, Maneesh Soni <maneesh@in.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Query: Kdump: Core Image ELF Format
References: <1110286210.4195.27.camel@wks126478wss.in.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vivek goyal wrote:

> Hi,
>
> Kdump (A kexec based crash dumping mechanism) is going to export the
> kernel core image in ELF format. ELF was chosen as a format, keeping in
> mind that gdb can be used for limited debugging and "Crash" can be used
> for advanced debugging.
>
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

Not in its current state, but it can certainly be modified to do so.
The embedded gdb module never is even aware of the vmcore file.
(It is essentially executed as "gdb vmlinux").

And currently crash only expects a single PT_LOAD section, but
that's due for a change.  It's been OK for its current set of supported
processors to use sparse file space for non-existent memory,
but it's kind of a pain with ia64's 256GB holes.

The point is that adapting crash to handle whatever format
you come up with is the easy part of the whole equation.

>
> Given the limitation of analysis tools, if core headers are prepared in
> ELF32 format then how to handle PAE systems?
>

Are you asking about what would be the p_vaddr values for the higher
memory segments?   FWIW, with the single-PT_LOAD segment currently
supported by crash, there's only one p_vaddr, but in any case, crash doesn't
use it, so PAE is not a problem.

Dave Anderson


>
> Any thoughts or suggestions on this?
>
> Thanks
> Vivek

