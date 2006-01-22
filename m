Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbWAVTbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbWAVTbe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 14:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWAVTbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 14:31:34 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:42659 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1751321AbWAVTbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 14:31:33 -0500
Subject: Re: ip_contrack refuses to load if built UP as a module on IA64
From: dann frazier <dannf@hp.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, linux-ia64@vger.kernel.org,
       dmosberger@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <1136928071.11049.19.camel@krebs.dannf>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0443A5FA@scsmsx401.amr.corp.intel.com>
	 <ed5aea430508301229386fc596@mail.gmail.com>
	 <17172.54563.329758.846131@wombat.chubb.wattle.id.au>
	 <17174.35525.283392.703723@berry.gelato.unsw.EDU.AU>
	 <1127426700.25159.63.camel@krebs.dannf>
	 <20051219210750.GA15849@agluck-lia64.sc.intel.com>
	 <1136928071.11049.19.camel@krebs.dannf>
Content-Type: text/plain
Date: Sun, 22 Jan 2006 12:31:20 -0700
Message-Id: <1137958281.31860.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-10 at 14:21 -0700, dann frazier wrote:
> On Mon, 2005-12-19 at 13:07 -0800, Luck, Tony wrote: 
> > On Thu, Sep 22, 2005 at 04:04:59PM -0600, dann frazier wrote:
> > > On Thu, 2005-09-01 at 14:59 +1000, Peter Chubb wrote:
> > > > 
> > > > This patch makes UP and SMP do the same thing as far as module per-cpu
> > > > data go.
> > > > 
> > > > Unfortunately it affects core code.
> > > 
> > > It causes 2.6.13/x86 to fail to link:
> > > kernel/built-in.o: In function `load_module':
> > > : undefined reference to `percpu_modcopy'
> > > make: *** [.tmp_vmlinux1] Error 1
> > > 
> > > fyi, this is a problem we're seeing in the Debian UP packages:
> > >   http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=325070
> > 
> > Another possible solution is to make ia64 more like other
> > architectures and make per-cpu variables just turn into
> > ordinary variables on UP.  There are some pros and cons to
> > this:
> > 
> > +) Being more like other architectures makes it less likely that
> >    we'll be burned by changes in generic code/tools that depend
> >    on implementation details
> > 
> > -) We probably get worse code to access per-cpu variables from
> >    C-compiled code, and definitely get worse code in a couple of
> >    critical paths in assembler (where an "addl" becomes a "movl")
> > 
> > Here's the patch ... lightly tested (just booted and checked that
> > I could load the ip_conntrack module).
> 
> Thanks Tony; sorry for taking so long to test this.  I required an
> additional change to discontig.c to get this to build w/ the Debian
> config.  With this additional patch, a UP kernel boots fine on my
> rx2600.

fyi, just noticed that the efivars module still doesn't load.


