Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751410AbVKOPtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbVKOPtX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 10:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbVKOPtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 10:49:23 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:30623 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1751410AbVKOPtW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 10:49:22 -0500
Date: Tue, 15 Nov 2005 07:49:05 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Andi Kleen <ak@muc.de>, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Arnd Bergmann <arnd@arndb.de>,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
       paulus@samba.org, stephane.eranian@hp.com
Subject: Re: + perfmon2-reserve-system-calls.patch added to -mm tree
Message-ID: <20051115154905.GC24983@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <B8E391BBE9FE384DAA4C5C003888BE6F04F630BF@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F04F630BF@scsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tony,

On Tue, Nov 15, 2005 at 07:28:35AM -0800, Luck, Tony wrote:
> 
> >> Either way, either the emulation is in the kernel or it's not. If it's
> >> there (like it is now) it deserves maintenance. If it's not, it should
> >> be removed from the tree, since the only thing it's otherwise good for
> >> is potential security holes.
> >
> >I suppose it's still useful for all current IA64 users (Montecito
> >is not shipping yet and older CPUs support x86 in hardware) who don't like 
> >binary only software.
> 
> I was planning on asking who still depends on the emulation code
> a while after Montecito is shipping.  Until then I'll try to do
> what makes sense in keeping the ia32 emulation system call table
> up to date.
> 
> The perfmon syscalls would be an example of something that should
> *NOT* go into the ia32 emulation syscall table.  It makes no sense
> whatever to put them there.  I don't believe that the h/w emulation
> provides any performance counter emulation, and even if it did a
> user who cared about the performance of their application would do
> far better to re-compile it as native ia64 than to mess around
> trying to optimize their x86 binary.
> 
I agree. The PMU between, let's a P4, and IA-64 is totally
different. It does not make sense to try and emulate the P4
PMU on an Ia-64 system. Similarly, it  does not make sense
to develop a monitoring tool for IA-64 compiled in X86 mode
and relying on the emulation layer. 

The only thing we need to ensure is that those system calls
don't do anything, i.e., if ever invoked in IA-32 HW emulation
they would need to go to sys_ni().

-- 

-Stephane
