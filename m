Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289255AbSBSBxp>; Mon, 18 Feb 2002 20:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289273AbSBSBxf>; Mon, 18 Feb 2002 20:53:35 -0500
Received: from dsl-213-023-040-169.arcor-ip.net ([213.23.40.169]:24210 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289255AbSBSBxS>;
	Mon, 18 Feb 2002 20:53:18 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: [RFC] Page table sharing
Date: Tue, 19 Feb 2002 02:57:57 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Hugh Dickins <hugh@veritas.com>, <dmccr@us.ibm.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Robert Love <rml@tech9.net>, <mingo@redhat.co>,
        Andrew Morton <akpm@zip.com.au>, <manfred@colorfullife.com>,
        <wli@holomorphy.com>
In-Reply-To: <Pine.LNX.4.33.0202181746090.24597-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0202181746090.24597-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16czXZ-0000yk-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 19, 2002 02:48 am, Linus Torvalds wrote:
> On Mon, 18 Feb 2002, Rik van Riel wrote:
> >
> > We'll need protection from the swapout code.
> 
> Absolutely NOT.
> 
> If the swapout code unshares or shares the PMD, that's a major bug.

What it will do is change entries on the page table.  We have to be sure
two processes don't read/evict the same page in at the same time.

> The swapout code doesn't need to know one way or the other, because the
> swapout code never actually touches the pmd itself, it just follows the
> pointers - it doesn't ever need to worry about the pmd counts at all.

That was my original, incomplete view of the situation at first as well.

-- 
Daniel
