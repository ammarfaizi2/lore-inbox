Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288284AbSAHUWZ>; Tue, 8 Jan 2002 15:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288285AbSAHUWP>; Tue, 8 Jan 2002 15:22:15 -0500
Received: from holomorphy.com ([216.36.33.161]:6105 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S288284AbSAHUWG>;
	Tue, 8 Jan 2002 15:22:06 -0500
Date: Tue, 8 Jan 2002 12:19:53 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org, riel@surriel.com, mjc@kernel.org,
        bcrl@redhat.com, akpm@zip.com.au, phillips@bonn-fries.net
Subject: Re: hashed waitqueues
Message-ID: <20020108121953.L10391@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
	riel@surriel.com, mjc@kernel.org, bcrl@redhat.com, akpm@zip.com.au,
	phillips@bonn-fries.net
In-Reply-To: <20020108102037.J10391@holomorphy.com> <Pine.LNX.4.21.0201081906400.1683-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.21.0201081906400.1683-100000@localhost.localdomain>; from hugh@veritas.com on Tue, Jan 08, 2002 at 07:20:27PM +0000
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2002, William Lee Irwin III wrote:
>> I need to start benching this stuff.

On Tue, Jan 08, 2002 at 07:20:27PM +0000, Hugh Dickins wrote:
> Why is all this sophistication needed for hashing pages to wait queues?
> I understand that you should avoid a stupid hash (such as one where all
> pages end up on the same wait queue), and I understand why a cache needs
> a well-chosen hash, and I understand why shift is preferred to multiply;
> but I don't get why so much discussion of the precise hash for choosing
> the wait queue of a page: aren't the waits rare, and the pages mostly
> well-distributed anyway?

All this "sophistication" boils down to a single number, perhaps a single
#define. I'd at least like to put some thought into it, at the very least
as due diligence. And also I want to be able to answer the question of
"Where did the number come from?"

It doesn't really require that much effort, either. The non-bitsparse
golden ratio prime was just looked up in Chuck Lever's paper, and the
criteria I'm using to determine potentially useful bitsparse factors
(aside from sparsity itself) are largely from Knuth, who (paraphrasing)
says the important characteristic is the first several terms in the
continued fraction expansion of p/w, where w is the wordsize.

And the sieving "algorithm" is just me asking a couple of people how
they'd do it, and the sieve took well under a minute to run, and maybe
5 or 10 minutes to write.

And if it doesn't matter to you, please remember anyway that when I
wrote my hash functions I did put some thought into it.


Thanks,
Bill
