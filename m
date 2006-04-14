Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965182AbWDNVbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965182AbWDNVbv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 17:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965185AbWDNVbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 17:31:51 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:48569 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965182AbWDNVbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 17:31:50 -0400
Subject: Re: [PATCH 05/05] percpu i386 linker script update
From: Steven Rostedt <rostedt@goodmis.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060414212355.GB12482@mars.ravnborg.org>
References: <1145049573.1336.137.camel@localhost.localdomain>
	 <20060414212355.GB12482@mars.ravnborg.org>
Content-Type: text/plain
Date: Fri, 14 Apr 2006 17:31:47 -0400
Message-Id: <1145050307.17627.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-14 at 23:23 +0200, Sam Ravnborg wrote:
> On Fri, Apr 14, 2006 at 05:19:33PM -0400, Steven Rostedt wrote:
> > Add .data.percpu_offset section into arch/i386
> > 
> > Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> > 
> > Index: linux-2.6.17-rc1/arch/i386/kernel/vmlinux.lds.S
> > ===================================================================
> > --- linux-2.6.17-rc1.orig/arch/i386/kernel/vmlinux.lds.S	2006-04-14 15:43:49.000000000 -0400
> > +++ linux-2.6.17-rc1/arch/i386/kernel/vmlinux.lds.S	2006-04-14 15:58:08.000000000 -0400
> > @@ -62,6 +62,9 @@ SECTIONS
> >    /* rarely changed data like cpu maps */
> >    . = ALIGN(32);
> >    .data.read_mostly : AT(ADDR(.data.read_mostly) - LOAD_OFFSET) { *(.data.read_mostly) }
> > +  __per_cpu_offset_start = .;
> > +  .data.percpu_offset  : AT(ADDR(.data.percpu_offset) - LOAD_OFFSET) { *(.data.percpu_offset) }
> > +  __per_cpu_offset_end = .;
> >    _edata = .;			/* End of data section */
> >  
> >    . = ALIGN(THREAD_SIZE);	/* init_task */
> 
> Can we please have this definition in:
> include/asm-generic/vmlinux.lds.h
> 
> At least it looks to make sense for other arch's than just i386.
> 
> Something like
> #define PERCPU_OFFSET \
> ...

Sounds good, thanks!

-- Steve


