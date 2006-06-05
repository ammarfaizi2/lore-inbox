Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750744AbWFEWwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWFEWwj (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 18:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWFEWwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 18:52:39 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:48779 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1750744AbWFEWwi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 18:52:38 -0400
Message-ID: <4484B5AE.8060404@drzeus.cx>
Date: Tue, 06 Jun 2006 00:52:30 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
CC: Matt Reimer <mattjreimer@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2GB MMC/SD cards
References: <447AFE7A.3070401@drzeus.cx>	 <20060603141548.GA31182@flint.arm.linux.org.uk> <f383264b0606031140l2051a2d7p6a9b2890a6063aef@mail.gmail.com> <4481FB80.40709@drzeus.cx>
In-Reply-To: <4481FB80.40709@drzeus.cx>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:;;@mail-zipworld.pacific.net.au (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman wrote:
> Matt Reimer wrote:
>> I suspect that a lot of these readers are broken, assuming 512 byte
>> blocks.
>>
> 
> That's what I thought until I looked closer at the Sandisk specs. Until
> we can see what the official specs say, we won't really know what the
> correct behaviour is. The Nokia boys working on the 770 have a copy.
> Perhaps someone here knows how to get in touch with one of them that can
> have a look?
> 

With the help of Khasim Syed, who happens to have access to the MMC
spec, we now know what's in the spec. Unfortunately, what's in there is
the same text that's in Russell's card specs, which state that only
WRITE_BL_LEN is supported.

However! In the simplified SD physical spec (which you can find on the
SDA home page), we can find:

4.3.2 2GByte Card
To make 2GByte card, the Maximum Block Length (READ_BL_LEN=WRITE_BL_LEN)
shall be set to
1024 bytes. But Block Length set by CMD16 shall be up to 512 bytes to
keep consistency with 512
bytes Maximum Block Length cards (Less than and equal 2GByte cards).

It even has an example with WRITE_BL_PARTIAL=0, still setting block
length to 512. Now I know this is SD and not MMC, but the debug dump
from Serge earlier seems to suggest that MMC cards follow the same rule.

Even though this breaks the MMC spec, my vote is for 512 bytes at all
times. If the entire industry decided to violate the spec, I don't see
much gain in being stubborn here.

Rgds
Pierre

