Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289278AbSBSByZ>; Mon, 18 Feb 2002 20:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289270AbSBSByQ>; Mon, 18 Feb 2002 20:54:16 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:27665 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289273AbSBSByG>;
	Mon, 18 Feb 2002 20:54:06 -0500
Date: Mon, 18 Feb 2002 22:53:45 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>, Hugh Dickins <hugh@veritas.com>,
        <dmccr@us.ibm.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Robert Love <rml@tech9.net>, <mingo@redhat.co>,
        Andrew Morton <akpm@zip.com.au>, <manfred@colorfullife.com>,
        <wli@holomorphy.com>
Subject: Re: [RFC] Page table sharing
In-Reply-To: <Pine.LNX.4.33.0202181746090.24597-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0202182252260.1930-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2002, Linus Torvalds wrote:
> On Mon, 18 Feb 2002, Rik van Riel wrote:
> >
> > We'll need protection from the swapout code.
>
> Absolutely NOT.
>
> If the swapout code unshares or shares the PMD, that's a major bug.
>
> The swapout code doesn't need to know one way or the other, because the
> swapout code never actually touches the pmd itself, it just follows the
> pointers - it doesn't ever need to worry about the pmd counts at all.

The swapout code can remove a page from the page table
while another process is in the process of unsharing
the page table.

We really want to make sure that the copied-over page
table doesn't point to a page which just got swapped
out.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

