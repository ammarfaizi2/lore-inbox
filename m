Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbUCRMc1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 07:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262582AbUCRMc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 07:32:27 -0500
Received: from mx2.elte.hu ([157.181.151.9]:50871 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262585AbUCRMaE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 07:30:04 -0500
Date: Thu, 18 Mar 2004 13:31:03 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>, Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: sched_setaffinity usability
Message-ID: <20040318123103.GA21893@elte.hu>
References: <40595842.5070708@redhat.com> <20040318112913.GA13981@elte.hu> <20040318120709.A27841@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040318120709.A27841@infradead.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Hellwig <hch@infradead.org> wrote:

> > or, maybe it would be better to introduce some sort of 'system
> > constants' syscall that would be a generic umbrella for such things -
> > and could easily be converted into a vsyscall. Or we could make it part
> > of the .data section of the VDSO - thus no copying overhead, only one
> > symbol lookup.
> 
> Like, umm, the long overdue sysconf()?  For the time beeing a sysctl
> might be the easiest thing..

i think we want to kill several birds with a single stone, and just make
it part of the VDSO - along with the parameters visible via uname(). 
This would cut another extra syscall, and data copying.

i'm wondering how dangerous of an API idea it is to make these
parameters part of the VDSO .data section (and make it/them versioned
DSO symbols).

The only minor complication wrt. uname() would be sethostname: other
CPUs could observe a transitional state of (the VDSO-equavalent of)
system_utsname.nodename. Is this a problem? It's not like systems call
sethostname all that often ...

	Ingo
