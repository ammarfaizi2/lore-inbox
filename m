Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288277AbSAHTtm>; Tue, 8 Jan 2002 14:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288276AbSAHTtX>; Tue, 8 Jan 2002 14:49:23 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:35275 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S288274AbSAHTtK>; Tue, 8 Jan 2002 14:49:10 -0500
Date: Tue, 8 Jan 2002 19:20:27 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel@vger.kernel.org, riel@surriel.com, mjc@kernel.org,
        bcrl@redhat.com, akpm@zip.com.au, phillips@bonn-fries.net
Subject: Re: hashed waitqueues
In-Reply-To: <20020108102037.J10391@holomorphy.com>
Message-ID: <Pine.LNX.4.21.0201081906400.1683-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2002, William Lee Irwin III wrote:
> On January 5, 2002 02:39 am, William Lee Irwin III wrote:
> >>> 2 or 3 shift/adds is really not possible, the population counts of the
> >>> primes in those ranges tends to be high, much to my chagrin.
> 
> On Sat, Jan 05, 2002 at 03:44:06AM +0100, Daniel Phillips wrote:
> >> It doesn't really have to be a prime, being relatively prime is also 
> >> good, i.e., not too many or too small factors.  Surely there's a multiplier 
> >> in the right range with just two prime factors that can be computed with 3 
> >> shift-adds.
> 
> The (theoretically) best 64-bit prime with 5 high bits I found is:
> 
> 11673330234145374209 == 0xa200000000100001
> which has continued fraction of p/2^64
> 	= 0,1,1,1,2,1,1,1,1,1,1,1073740799,2,1,1,1,1,6,1,1,5,1023,1,4,1,1,3,3
> 
> and the (theoretically) best 64-bit prime with 4 high bits I found is:
> 11529215046068994049 == 0xa000000000080001
> which has continued fraction of p/2^64
> 	= 0,1,1,1,2,549754765313,1,1,1,1,1,4095,2,1,1,1,1,2,1,2
> 
> (the continued fractions terminate after the points given here)
> 
> Which of the two would be better should depend on whether the penalty
> against the distribution for the sixth term of the 4-bit prime is worse
> than the computational expense of the extra shift/add for the 5-bit prime.
> 
> I need to start benching this stuff.

Why is all this sophistication needed for hashing pages to wait queues?
I understand that you should avoid a stupid hash (such as one where all
pages end up on the same wait queue), and I understand why a cache needs
a well-chosen hash, and I understand why shift is preferred to multiply;
but I don't get why so much discussion of the precise hash for choosing
the wait queue of a page: aren't the waits rare, and the pages mostly
well-distributed anyway?

Hugh

