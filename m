Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030220AbWAXATf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbWAXATf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 19:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbWAXATf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 19:19:35 -0500
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:14846 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S1030220AbWAXATf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 19:19:35 -0500
Date: Mon, 23 Jan 2006 18:19:14 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Ray Bryant <raybry@mpdtxmail.amd.com>
cc: Robin Holt <holt@sgi.com>, Hugh Dickins <hugh@veritas.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH/RFC] Shared page tables
Message-ID: <6BC41571790505903C7D3CD6@[10.1.1.4]>
In-Reply-To: <200601231758.08397.raybry@mpdtxmail.amd.com>
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]>
 <20060117235302.GA22451@lnx-holt.americas.sgi.com>
 <200601231758.08397.raybry@mpdtxmail.amd.com>
X-Mailer: Mulberry/4.0.0b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Monday, January 23, 2006 17:58:08 -0600 Ray Bryant
<raybry@mpdtxmail.amd.com> wrote:

> Like Robin, I would appreciate a test application, or at least a
> description  of how to write one, or some other trick to figure out if
> this is working.

My apologies.  I do have a small test program and intended to clean it up
to send to Robin, but got sidetracked (it's fugly at the moment).  I'll see
about getting it a bit more presentable.

> I scanned through this thread looking for a test application, and didn't
> see  one.   Is it sufficient just to create a large shared read-only
> mmap'd file  and share it across a bunch of process to get this code
> invoked?   How large  of a file is needed (on x86_64), assuming that we
> just turn on the pte level  of sharing?   And what kind of alignment
> constraints do we end up under in  order to make the sharing happen?
> (My guess would be that there aren't any  such constraints (well, page
> alignment.. :-)  if we are just sharing pte's.)

The basic rule for pte sharing is that some portion of a memory region must
span an entire pte page.  For i386 and x96_64 that would be 2 meg.  The
region must either be read-only or marked to be shared if it is writeable.

The code does opportunistically look for any pte page that is fully within
a shareable vma, and will share if it finds one.

Oh, and one more caveat.  The region must be mapped to the same address in
each process.

> I turned on the PT_DEBUG stuff, but thus far have found no evidence of
> pte  sharing actually occurring in a normal system boot.  I'm surprised
> by that as  I (naively?) would have expected shared libraries to use
> shared ptes.

Most system software, including the shared libraries, don't have any
regions that are big enough for sharing (the text section for libc, for
example, is about 1.5 meg).

Dave McCracken

