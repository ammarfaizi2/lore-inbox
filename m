Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312480AbSDSNsr>; Fri, 19 Apr 2002 09:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312444AbSDSNrv>; Fri, 19 Apr 2002 09:47:51 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:2519 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S312447AbSDSNre>; Fri, 19 Apr 2002 09:47:34 -0400
Date: Fri, 19 Apr 2002 14:46:13 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] 2.5.8 sort kernel tables
Message-ID: <20020419144613.C13926@kushida.apsleyroad.org>
In-Reply-To: <20020418135931.GU21206@holomorphy.com> <Pine.LNX.4.44.0204181507150.8537-100000@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:
> Though we should probably just stick a simple qsort in the library
> somewhere.

Since we're comparing sort algorithms, I am quite fond of Heapsort.
Simple, no recursion or stack, and worst case O(n log n).  It's not
especially fast, but the worst case behaviour is nice:

/* This function is a classic in-place heapsort.  It sorts the array
   `nums' of integers, which has `count' elements. */

void my_heapsort (int count, int * nums)
{
	int i;
	for (i = 1; i < count; i++) {
		int j = i, tmp = nums [j];
		while (j > 0 && tmp > nums [(j-1)/2]) {
			nums [j] = nums [(j-1)/2];
			j = (j-1)/2;
		}
		nums [j] = tmp;
	}
	for (i = count - 1; i > 0; i--) {
		int j = 0, k = 1, tmp = nums [i];
		nums [i] = nums [0];
		while (k < i && (tmp < nums [k]
				 || (k+1 < i && tmp < nums [k+1]))) {
			k += (k+1 < i && nums [k+1] > nums [k]);
			nums [j] = nums [k];
			j = k;
			k = 2*j+1;
		}
		nums [j] = tmp;
	}
}

cheers,
-- Jamie
