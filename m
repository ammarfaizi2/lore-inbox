Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965032AbWCULI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbWCULI7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 06:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbWCULI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 06:08:59 -0500
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:16816 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP id S965032AbWCULI6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 06:08:58 -0500
In-Reply-To: <20060321020521.36e98f6d.akpm@osdl.org>
Subject: Re: [3/3 PATCH] Kprobes: User space probes support- single stepping
 out-of-line
Sensitivity: 
To: Andrew Morton <akpm@osdl.org>
Cc: ak@suse.de, davem@davemloft.net, linux-kernel@vger.kernel.org,
       prasanna@in.ibm.com, suparna@in.ibm.com
X-Mailer: Lotus Notes Release 6.5.1IBM February 19, 2004
Message-ID: <OF2F8CF695.5309957A-ON80257138.003C444C-80257138.003CED39@uk.ibm.com>
From: Richard J Moore <richardj_moore@uk.ibm.com>
Date: Tue, 21 Mar 2006 11:05:28 +0000
X-MIMETrack: Serialize by Router on D06ML065/06/M/IBM(Release 6.53HF247 | January 6, 2005) at
 21/03/2006 11:09:20
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org






Andrew Morton <akpm@osdl.org> wrote on 21/03/2006 10:05:21:

> Prasanna S Panchamukhi <prasanna@in.ibm.com> wrote:
> >
> > >
> >  > > > > +   addr = (kprobe_opcode_t *)kmap_atomic(page, KM_USER1);
> >  > > > > +   addr = (kprobe_opcode_t *)((unsigned long)addr +
> >  > > > > +             (unsigned long)(uprobe->offset & ~PAGE_MASK));
> >  > > > > +   *addr = opcode;
> >  > > > > +   /*TODO: flush vma ? */
> >  > > >
> >  > > > flush_dcache_page() would be needed.
> >  > > >
> >  > > > But then, what happens if the page is shared by other
> processes?  Do they
> >  > > > all start taking debug traps?
> >  > >
> >  > > Yes, you are right. I think single stepping inline was a bad
> idea, disarming
> >  > > the probe looks to be a better option
> >  > >
> >  >
> >  > You skipped my second question?
> >
> >  There is a small window in which other processor will not be able to
see
> >  the breakpoint if we are single step inline. But since single
> stepping inline
> >  is a bad idea, we will disarm the probe forever (replace with
> original instrcution) if we cannot single step out-of-line.
> >  Any suggestions?
>
> This doesn't appear to be working.
>
> Let's go back in time and pretend that these patches were never written,
> OK?  We're standing around the water cooler saying "hey, wouldn't it be
> cool if someone did X".  You guys are way too far into this and you keep
on
> leaving everyone else behind.  When I try to drag you up, you resist ;)
>
> So let me rephrase, and thrash around in the dark a little more.
>
> From my reading of the code (and thus far that's my _only_ source of this
> information) it appears that a design decision has been made (for reasons
> which have yet to be disclosed) that the way to implement this (yet to be
> described) requirement is to set user breakpoints upon particular
> instructions within executables.  System-wide, for all processes and
> threads.
>
> There are other things that could have been done.  For example, you might
> have chosen to set breakpoints upon a particular virtual address within a
> heavyweight process.  That's a process-oriented viewpoint, rather than a
> file-oriented one, if you like.
>
> This raises interesting questions, like
>
> - How come that decision was made?  Why _is_ this an executable-oriented
>   rather than process-oriented thing?  Richard has covered that somewhat.
>
> - What happens if the executable is writeably mapped?
>
> - What happens if someone writes to the executable?  (I think both
>   of these were disallowed in the
implementation-which-is-not-to-be-named).
>
> - What happens if different processes map the executable at different
>   addresses?
>
> - Various other things which you've thought of and I haven't and which it
>   would be REALLY interesting to hear about.
>
> But this is just one example.  I don't think I'm being too picky here -
my
> reaction on seeing all this stuff was, basically, "wtf is all this code
> for?".  References to dprobes won't help, sorry - I've never looked at
> dprobes and I don't know anyone apart from you guys who has.
>
> What I'm asking you for is a description of what problem we're trying to
> solve and how this code solves that problem.  It is hard, it is
inefficient
> and, worse, it is error-prone for us to try to work all that out from a
> particular implementation.

This is completely reasonable. And we don't need to refer to dprobes - that
was merely an evolutionary step.
I do have a notes that captured most the early design discussions and
decisions, which Prasanna and I should dive into to help answer some of the
points you raise.
Let me suggest, we chat among ourselves and pull together the relevant
details to answer each of your questions.

Richard


