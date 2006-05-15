Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965074AbWEOSOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965074AbWEOSOA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 14:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965075AbWEOSOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 14:14:00 -0400
Received: from ns2.suse.de ([195.135.220.15]:36570 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965077AbWEOSN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 14:13:59 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] x86 NUMA panic compile error
Date: Mon, 15 May 2006 20:13:53 +0200
User-Agent: KMail/1.9.1
Cc: Ingo Molnar <mingo@elte.hu>, apw@shadowen.org,
       linux-kernel@vger.kernel.org
References: <20060515005637.00b54560.akpm@osdl.org> <20060515175306.GA18185@elte.hu> <20060515110814.11c74d70.akpm@osdl.org>
In-Reply-To: <20060515110814.11c74d70.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605152013.53728.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 May 2006 20:08, Andrew Morton wrote:
> Ingo Molnar <mingo@elte.hu> wrote:
> >
> > 
> > * Andy Whitcroft <apw@shadowen.org> wrote:
> > 
> > >  	if (use_cyclone == 0) {
> > >  		/* Make sure user sees something */
> > > -		static const char s[] __initdata = "Not an IBM x440/NUMAQ. Don't use i386 CONFIG_NUMA anywhere else."
> > > +		static const char s[] __initdata = "Not an IBM x440/NUMAQ. Don't use i386 CONFIG_NUMA anywhere else.";
> > >  		early_printk(s);
> > >  		panic(s);
> > >  	}
> > 
> > i still strongly oppose the original Andi hack... numerous reasons were 
> > given not to apply it (it's nice to simulate/trigger rarer features on 
> > mainstream hardware too, and this ability to boot NUMA on my flat x86 
> > testbox found at least one other NUMA bug already). Furthermore, the 
> > crash i reported was fixed by the NUMA patchset.
> 
> I'll be darned.  I never knew it was even possible to run x86 numa kernels
> on non-numa boxen.  I'd have tested about 1000000 of Christoph Lameter's
> patches if someone had told me.  Yes, it's useful.

If you want to use it for that I would suggest to port the numa emulation
code at least - two or four nodes tends to find more problems than a single
node.

But testing on a 64bit box - even with numa emulation - would be much
better because on 32bit ZONE_NORMAL often is node 0 only and you won't 
get much numaness for kernel objects.
 
> 
> > Andrew, please drop:
> > 
> >   x86_64-mm-i386-numa-summit-check.patch
> 
> bang.

Ok.

> 
> > (which has nothing to do with x86_64 anyway)
> 
> True.
> 
> I guess the concern here is that we don't want people building these
> frankenkernels and then sending us bug reports against them.

Well it will still increase the bug numbers you care so much about.

Another reason I don't like it is that it's ugly and reimplements
parts of ACPI on its own for no reason.

If people use it regularly for debugging maybe it won't bit rot
as quickly as it used to be, but there is a big difference between
theory and practice so we'll see.

 
> So it is perhaps reasonable to do this panic, but only if !CONFIG_EMBEDDED? 
> (It really is time to start renaming CONFIG_EMBEDDED to CONFIG_DONT_DO_THIS
> or something).

Fine.

-Andi
