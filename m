Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262672AbTJPN0s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 09:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262913AbTJPN0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 09:26:48 -0400
Received: from intra.cyclades.com ([64.186.161.6]:51153 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262672AbTJPN0q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 09:26:46 -0400
Date: Thu, 16 Oct 2003 10:29:16 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Andrea Arcangeli <andrea@suse.de>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, <riel@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-pre VM regression?
In-Reply-To: <20031016132412.GB1348@velociraptor.random>
Message-ID: <Pine.LNX.4.44.0310161028080.2388-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Oct 2003, Andrea Arcangeli wrote:

> On Thu, Oct 16, 2003 at 09:52:30AM -0200, Marcelo Tosatti wrote:
> > 
> > Andrea, 
> > 
> > Martin first reported problems with "gzip -dc file | less" (280MB file).
> > less was getting killed. He had no swap... I asked him to add some swap
> > and it works now. Fine. 
> > 
> > The thing is that with 2.4.22 less was being killed, but with 2.4.23-pre
> > he gets:
> 
> note, that's a true oom, less needs to allocate 280MB and it doesn't fit
> in ram. there's no bug as far as I can tell.
>
> a `vmstat 1` could confirm that.
> 
> > >> And yes, the app was killed:
> > > >
> > > > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> > > > VM: killing process named
> > > > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> > > > VM: killing process gpm
> > > > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> > > > VM: killing process sendmail
> > > > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> > > > VM: killing process less
> 
> here the vm keeps killing until 'less' - the real offender - is nuked.
> 
> > So a lot of processes which should not get killed are dying. This is
> > really bad. I was afraid it could happen and it did.
> > 
> > What now? Resurrect OOM-killer? 
> 
> the oom killer has the problem I outlined some email ago, with shared
> memory it gets fooled badly etc.., though in a desktop with all tiny
> tasks except the memory-hog (`less` in this case) it works well.

Andrea,

There is no memory. Right. Some task has to be killed. But not small
programs like sendmail/named/etc. What should be killed is "less". That is
clear, right?



