Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132700AbRAXPj6>; Wed, 24 Jan 2001 10:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132701AbRAXPjt>; Wed, 24 Jan 2001 10:39:49 -0500
Received: from duck.doc.ic.ac.uk ([146.169.1.46]:56591 "EHLO duck.doc.ic.ac.uk")
	by vger.kernel.org with ESMTP id <S132700AbRAXPjc>;
	Wed, 24 Jan 2001 10:39:32 -0500
To: Timur Tabi <ttabi@interactivesi.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: ioremap_nocache problem?
In-Reply-To: <Pine.GSO.4.10.10101231903380.14027-100000@zeus.fh-brandenburg.de>
	<E14LRce-0008FU-00@diver.doc.ic.ac.uk>
From: David Wragg <dpw@doc.ic.ac.uk>
Date: 24 Jan 2001 15:39:10 +0000
In-Reply-To: Timur Tabi's message of "Wed, 24 Jan 2001 09:14:02 -0600"
Message-ID: <y7rk87lnen5.fsf@sytry.doc.ic.ac.uk>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timur Tabi <ttabi@interactivesi.com> writes:
> ** Reply to message from David Wragg <dpw@doc.ic.ac.uk> on 24 Jan 2001
> 00:50:20 +0000
> > (x86 processors with PAT and IA64 can set write-combining through
> >page flags.  x86 processors with MTRRs but not PAT would need a more
> >elaborate implementation for write-combining.)
> 
> What is PAT?  I desperately need to figure out how to turn on write
> combining on a per-page level.  I thought I had to use MTRRs, but now
> you're saying I can use this "PAT" thing instead.  Please explain!

PAT is basically the MTRR memory types on a per-page basis.  It adds a
new flag bit to the x86 page table entry, then that bit together with
the PCD and PWT bits is used to do a look-up in an 8-entry table that
gives the effective memory type (the table is set through an MSR).
All the details are in the Intel x86 manual, volume 3
<URL:http://developer.intel.com/design/pentium4/manuals/> (at the end
of chapter 9).

Quite a lot of the x86 CPUs out there support PAT: The PII except the
first couple of models, the Celeron except the first model, the PIII,
all PII and PIII Xeons, the P4, all AMD K7 models.  I'm guessing, but
I suspect that the majority of x86 CPUs supporting write combining in
any form that have been made also support PAT.

I wish Intel had put PAT in the PPro, rather than messing everyone
around with MTRRs (MTRRs are good for BIOS writers, but a pain for
everyone else).


David Wragg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
