Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWHBQJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWHBQJc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 12:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbWHBQJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 12:09:32 -0400
Received: from xenotime.net ([66.160.160.81]:48832 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932076AbWHBQJa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 12:09:30 -0400
Date: Wed, 2 Aug 2006 09:12:09 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Patrick McLean <pmclean@cs.ubishops.ca>
Cc: Dave Jones <davej@redhat.com>, Andreas Schwab <schwab@suse.de>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: single bit flip detector.
Message-Id: <20060802091209.0fc8876d.rdunlap@xenotime.net>
In-Reply-To: <44D0C39D.7040408@cs.ubishops.ca>
References: <20060801184451.GP22240@redhat.com>
	<1154470467.15540.88.camel@localhost.localdomain>
	<20060801223011.GF22240@redhat.com>
	<20060801223622.GG22240@redhat.com>
	<20060801230003.GB14863@martell.zuzino.mipt.ru>
	<20060801231603.GA5738@redhat.com>
	<jebqr4f32m.fsf@sykes.suse.de>
	<20060801235109.GB12102@redhat.com>
	<20060802001626.GA14689@redhat.com>
	<44D0C39D.7040408@cs.ubishops.ca>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Aug 2006 11:24:13 -0400 Patrick McLean wrote:

> Dave Jones wrote:
> > On Tue, Aug 01, 2006 at 07:51:09PM -0400, Dave Jones wrote:
> >  > I'm going for the record of 'most times a patch gets submitted in one day'.
> >  > And to think we were complaining that patches don't get enough review ? :)
> >  > If every change had this much polish, we'd be awesome.
> > 
> > Sigh. Spaces before printk. Whatever next.
> > I am now officially bored of seeing this patch.
> > 
> > 		Dave
> > 
> > 
> > In case where we detect a single bit has been flipped, we spew
> > the usual slab corruption message, which users instantly think
> > is a kernel bug.  In a lot of cases, single bit errors are
> > down to bad memory, or other hardware failure.
> > 
> > This patch adds an extra line to the slab debug messages
> > in those cases, in the hope that users will try memtest before
> > they report a bug.
> > 
> > 000: 6b 6b 6b 6b 6a 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> > Single bit error detected. Possibly bad RAM. Run memtest86.
> > 
> > Signed-off-by: Dave Jones <davej@redhat.com>
> > 
> > +		if (errors && !(errors & (errors-1))) {
> > +			printk(KERN_ERR "Single bit error detected. Probably bad RAM.\n");
> > +#ifdef CONFIG_X86
> 
> #if defined(CONFIG_X86) || defined(CONFIG_X86_64)

CONFIG_X86 is set on both x86-32 and x86-64.


> memtest86+ runs fine on x86_64 machines as well.
> 
> > +			printk(KERN_ERR "Run memtest86+ or a similar memory test tool.\n");
> > +#else
> > +			printk(KERN_ERR "Run a memory test tool.\n");
> -


---
~Randy
