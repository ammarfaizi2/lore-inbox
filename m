Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVALTM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVALTM6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 14:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVALTJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 14:09:26 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:5320 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261330AbVALTG0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 14:06:26 -0500
Date: Wed, 12 Jan 2005 11:06:00 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andrew Morton <akpm@osdl.org>
cc: nickpiggin@yahoo.com.au, torvalds@osdl.org, ak@muc.de, hugh@veritas.com,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: page table lock patch V15 [0/7]: overview
In-Reply-To: <20050112104326.69b99298.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0501121055490.11169@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
 <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org>
 <Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org>
 <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412011545060.5721@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0501041129030.805@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0501041137410.805@schroedinger.engr.sgi.com> <m1652ddljp.fsf@muc.de>
 <Pine.LNX.4.58.0501110937450.32744@schroedinger.engr.sgi.com>
 <41E4BCBE.2010001@yahoo.com.au> <20050112014235.7095dcf4.akpm@osdl.org>
 <Pine.LNX.4.58.0501120833060.10380@schroedinger.engr.sgi.com>
 <20050112104326.69b99298.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2005, Andrew Morton wrote:

> >  So only a very minor improvements for old machines (this one from ~ 98).
>
> OK.  But have you written a test to demonstrate any performance
> regressions?  From, say, the use of atomic ops on ptes?

If I knew of any regressions, I would certain try to deal with them. The
test is written to check for concurrent page fault performance and it has
repeatedly helped me to find problems with page faults. I have used it for
a couple of other patchsets too. If the patch would be available in mm
then it certainly would get more exposure and it may become clear that
there are some regressions.

Introduction of the cmpxchg is one atomic operations that replaces the two
spinlock ops typically necessary in an unpatched kernel. Obtaining the
spinlock requires an spinlock (which is an atomic operation) and then the
release involves a barrier. So there is a net win for all SMP cases as far
as I can see.
