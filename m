Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262937AbTJPNfc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 09:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbTJPNfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 09:35:32 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:37046
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S262955AbTJPNfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 09:35:20 -0400
Date: Thu, 16 Oct 2003 15:35:52 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: riel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23-pre VM regression?
Message-ID: <20031016133552.GD1348@velociraptor.random>
References: <20031016132412.GB1348@velociraptor.random> <Pine.LNX.4.44.0310161028080.2388-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310161028080.2388-100000@logos.cnet>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 16, 2003 at 10:29:16AM -0200, Marcelo Tosatti wrote:
> 
> 
> On Thu, 16 Oct 2003, Andrea Arcangeli wrote:
> 
> > On Thu, Oct 16, 2003 at 09:52:30AM -0200, Marcelo Tosatti wrote:
> > > 
> > > Andrea, 
> > > 
> > > Martin first reported problems with "gzip -dc file | less" (280MB file).
> > > less was getting killed. He had no swap... I asked him to add some swap
> > > and it works now. Fine. 
> > > 
> > > The thing is that with 2.4.22 less was being killed, but with 2.4.23-pre
> > > he gets:
> > 
> > note, that's a true oom, less needs to allocate 280MB and it doesn't fit
> > in ram. there's no bug as far as I can tell.
> >
> > a `vmstat 1` could confirm that.
> > 
> > > >> And yes, the app was killed:
> > > > >
> > > > > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> > > > > VM: killing process named
> > > > > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> > > > > VM: killing process gpm
> > > > > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> > > > > VM: killing process sendmail
> > > > > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> > > > > VM: killing process less
> > 
> > here the vm keeps killing until 'less' - the real offender - is nuked.
> > 
> > > So a lot of processes which should not get killed are dying. This is
> > > really bad. I was afraid it could happen and it did.
> > > 
> > > What now? Resurrect OOM-killer? 
> > 
> > the oom killer has the problem I outlined some email ago, with shared
> > memory it gets fooled badly etc.., though in a desktop with all tiny
> > tasks except the memory-hog (`less` in this case) it works well.
> 
> Andrea,
> 
> There is no memory. Right. Some task has to be killed. But not small
> programs like sendmail/named/etc. What should be killed is "less". That is
> clear, right?

sure. I think I already explained there are downsides in disabling the
oom killer for desktops where the offender task is normally the biggest
one too, but those downsides aren't something I care about given the
cases it gets right w/o it (i.e. huge-shm-SGA/mlock/oomdeadlocks). the
oom killer can do the wrong decision too sometime, and more
systematically as well.

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
