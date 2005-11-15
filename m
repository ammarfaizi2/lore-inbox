Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbVKOIBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbVKOIBQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 03:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbVKOIBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 03:01:16 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:1733 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1751357AbVKOIBQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 03:01:16 -0500
Date: Tue, 15 Nov 2005 00:00:55 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, ak@muc.de,
       benh@kernel.crashing.org, paulus@samba.org, stephane.eranian@hp.com,
       tony.luck@intel.com
Subject: Re: + perfmon2-reserve-system-calls.patch added to -mm tree
Message-ID: <20051115080055.GA24236@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200511142329.jAENTfmS004600@shell0.pdx.osdl.net> <200511150050.27556.arnd@arndb.de> <20051114171226.680cddc8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051114171226.680cddc8.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

On Mon, Nov 14, 2005 at 05:12:26PM -0800, Andrew Morton wrote:
> aargh.  Any time anyone dinks with the syscall tables I have tons of fun
> fixing up rejects.  It doesn't help that both Stephane and Christoph's
> patches were fairly broken.
> 
> Rules:
> 
> a) Keep unistd.h and the syscall tables in sync.
> 
> b) Keep ppc32 and powerpc[64] in sync
> 
> c) Add prototypes to syscalls.h (When the implementation goes in -
>    obviously not relevant when we're just reserving syscall slots)
> 
> d) Some architectures have multiple syscall tables.  Stephane, you
>    missed arch/ia64/ia32/ia32_entry.S, for example.  But then, that looks
>    to be seriously out of date anyway.  No idea what's going on there.
> 

This one corresponds to the system call table for X86 binaries running
on Linux/ia64. This is used in combination with the hardware emulation
in the processor. This is being replaced by full user level translation
by Intel's IA32el libraries. The x86 binary is translated to IA-64 native
code in user mode and then it makes IA-64 system calls. As such, the IA-32
syscall emulation table is becoming obsolete as people upgrade to newer 
Linux distributions using IA32el. Tony correct me if I missed something.

> e) review your work carefully.  Grep the tree for, say, `getxattr' (or
>    any other syscall name which is unique-looking and which you expect all
>    architectures to implement).
> 
> Anyway, I have a shower of fixup patches here.   Hopefully it all landed OK.

I apologize for generating some extra work for you. I saw you fixed the powerpc
request for those two extra syscalls. Thanks.

-- 
-Stephane
