Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289083AbSAGCez>; Sun, 6 Jan 2002 21:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289084AbSAGCep>; Sun, 6 Jan 2002 21:34:45 -0500
Received: from holomorphy.com ([216.36.33.161]:41932 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S289083AbSAGCef>;
	Sun, 6 Jan 2002 21:34:35 -0500
Date: Sun, 6 Jan 2002 18:34:17 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] hashed waitqueues, somewhat cleaner
Message-ID: <20020106183417.L10326@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some new versions of the hashed waitqueues are now available:

ftp://ftp.kernel.org/pub/linux/kernel/people/wli/vm/struct_page/waitq-2.4.17-rmap10c-1

This includes:

(1) Manual common subexpression elimination of page_waitqueue() calls
(2) Use a 64-bit Fibonacci hashing prime conditional on BITS_PER_LONG
(3) Storing wait_table_shift instead of wait_table_bits to reduce
	arithmetic within the hash function
(4) Eliminating the masking operation within the hash function, as
	the shifting already zeroes the high-order bits.
(5) Eliminating explicit references to struct page ->wait outside
	of the VM.

Future directions:
(1) Using a non-linear function to size the waitqueue table given the
	size of a zone, as the demand for waitqueues does not appear to
	scale linearly with the size of memory.
(2) Finding bit-sparse Fibonacci hashing multipliers for machines with
	slow integer multiplies (so it can be optimized to shift/add
	sequences on those machines).

I'll followup shortly after rediffing against 2.4.17-mainline.


Cheers,
Bill
