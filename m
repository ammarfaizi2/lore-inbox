Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262630AbVA0PMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262630AbVA0PMc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 10:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262639AbVA0PMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 10:12:32 -0500
Received: from holomorphy.com ([66.93.40.71]:61314 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262630AbVA0PMY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 10:12:24 -0500
Date: Thu, 27 Jan 2005 07:12:11 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, Rik van Riel <riel@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       James Antill <james.antill@redhat.com>,
       Bryn Reeves <breeves@redhat.com>
Subject: Re: don't let mmap allocate down to zero
Message-ID: <20050127151211.GB10843@holomorphy.com>
References: <Pine.LNX.4.61.0501261116140.5677@chimarrao.boston.redhat.com> <20050126172538.GN10843@holomorphy.com> <20050127050927.GR10843@holomorphy.com> <16888.46184.52179.812873@alkaid.it.uu.se> <20050127125254.GZ10843@holomorphy.com> <20050127142500.A775@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127142500.A775@flint.arm.linux.org.uk>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 04:52:54AM -0800, William Lee Irwin III wrote:
>> FIRST_USER_PGD_NR is a matter of killing the entire box dead where it
>> exists, not any kind of process' preference. Userspace should be
>> prevented from setting up vmas below FIRST_USER_PGD_NR.

On Thu, Jan 27, 2005 at 02:25:00PM +0000, Russell King wrote:
> No it should not.  The PGD index is FAR to coarse to use - each PGD on
> ARM maps 1MB of virtual address space.  Userspace text starts at 32K.
> The protection against mmap() MAP_FIXED fiddling with the first page is
> handled by the arch-specific mmap() wrappers, so generic code doesn't
> have to worry about it.
> What generic code _does_ have to worry about is:
> 
> (a) not removing the very first page.
> (b) not removing the very first pointer to the 2nd level table in the
>     1st level tables.
> and that is all.  Maybe FIRST_USER_PGD_NR was a bad way of achieving
> this, but in the instance of the VM upon which it was originally
> implemented (somewhere between 2.2 and 2.4), it was deemed (by others
> iirc) to be the best way of achieving it at the time.

The only claim above is the effect of clobbering virtual page 0 and
referring to this phenomenon by the macro. I was rather careful not to
claim a specific lower boundary to the address space.


-- wli
