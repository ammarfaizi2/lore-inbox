Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbUJ2RNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbUJ2RNW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 13:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263382AbUJ2RMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 13:12:40 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:15381 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261390AbUJ2RME
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 13:12:04 -0400
Date: Fri, 29 Oct 2004 21:12:31 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
Subject: Re: New kbuild filename: Kbuild
Message-ID: <20041029191231.GB8246@mars.ravnborg.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	linux-arch@vger.kernel.org
References: <20041028185917.GA9004@mars.ravnborg.org> <20041028190020.GB9004@mars.ravnborg.org> <20041029115903.GC11391@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029115903.GC11391@infradead.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 12:59:03PM +0100, Christoph Hellwig wrote:
> On Thu, Oct 28, 2004 at 09:00:20PM +0200, Sam Ravnborg wrote:
> > kbuild: Prefer Kbuild as name of the kbuild files
> >    
> > The kbuild syntax is unique and does only have very few things in common with
> > usual Makefile syntax. So to avoid confusion make the filename 'Kbuild' be
> > the preferred name as replacement for 'Makefile'.
> > No global renaming planned to take place for now, but new stuff expected to use
> > the new 'Kbuild' filename.
> 
> Disagree.  These are just makefiles, and renaming for the sake of it
> doesn't buy us.
Makefiles are valid input files to make, and the kbuild files has
for a long time had their own documented syntax.
Introduce the Kbuild name just makes this even more apperant for the reader.

When we in two years time start to deal with external modules that only support
kernel 2.6.10 and never then we can avoid the ugly:

ifeq ($(KERNELRELEASE),)
...

To separate out the real makefile and the Kbuild stuff.

> If you really want to improve things implement something like
> 
>  module foo.ko
>  sources foo.c blah.c
>  sources foobar.c if FOO_BAR
> 
> in Kconfig and get rid of driver makefiles compeltely

I'm in favour of this too - but so far Roman has rejected it.
But this still leaves out the other parts where the Kbuild name makes
more sense.

PArt of the longer term plaaning is a split of
arch/$(ARCH)/Makefile in a Kbuild.define and Kbuild.rules part.
This split will allows the kbuild infrastructure to be used
also for the top-level part of the kernel - and the next generation
kbuild will read in all relevant Kbuild files and create a single
Makfilefile for that part of the kernel compilation.

This is part of the vision at least - introducing kbuild
contant in Kconfig files is not a hindering for this.

	Sam
