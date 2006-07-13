Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbWGMPFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbWGMPFp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 11:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030226AbWGMPFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 11:05:45 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:17357 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030224AbWGMPFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 11:05:44 -0400
Subject: Re: [PATCH] Use uname not sysctl to get the kernel revision
From: Arjan van de Ven <arjan@infradead.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Ulrich Drepper <drepper@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Jakub Jelinek <jakub@redhat.com>, Roland McGrath <roland@redhat.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
In-Reply-To: <m1hd1l4lif.fsf@ebiederm.dsl.xmission.com>
References: <20060712184412.2BD57180061@magilla.sf.frob.com>
	 <44B54EA4.5060506@redhat.com> <20060712195349.GW3823@sunsite.mff.cuni.cz>
	 <44B556E5.5000702@zytor.com> <m1k66i8ql5.fsf@ebiederm.dsl.xmission.com>
	 <44B5D77F.60200@redhat.com>  <m1hd1l4lif.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 17:05:18 +0200
Message-Id: <1152803119.3024.60.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-13 at 08:39 -0600, Eric W. Biederman wrote:
> Ulrich Drepper <drepper@redhat.com> writes:
> 
> > Eric W. Biederman wrote:
> >> Ulrich what would be interesting besides the possibility of having
> >> multiple cpus?
> >
> > What is needed for various things like memory handling etc is all
> > topology information.  Somebody might remember the numa library proposal
> > I had in April 2004 which was cast aside because people were only
> > looking for a "quick fix".  Well, the problem still isn't solved.
> >
> > IMO the vdso should export information about:
> >
> > - processors and their relationship (hyperthreads, cores)
> >
> > - the CPU caches and how they relate to the cores (e.g., dual core
> >   with shared L2)
> >
> > - local main memory for each processor
> >
> > - relative costs of the memory access of the various memory regions
> >   (for numa local memory to a node, intra-node costs)
> >
> > - ideally, relative costs main memory and CPU caches
> >
> >
> > All this information can be steadily updated by the kernel as new
> > CPUs/memory get added/removed.  The vdso should have functions to access
> > this information.  It's easy enough to make this access race free.
> >

why does this have to be in the vdso? It's not like the code can be a
regular userspace lib/daemon that gets all the hotplug events and that
processes the info from /proc and /sys once during boot. A bit like how
nscd works I suppose..


