Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312588AbSDSOZy>; Fri, 19 Apr 2002 10:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312601AbSDSOZy>; Fri, 19 Apr 2002 10:25:54 -0400
Received: from waste.org ([209.173.204.2]:53948 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S312588AbSDSOZw>;
	Fri, 19 Apr 2002 10:25:52 -0400
Date: Fri, 19 Apr 2002 09:25:08 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: William Lee Irwin III <wli@holomorphy.com>, Keith Owens <kaos@ocs.com.au>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] 2.5.8 sort kernel tables
In-Reply-To: <20020419144613.C13926@kushida.apsleyroad.org>
Message-ID: <Pine.LNX.4.44.0204190851490.8537-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Apr 2002, Jamie Lokier wrote:

> Oliver Xymoron wrote:
> > Though we should probably just stick a simple qsort in the library
> > somewhere.
>
> Since we're comparing sort algorithms, I am quite fond of Heapsort.
> Simple, no recursion or stack, and worst case O(n log n).  It's not
> especially fast, but the worst case behaviour is nice:
>
> /* This function is a classic in-place heapsort.  It sorts the array
>    `nums' of integers, which has `count' elements. */

Make this generic by passing in compare and swap functions and stick it in
lib. Heapsort is indeed a better candidate for a kernel algorithm than the
simpler qsorts because of the constrained worst case. If I remember
correctly, heapsort performs about as well as combsort in my testing -
within a constant factor of two of qsort's best case.

> void my_heapsort (int count, int * nums)
> {
> 	int i;
> 	for (i = 1; i < count; i++) {
> 		int j = i, tmp = nums [j];
> 		while (j > 0 && tmp > nums [(j-1)/2]) {
> 			nums [j] = nums [(j-1)/2];
> 			j = (j-1)/2;
> 		}
> 		nums [j] = tmp;
> 	}
> 	for (i = count - 1; i > 0; i--) {
> 		int j = 0, k = 1, tmp = nums [i];
> 		nums [i] = nums [0];
> 		while (k < i && (tmp < nums [k]
> 				 || (k+1 < i && tmp < nums [k+1]))) {
> 			k += (k+1 < i && nums [k+1] > nums [k]);
> 			nums [j] = nums [k];
> 			j = k;
> 			k = 2*j+1;
> 		}
> 		nums [j] = tmp;
> 	}
> }
>
> cheers,
> -- Jamie
>

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

