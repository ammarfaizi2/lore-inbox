Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264932AbSJVTZc>; Tue, 22 Oct 2002 15:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264940AbSJVTZc>; Tue, 22 Oct 2002 15:25:32 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:4556 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264932AbSJVTZS>;
	Tue, 22 Oct 2002 15:25:18 -0400
To: Ulrich Drepper <drepper@redhat.com>
cc: Dave McCracken <dmccr@us.ibm.com>, Rik van Riel <riel@conectiva.com.br>,
       Andrew Morton <akpm@digeo.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH 2.5.43-mm2] New shared page table patch 
In-reply-to: Your message of Tue, 22 Oct 2002 12:11:34 PDT.
             <3DB5A2E6.6000305@redhat.com> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8499.1035314994.1@us.ibm.com>
Date: Tue, 22 Oct 2002 12:29:54 -0700
Message-Id: <E1844iw-0002D9-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3DB5A2E6.6000305@redhat.com>, > : Ulrich Drepper writes:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Dave McCracken wrote:
> 
> >   3) The current large page implementation is only for applications
> >      that want anonymous *non-pageable* shared memory.  Shared page
> >      tables reduce resource usage for any shared area that's mapped
> >      at a common address and is large enough to span entire pte pages.
> 
> 
> Does this happen automatically (i.e., without modifying th emmap call)?
> 
> In any case, a system using prelinking will likely have all users of a
> DSO mapping the DSO at the same address.  Will a system benefit in this
> case?  If not directly, perhaps with some help from ld.so since we do
> know when we expect the same is used everywhere.

One important thing to watch out for is to make sure that the PLT
and GOT fixups (where typically pages are mprotected to RW, modified,
then back to RO) are not in the range of pages that are shared.
And, it helps if everything that is shared read-only is 4 MB aligned.
If ld.so could do that under linux, we'd have the biggest win.

gerrit
