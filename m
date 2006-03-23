Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWCWFkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWCWFkq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 00:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbWCWFkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 00:40:46 -0500
Received: from xenotime.net ([66.160.160.81]:59621 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932188AbWCWFkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 00:40:46 -0500
Date: Wed, 22 Mar 2006 21:42:57 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: jzb@aexorsyst.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: BIOS causes (exposes?) modprobe (load_module) kernel oops
Message-Id: <20060322214257.1ef798e5.rdunlap@xenotime.net>
In-Reply-To: <200603222126.56720.jzb@aexorsyst.com>
References: <200603212005.58274.jzb@aexorsyst.com>
	<1143018365.2955.49.camel@laptopd505.fenrus.org>
	<200603221948.00568.jzb@aexorsyst.com>
	<200603222126.56720.jzb@aexorsyst.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2006 21:26:56 -0800 John Z. Bohach wrote:

> On Wednesday 22 March 2006 19:48, John Z. Bohach wrote:
> > On Wednesday 22 March 2006 01:06, Arjan van de Ven wrote:
> > > On Tue, 2006-03-21 at 20:05 -0800, John Z. Bohach wrote:
> > > > Linux 2.6.14.2, yeah, I know, and sorry if this has been fixed...but
> > > > read on, please, this is a new take...
> > >
> > > at least enable CONFIG_KALLSYMS to get us a readable backtrace
> >
> > I'll do you one better:  here's the failing line from module.c:
> >
> > 	/* Determine total sizes, and put offsets in sh_entsize.  For now
> > 	   this is done generically; there doesn't appear to be any
> > 	   special cases for the architectures. */
> > 	layout_sections(mod, hdr, sechdrs, secstrings);
> >
> > 	/* Do the allocs. */
> > 	ptr = module_alloc(mod->core_size);
> > 	if (!ptr) {
> > 		err = -ENOMEM;
> > 		goto free_percpu;
> > 	}
> > !!! --->	memset(ptr, 0, mod->core_size);
> > 	mod->module_core = ptr;
> >
> 
> Let me summarize this a little better:
> 
> ptr = module_alloc(mod->core_size);
> 
> is fine, but when a few lines later, memset() tries to operate on that same
> ptr to zero it out with
> 
> memset(ptr, 0, mod->core_size);
> 
> I get:
> 
> Unable to handle kernel paging request at virtual address f8806000
> (f8806000 is (in this case) the value of ptr returned by module_alloc()).
> 
> I've validated the parameters, they all look okay.  I think the page fault for ptr
> is normal(?), and the page fault handler is suppossed to set up this page???
> but fails...
> 
> Yet it succeeds with a different BIOS and bootloader, is what I'm trying to say.
> 
> So it seems that the page fault handler is somehow affected by something that the
> BIOS has/has not done, long after the system has booted and been running, with
> many page faults under its belt...now I've seen it all...or not.

Sounds like we need to see complete boot logs from both BIOSen boots.
Can you do that?

I'm just guessing that the memory maps are different, but who knows.

---
~Randy
