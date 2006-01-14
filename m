Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbWANVpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWANVpI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 16:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWANVpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 16:45:08 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:16058 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1751325AbWANVpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 16:45:06 -0500
To: Phillip Susi <psusi@cfl.rr.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: [PATCH] pktcdvd & udf bugfixes
References: <43C5D71B.1060002@cfl.rr.com> <m3oe2e2983.fsf@telia.com>
	<43C94464.4040500@cfl.rr.com>
From: Peter Osterlund <petero2@telia.com>
Date: 14 Jan 2006 22:45:00 +0100
In-Reply-To: <43C94464.4040500@cfl.rr.com>
Message-ID: <m3hd861o2r.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi <psusi@cfl.rr.com> writes:

> Peter Osterlund wrote:
> > The variable is unsigned, so it supports values up to 255, ie no need
> > to change it.
> 
> The packet length is read and left shifted by two before being stored
> in that variable to convert it from 2048 byte sectors to 512 byte
> sectors, thus a value of 128 overflowed and became zero.  be32_to_cpu
> returns a 32 bit value so I figured it should be stored in a 32 bit
> variable, not an 8 bit one.

OK, it makes sense if you can make packets larger than 64KB. I didn't
know you could.

> > The current limit is 32 disc blocks, ie 64KB or 128 "linux sectors".
> > How do you make the packet size larger for a CDRW disc? Just changing
> > the constant is not going to help unless you can also format a disc
> > with larger packets.
> 
> I also have several patches to the udftools package, one of which
> documents ( in the man page ) the previously undocumented -z
> packet_size parameter to cdrwtool, and fixes the code so that it
> actually works with values other than 32.

OK, so it appears you can make packets bigger than 64KB. Can I please
have those patches so I can test this myself.

> The upstream project for udftools on sourceforge appears to be dead.
> I have sent email to the two original authors and had no reply, and
> the CVS repository has not been touched in over a year, and the
> mailing list is dead.  I am not sure what I should do about that, but
> in the mean time, I am maintaining ubuntu specific patches and have
> been speaking to the debian package maintainer about merging them
> there as well.

I'm not sure either what to do if the project admin (Ben Fennema) is
no longer online so he can transfer maintenance to someone else.

> > Might be a good idea. On DVD discs the block size is only 32KB, so
> > half of the allocated memory is unused.
> 
> Why is it only 32 KB on a dvd?  What utility was used to format it
> like that? 

According to

        http://fy.chalmers.se/~appro/linux/DVD+RW/

"... native DVD ECC blocksize, which is 32KB"

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
