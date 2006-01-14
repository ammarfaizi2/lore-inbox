Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWANSfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWANSfX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 13:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWANSfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 13:35:23 -0500
Received: from ms-smtp-03-smtplb.tampabay.rr.com ([65.32.5.133]:3218 "EHLO
	ms-smtp-03.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1750757AbWANSfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 13:35:23 -0500
Message-ID: <43C94464.4040500@cfl.rr.com>
Date: Sat, 14 Jan 2006 13:35:16 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051010)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Osterlund <petero2@telia.com>
CC: linux kernel <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: [PATCH] pktcdvd & udf bugfixes
References: <43C5D71B.1060002@cfl.rr.com> <m3oe2e2983.fsf@telia.com>
In-Reply-To: <m3oe2e2983.fsf@telia.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund wrote:
> 
> 
> The variable is unsigned, so it supports values up to 255, ie no need
> to change it.
> 
> 

The packet length is read and left shifted by two before being stored in 
that variable to convert it from 2048 byte sectors to 512 byte sectors, 
thus a value of 128 overflowed and became zero.  be32_to_cpu returns a 
32 bit value so I figured it should be stored in a 32 bit variable, not 
an 8 bit one.

> 
> That code is very old, I think Jens wrote it. I assume it wasn't just
> for fun, but to be able to support drives with slightly
> broken/non-standard firmware.
> 
> 

Yes, I hope he can let me know if that is the case, but right now I do 
not see how that can be.  As far as I know, that value is put there by 
the utility used to format the track, and _should_ be the correct 
length, never 0.  In any case, if it is zero, then assuming the maximum 
supported size would cause errors if the actual packet size is larger 
than the maximum that the driver supports.

> 
> The current limit is 32 disc blocks, ie 64KB or 128 "linux sectors".
> 
> How do you make the packet size larger for a CDRW disc? Just changing
> the constant is not going to help unless you can also format a disc
> with larger packets.
> 
> 

I also have several patches to the udftools package, one of which 
documents ( in the man page ) the previously undocumented -z packet_size 
parameter to cdrwtool, and fixes the code so that it actually works with 
values other than 32.

The upstream project for udftools on sourceforge appears to be dead.  I 
have sent email to the two original authors and had no reply, and the 
CVS repository has not been touched in over a year, and the mailing list 
is dead.  I am not sure what I should do about that, but in the mean 
time, I am maintaining ubuntu specific patches and have been speaking to 
the debian package maintainer about merging them there as well.


> Might be a good idea. On DVD discs the block size is only 32KB, so
> half of the allocated memory is unused.
> 

Why is it only 32 KB on a dvd?  What utility was used to format it like 
that?  My cd/dvd-rw drive blew out the cd laser the other day, and I got 
the replacement last night with some dvd+rw media, so I guess I will 
start playing with that soon.  From what I have read so far, dvd+rw 
media does not require pktcdvd to write to it, but its use can improve 
throughput.

