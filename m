Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263212AbTFYAwR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 20:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263295AbTFYAwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 20:52:16 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:34191 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S263212AbTFYAwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 20:52:12 -0400
From: Daniel Phillips <phillips@arcor.de>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [RFC] My research agenda for 2.7
Date: Wed, 25 Jun 2003 03:07:18 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <200306250111.01498.phillips@arcor.de> <20030625004758.GO26348@holomorphy.com>
In-Reply-To: <20030625004758.GO26348@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306250307.18291.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 June 2003 02:47, William Lee Irwin III wrote:
> On Wed, Jun 25, 2003 at 01:11:01AM +0200, Daniel Phillips wrote:
> >   - Page size is represented on a per-address space basis with a shift
> > count. In practice, the smallest is 9 (512 byte sector), could imagine 7
> > (each ext2 inode is separate page) or 8 (actual hardsect size on some
> > drives). 12 will be the most common size.  13 gives 8K blocksize for,
> > e.g., alpha. 21 and 22 give 2M and 4M page size, matching hardware
> > capabilities of x86, and other sizes are possible on machines like MIPS,
> > where page size is software controllable
> >   - Implemented only for file-backed memory (page cache)
>
> Per struct address_space? This is an unnecessary limitation.

It's a sensible limitation, it keeps the radix tree lookup simple.

> On Wed, Jun 25, 2003 at 01:11:01AM +0200, Daniel Phillips wrote:
> >   - Special case these ops in page cache access layer instead of having
> > the messy code in the block IO library
> >   - Subpage struct pages are dynamically allocated.  But buffer_heads are
> > gone so this is a lateral change.
>
> This gives me the same data structure proliferation chills as bh's.

It's not nearly as bad.  There is no distinction between subpage and base 
struct page for almost all page operations, e.g., locking, IO, data access.

Regards,

Daniel

