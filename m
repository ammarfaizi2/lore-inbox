Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312277AbSCYCps>; Sun, 24 Mar 2002 21:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312278AbSCYCph>; Sun, 24 Mar 2002 21:45:37 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:12675 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S312277AbSCYCp3>; Sun, 24 Mar 2002 21:45:29 -0500
Date: Sun, 24 Mar 2002 19:45:26 -0700
Message-Id: <200203250245.g2P2jQa20821@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: bit ops on unsigned long? 
In-Reply-To: <E16m4YD-0004af-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell writes:
> Richard: 3 bugs in devfs.  Particularly note that the memset was
> bogus.  I can't convince myself that your memcpy & memset stuff is
> right anyway, given that you can ONLY treat them as unsigned longs
> (ie. bit 31 will be in byte 0 or byte 3, depending on endianness).

Yes, the memset is bogus because I didn't cast the pointer to a
char * or void *. The memcpy should be fine, though. And so should
everything else, because the bitfield array is allocated in 16 byte
multiples. So there should be no issues with big vs. little endian,
since memset/memcpy operations are done in blocks of sufficient
alignment.

So, really, the only problem is the stupid lack of a cast. Unless you
noticed some other problem?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
