Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbTFYBMe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 21:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbTFYBKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 21:10:54 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:54184 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S263462AbTFYBKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 21:10:41 -0400
From: Daniel Phillips <phillips@arcor.de>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [RFC] My research agenda for 2.7
Date: Wed, 25 Jun 2003 03:25:47 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <200306250111.01498.phillips@arcor.de> <200306250307.18291.phillips@arcor.de> <20030625011031.GP26348@holomorphy.com>
In-Reply-To: <20030625011031.GP26348@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306250325.47529.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 June 2003 03:10, William Lee Irwin III wrote:
> On Wednesday 25 June 2003 02:47, William Lee Irwin III wrote:
> >> Per struct address_space? This is an unnecessary limitation.
>
> On Wed, Jun 25, 2003 at 03:07:18AM +0200, Daniel Phillips wrote:
> > It's a sensible limitation, it keeps the radix tree lookup simple.
>
> It severely limits its usefulness. Dropping in a more flexible data
> structure should be fine.

Eventually it could well make sense to do that, e.g., the radix tree 
eventually ought to evolve into a btree of extents (probably).  But making 
things so complex in the first version, thus losing much of the incremental 
development advantage, would not be smart.  With a single size of page per 
address_space,  changes to the radix tree code are limited to a couple of 
lines, for example.

But perhaps you'd like to supply some examples where more than one size of 
page in the same address space really matters?

> On Wednesday 25 June 2003 02:47, William Lee Irwin III wrote:
> >> This gives me the same data structure proliferation chills as bh's.
>
> On Wed, Jun 25, 2003 at 03:07:18AM +0200, Daniel Phillips wrote:
> > It's not nearly as bad.  There is no distinction between subpage and base
> > struct page for almost all page operations, e.g., locking, IO, data
> > access.
>
> But those are code sanitation issues. You need to make sure this
> doesn't explode on PAE.

Indeed, that is important.  Good night, see you tomorrow.

Daniel

