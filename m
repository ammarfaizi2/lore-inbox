Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVGGKi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVGGKi7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 06:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVGGKgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 06:36:49 -0400
Received: from ns2.suse.de ([195.135.220.15]:5080 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261169AbVGGKeX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 06:34:23 -0400
Date: Thu, 7 Jul 2005 12:34:21 +0200
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: prasanna@in.ibm.com, ak@suse.de, davem@davemloft.net,
       systemtap@sources.redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [1/6 PATCH] Kprobes : Prevent possible race conditions generic changes
Message-ID: <20050707103421.GU21330@wotan.suse.de>
References: <20050707101015.GE12106@in.ibm.com> <20050707032537.7588acb9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050707032537.7588acb9.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2005 at 03:25:37AM -0700, Andrew Morton wrote:
> Prasanna S Panchamukhi <prasanna@in.ibm.com> wrote:
> >
> > There are possible race conditions if probes are placed on routines within the
> > kprobes files and routines used by the kprobes.
> 
> So...  don't do that then?  Is it likely that anyone would want to stick a
> probe on the kprobe code itself?

iirc one goal of systemtap (which uses kprobes) is to be provable
safe so that an user cannot crash the kernel by adding probes. Basically
to make it possible to use this on production systems safely. I have my
doubts they will fully reach it, but at least it's a nice goal.

> > -int register_kprobe(struct kprobe *p)
> > +static int __kprobes in_kprobes_functions(unsigned long addr)
> > +{
> > +	/* Linker adds these: start and end of __kprobes functions */
> > +	extern char __kprobes_text_start[], __kprobes_text_end[];
> 
> There's an old unix convention that section markers (start, end, edata,
> etc) are declared `int'.  For some reason we don't do that in the kernel. 
> Oh well.

The Linux convention is to put it into asm-generic/sections.h at least.

-Andi
