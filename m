Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261700AbSJQRVk>; Thu, 17 Oct 2002 13:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261588AbSJQRVk>; Thu, 17 Oct 2002 13:21:40 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:10654 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261700AbSJQRUA>;
	Thu, 17 Oct 2002 13:20:00 -0400
Date: Thu, 17 Oct 2002 18:27:29 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Matthew Wilcox <willy@debian.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add generic prefetch xor routines
Message-ID: <20021017172729.GA29177@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Matthew Wilcox <willy@debian.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20021017180134.X15163@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021017180134.X15163@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 06:01:34PM +0100, Matthew Wilcox wrote:
 > 
 > Both PA-RISC and IA64 benefit from these generic prefetching routines.
 > Maybe other CPUs will too.
 > 
 > +	do {
 > +		prefetchw(p1+8);
 > +		prefetch(p2+8);
 > +		p1[0] ^= p2[0];
 > +		p1[1] ^= p2[1];
 > +		p1[2] ^= p2[2];
 > +		p1[3] ^= p2[3];
 > +		p1[4] ^= p2[4];
 > +		p1[5] ^= p2[5];
 > +		p1[6] ^= p2[6];
 > +		p1[7] ^= p2[7];
 > +		p1 += 8;
 > +		p2 += 8;
 > +	} while (--lines > 0);

Won't this prefetch past the end of the buffer ?
Some CPUs have problems with prefetching non-existant areas
of RAM iirc. (Which is why the memcpy routines do a prefetching
loop, and then a non prefetching loop to copy the tail).

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
