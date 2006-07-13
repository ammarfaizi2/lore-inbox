Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751552AbWGMOkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbWGMOkp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 10:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbWGMOko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 10:40:44 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:20625 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751555AbWGMOko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 10:40:44 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Ulrich Drepper <drepper@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Jakub Jelinek <jakub@redhat.com>,
       Roland McGrath <roland@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: Re: [PATCH] Use uname not sysctl to get the kernel revision
References: <20060712184412.2BD57180061@magilla.sf.frob.com>
	<44B54EA4.5060506@redhat.com>
	<20060712195349.GW3823@sunsite.mff.cuni.cz>
	<44B556E5.5000702@zytor.com>
	<m1k66i8ql5.fsf@ebiederm.dsl.xmission.com> <44B5D77F.60200@redhat.com>
Date: Thu, 13 Jul 2006 08:39:20 -0600
In-Reply-To: <44B5D77F.60200@redhat.com> (Ulrich Drepper's message of "Wed, 12
	Jul 2006 22:17:51 -0700")
Message-ID: <m1hd1l4lif.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper <drepper@redhat.com> writes:

> Eric W. Biederman wrote:
>> Ulrich what would be interesting besides the possibility of having
>> multiple cpus?
>
> What is needed for various things like memory handling etc is all
> topology information.  Somebody might remember the numa library proposal
> I had in April 2004 which was cast aside because people were only
> looking for a "quick fix".  Well, the problem still isn't solved.
>
> IMO the vdso should export information about:
>
> - processors and their relationship (hyperthreads, cores)
>
> - the CPU caches and how they relate to the cores (e.g., dual core
>   with shared L2)
>
> - local main memory for each processor
>
> - relative costs of the memory access of the various memory regions
>   (for numa local memory to a node, intra-node costs)
>
> - ideally, relative costs main memory and CPU caches
>
>
> All this information can be steadily updated by the kernel as new
> CPUs/memory get added/removed.  The vdso should have functions to access
> this information.  It's easy enough to make this access race free.
>
> I guess I should try to come up with a representation for this
> knowledge.  Collecting the information (except the costs) should be
> easy.  Determining the costs also shouldn't be that hard but it can be
> very useful.  Some of this information could be determined at userlevel
> but you really don't want every process to compute all this from
> scratch.  And stored data in a file is stale if the system changes.

The history of Linux shows that auto-tuning while not always perfect
is much more effective than manual tuning.  How are you envisioning
using this information? 

I find it really easy to see how topology information can be used
to manually tune a system.  I don't currently see how it can be used
to automatically tune a system.

My fear is that we will end up making things brittle with user space
over specifying things.

I have another related concern about what rules need to be in place
so I can upgrade the kernel vdso while a user space program is running.
That make me seriously wonder how sane the vdso concept is, but that
is a completely different issue.


Eric
