Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWJFNDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWJFNDU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 09:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWJFNDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 09:03:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37769 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932217AbWJFNDT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 09:03:19 -0400
Date: Fri, 6 Oct 2006 09:01:56 -0400
From: "Frank Ch. Eigler" <fche@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Vara Prasad <prasadav@us.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Frank Ch. Eigler" <fche@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Paul Mundt <lethal@linux-sh.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       systemtap <systemtap@sourceware.org>
Subject: Re: tracepoint maintainance models
Message-ID: <20061006130156.GA3566@redhat.com>
References: <20060918150231.GA8197@elte.hu> <1158594491.6069.125.camel@localhost.localdomain> <20060918152230.GA12631@elte.hu> <1158596341.6069.130.camel@localhost.localdomain> <20060918161526.GL3951@redhat.com> <1158598927.6069.141.camel@localhost.localdomain> <450EEF2E.3090302@us.ibm.com> <1158608981.6069.167.camel@localhost.localdomain> <450F0180.1040606@us.ibm.com> <1160112791.30146.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160112791.30146.12.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

On Fri, Oct 06, 2006 at 01:33:11AM -0400, Steven Rostedt wrote:
> Coming into this really late, and I'm still behind in reading this and
> related threads, but I want to throw this idea out, and it's getting
> late.
> [...]
> #define MARK(label, var)			\
> 	asm ("debug_" #label ":\n"		\
> 	     ".section .data\n"			\
> 	     #label "_" #var ": xor %0,%0\n"	\
> 	     ".previous" : : "r"(var))
> [...]
> $ gcc -O2 -o mark mark.c
> $ ./mark
> func y is in reg B at 0x80483ce
> [...]

Clever.

> Now the question is, isn't MARK() in this code a non intrusive marker?

Not quite.  The assembly code forces gcc to materialize the data that
it might already have inlined, and to borrow a register for the
duration.  It's still a neat idea though.

- FChE
