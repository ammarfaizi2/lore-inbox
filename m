Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262851AbTJ3Vgg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 16:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262848AbTJ3Vgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 16:36:36 -0500
Received: from fmr09.intel.com ([192.52.57.35]:16861 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S262836AbTJ3Vgb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 16:36:31 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH 2.4.23-pre8]  Remove broken prefetching in free_one_pgd()
Date: Thu, 30 Oct 2003 13:36:23 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F0F3718@scsmsx401.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.4.23-pre8]  Remove broken prefetching in free_one_pgd()
Thread-Index: AcOfKH1d87XM/teDSmW2eaQ7SXT5ywABI1SQ
From: "Luck, Tony" <tony.luck@intel.com>
To: "Bjorn Helgaas" <bjorn.helgaas@hp.com>, <davidm@hpl.hp.com>,
       "David Mosberger" <davidm@napali.hpl.hp.com>
Cc: <davidm@hpl.hp.com>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <marcelo@conectiva.com.br>
X-OriginalArrivalTime: 30 Oct 2003 21:36:24.0945 (UTC) FILETIME=[DE5C6E10:01C39F2D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Friday 24 October 2003 4:21 pm, David Mosberger wrote:
> > >>>>> On Fri, 24 Oct 2003 15:16:59 -0700, "Luck, Tony" 
> <tony.luck@intel.com> said:
> >   >> Different arches behave differently, though.  In the 
> case of ia64,
> >   >> it'a always safe to prefetch (even with lfetch.fault).
> > 
> >   Tony> Not quite always ... this was how I found the efi 
> trim.bottom
> >   Tony> bug, since Linux had allocated a pgd at 
> 0xa00000-16k, and the
> >   Tony> lfetch that reached out beyond the end of the page to the
> >   Tony> uncacheable address 0xa00000 took an MCA.
> > 
> > But don't confuse cause and effect!  The MCA was caused by a bad TLB
> > entry.  The lfetch only triggered the latent bug (as might have a
> > instruction-prefetch).
> 
> I'm assuming that the EFI memory map trim fixes prevent the bad
> TLB entry, and hence, the prefetching patch is not required by ia64
> in 2.4.  Tony, let me know if otherwise.

If EFI trim is doing its job (and the current version now seems
to be handling all cases correctly), then you should no longer
be able to have a TLB entry erroneously marking an uncacheable
area of memory for cacheable access ... so you can keep the prefetch
for ia64 (David pointed out that dropping this prefetch has a
severe negative impact on lmbench fork+execve test).

-Tony
