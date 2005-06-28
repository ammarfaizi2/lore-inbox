Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262122AbVF1VfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbVF1VfY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 17:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbVF1VfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 17:35:23 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:60635 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261505AbVF1Vdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 17:33:36 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: [patch 2] mm: speculative get_page
Date: Tue, 28 Jun 2005 14:32:30 -0700
User-Agent: KMail/1.8
Cc: nickpiggin@yahoo.com.au, wli@holomorphy.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
References: <42C0AAF8.5090700@yahoo.com.au> <42C0D717.2080100@yahoo.com.au> <20050627.220827.21920197.davem@davemloft.net>
In-Reply-To: <20050627.220827.21920197.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506281432.30868.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, June 27, 2005 10:08 pm, David S. Miller wrote:
> From: Nick Piggin <nickpiggin@yahoo.com.au>
> Subject: Re: [patch 2] mm: speculative get_page
> Date: Tue, 28 Jun 2005 14:50:31 +1000
>
> > William Lee Irwin III wrote:
> > >On Tue, Jun 28, 2005 at 11:42:16AM +1000, Nick Piggin wrote:
> > >
> > >spin_unlock() does not imply a memory barrier.
> >
> > Intriguing...
>
> BTW, I disagree with this assertion.  spin_unlock() does imply a
> memory barrier.
>
> All memory operations before the release of the lock must execute
> before the lock release memory operation is globally visible.

On ia64 at least, the unlock is only a one way barrier.  The store to 
realease the lock uses release semantics (since the lock is declared 
volatile), which implies that prior stores are visible before the 
unlock occurs, but subsequent accesses can 'float up' above the unlock.  
See http://www.gelato.unsw.edu.au/linux-ia64/0304/5122.html for some 
more details.

Jesse
