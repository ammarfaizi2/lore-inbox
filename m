Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135696AbRD2LGq>; Sun, 29 Apr 2001 07:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135713AbRD2LGg>; Sun, 29 Apr 2001 07:06:36 -0400
Received: from pizda.ninka.net ([216.101.162.242]:26251 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135696AbRD2LGX>;
	Sun, 29 Apr 2001 07:06:23 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15083.62888.860815.889046@pizda.ninka.net>
Date: Sun, 29 Apr 2001 04:06:16 -0700 (PDT)
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Zerocopy implementation issues
In-Reply-To: <20010429113122.E30243@flint.arm.linux.org.uk>
In-Reply-To: <20010429005206.J21792@flint.arm.linux.org.uk>
	<15083.40318.158099.137018@pizda.ninka.net>
	<20010429072342.B30041@flint.arm.linux.org.uk>
	<15083.52835.992666.897323@pizda.ninka.net>
	<20010429101739.D30243@flint.arm.linux.org.uk>
	<20010429113122.E30243@flint.arm.linux.org.uk>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Russell King writes:
 > Or am I missing something?

csum_block_*() has nothing to do with checksumming buffers, it 2's
complement adds two integers passed as arguments based upon the offset
of one of the buffers (this decides if one of the csums needs to be
byte swapped before the 2's complement addition to get a correct
result).

That was the point of my mail, the last_byte_was_odd code
had nothing to do with what your checksum code needs to be
doing, never did and never will.  Your premise was that the
last_byte_was_odd code "proved" that the csum_partial_copy
destination buffer could not be byte aligned, and I tried
to show that the last_byte_was_odd code had nothing to do
with whether that was allowed or not.

Your csum_partial_copy*() code needs to handle unaligned
destination buffers, period.

I understand that you are frustruated about this and it
requires you to touch some delicate assembly.  But I'm
going to be blunt and say "tough", because everyone has
to implement this correctly.  Just do it and get it
over with.

Later,
David S. Miller
davem@redhat.com
