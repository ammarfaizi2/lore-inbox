Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751663AbWFCOP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbWFCOP7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 10:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751672AbWFCOP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 10:15:59 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43277 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751636AbWFCOP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 10:15:58 -0400
Date: Sat, 3 Jun 2006 15:15:48 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2GB MMC/SD cards
Message-ID: <20060603141548.GA31182@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	linux-kernel@vger.kernel.org
References: <447AFE7A.3070401@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447AFE7A.3070401@drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2006 at 04:00:26PM +0200, Pierre Ossman wrote:
> I do, however, have the following in both the SD and MMC card specs I
> have (both sandisk though):
> 
> WRITE_BL_PARTIAL ? defines whether partial block sizes can be used
>                    in block write commands.
> 
> Table 3-25
>   WRITE_BL_PARTIAL                                  Definition
>             0       Only the WRITE_BL_LEN block size, and its partial
>                     derivatives in
>                     resolution of units of 512 blocks, can be used for
>                     block oriented data
>                     write.
>             1       Smaller blocks can be used as well. The minimum
>                     block size is one
>                     byte.
> 
> So perhaps we should remove all the funky logic that's in mmc_block.c
> right now and just always select a block size of 512 bytes?

The specs I have say the following about WRITE_BL_PARTIAL:

Samsung (csd v1.2 mmc v4.1):
0: means that only the WRITE_BL_LEN block size can be used for block oriented data write.
1: means that smaller blocks can be used as well. The minimum block size is one byte.

Sandisk (csd v1.1 mmc v1.4):
0: means that only the WRITE_BL_LEN block size can be used for block oriented data write.
1: means that smaller blocks can be used as well. The minimum block size is one byte.

The wording is identical from these two differing manufacturers, so I
suspect it comes from the original spec.

> People have been reporting that their Palms, cameras and USB readers
> will not accept anything else.

I am not aware of any bug reports in this area, so I can't comment.  In
fact, I see very few reports of MMC problems at all, so I just assume
that it merely works.  Unless folk report bugs to me...

I don't know what to do about this since I don't have any cards and
I've not seen any bug reports to investigate what's going on.  So I'm
just going to say "the code as it stands is correct as to my best
knowledge, please provide details of it's failings."

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
