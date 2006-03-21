Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbWCUXpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWCUXpR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 18:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWCUXpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 18:45:17 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:11161 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932397AbWCUXpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 18:45:16 -0500
Message-ID: <44209009.1010405@t-online.de>
Date: Wed, 22 Mar 2006 00:45:13 +0100
From: Bernd Schmidt <bernds_cb1@t-online.de>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Luke Yang <luke.adi@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2]Blackfin archtecture patche for 2.6.16
References: <489ecd0c0603200200va747a68k187651930a3f0a51@mail.gmail.com> <20060321031457.69fa0892.akpm@osdl.org>
In-Reply-To: <20060321031457.69fa0892.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: rw4XK4ZQQeig96g2UEPwIDM6mOhQ7JnWwJIN9DS5ZK+uajKpF50CU9
X-TOI-MSGID: 3f2fa773-e0bf-49ec-b32b-28919a3c904f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke is probably still asleep at this time of night, so I'll try to 
answer what I can...

Andrew Morton wrote:
> "Luke Yang" <luke.adi@gmail.com> wrote:
>>    This is the Blackfin archtecture patch for kernel 2.6.16.
> 
> - We don't want to be putting 44000 lines of new code in the kernel and
>   then have it rot.  Who will support this in the long-term?  What
>   resources are behind it?  IOW: what can you say to convince us that it
>   won't rot?

We're a team inside Analog Devices who are maintaining a GNU toolchain, 
uClinux kernel, and user space apps for the Blackfin.  All of this is 
available on our blackfin.uclinux.org site.  We do not expect to go away 
anytime soon.

>   The lack of a MAINTAINERS entry doesn't inspire confidence..

That should probably be fixed.

> - How widespread/popular is the blackfin?  Are many devices using it? 
>   How old/mature is it?  Is it a new thing or is it near end-of-life?

Neither, really.  It's been around for a bit, but the uClinux port is 
only now beginning to really take off, and we certainly hope that more 
and more devices will begin using it.

> - Are easy-to-install x86 cross-build packages available?  If not, are
>   there straightforward instructions anywhere to guide people in generating
>   a cross-build setup?
> 
>   <looks>
> 
>   OK, blackfin.uclinux.org seems to have that.  Does binutils support
>   blackfin?

On blackfin.uclinux.org you'll find our local trees and the RPM releases 
we recommend to users.  The Blackfin port is in gcc and binutils 
mainline; we hope to be able to get into the kernel mainline as well. 
If you have additional questions about the chip, please ask.

> - A lot of this code appears to come from Analog Devices, but you don't ;)

We do, actually.  We just don't like Outlook.

>   We'd need to see some sort of authorisation from the original authors
>   for the inclusion of their code.  Preferably in the form of
>   Signed-off-by:s.  

I'll pass that along to the right people.  Would a "Signed-off-by: 
Analog Devices" (similar to our FSF copyright assignments) be ok or does 
it have to be individuals?  I believe the port actually predates the 
involvement of most of the people working on it now.

> - Do you really need to support old_mmap()?

 From what I can tell, no we don't, although we'll have to make a small 
change to our uClibc.  (A lot of this code got copied from the m68k port 
initially... that may explain a few things).

> - Too much use of open-coded `volatile'.  The objective should be to have
>   zero occurrences in .c files.  And volatile sometimes creates suspicion
>   even when it's used in .h files.

Are you referring to the ones in 
include/asm-blackfin/mach-bf533/cdefBF532.h?  These are memory-mapped 
hardware registers (MMRs); do you have any better suggestions how to 
access these?  That file actually comes from our in-house Visual DSP 
compiler, and while there may be better ways of accessing the register 
than those macros, there is something to be said for being able to drop 
in a replacement if future chips have different addresses for these 
registers.

The Blackfin has a lot of peripherals sitting on the same die as the 
core, and they're all accessed through MMRs.


Bernd
