Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030315AbWISRIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030315AbWISRIR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 13:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030326AbWISRIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 13:08:16 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:12706 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030315AbWISRIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 13:08:16 -0400
Date: Tue, 19 Sep 2006 12:08:21 +0530
From: "S. P. Prasanna" <prasanna@in.ibm.com>
To: Martin Bligh <mbligh@google.com>
Cc: Andrew Morton <akpm@osdl.org>, "Frank Ch. Eigler" <fche@redhat.com>,
       Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers
Message-ID: <20060919063821.GB23836@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20060918234502.GA197@Krystal> <20060919081124.GA30394@elte.hu> <451008AC.6030006@google.com> <20060919154612.GU3951@redhat.com> <4510151B.5070304@google.com> <20060919093935.4ddcefc3.akpm@osdl.org> <45101DBA.7000901@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45101DBA.7000901@google.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2006 at 09:41:30AM -0700, Martin Bligh wrote:
> Andrew Morton wrote:
> >On Tue, 19 Sep 2006 09:04:43 -0700
> >Martin Bligh <mbligh@google.com> wrote:
> >
> >
> >>It seems like all we'd need to do
> >>is "list all references to function, freeze kernel, update all
> >>references, continue"
> >
> >
> >"overwrite first 5 bytes of old function with `jmp new_function'".
> 
> Yes, that's simple. but slower, as you have a double jump. Probably
> a damned sight faster than int3 though.
> 
> M.

The advantage of using int3 over jmp to launch the instrumented
module is that int3 (or breakpoint in most architectures) is an
atomic operation to insert.

I am getting some more ideas...
                                                                                                                                               
1. Copy the original functions, instrument them and insert them as
a part of kernel module with different name prefix.
2. Insert breakpoint only on those routines at runtime.
3. When the breakpoint gets hit, change the instruction pointer to
the instrumented routine.  No need to single step at all.
                                                                                                                                               
Adv:
Can be enabled/disabled dynamically by inserting/removing
breakpoints.  No overhead of single stepping.
No restriction of running the handler in interrupt context.
You can have pre-compiled instrumented routines.
This mechanism can be used for pre-defined set of routines and for
arbiratory probe points, you can use kprobes/jprobes/systemtap.
No need to be super-user for predefined breakpoints.
                                                                                                                                               
Dis:
Maintainence of the code, since it can code base need to be
duplicated and instrumented.

The above idea is similar to runtime or dynamic patching, but here we
use int3(breakpoint) rather than jump instruction.

Please correct me if I am wrong.
Please let me know if need more information.

Thanks
Prasanna


-- 
Prasanna S.P.
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-41776329
