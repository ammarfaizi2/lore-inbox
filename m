Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318230AbSGWWyO>; Tue, 23 Jul 2002 18:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318232AbSGWWyO>; Tue, 23 Jul 2002 18:54:14 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:45617 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S318230AbSGWWyN>; Tue, 23 Jul 2002 18:54:13 -0400
Date: Wed, 24 Jul 2002 00:55:19 +0200
From: Dominik Brodowski <devel@brodo.de>
To: Bill Davidsen <davidsen@tmr.com>
Cc: davej@suse.de, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] resolve ACPI oops on boot
Message-ID: <20020724005518.A837@brodo.de>
References: <20020718231509.A539@brodo.de> <Pine.LNX.3.96.1020723165428.2194A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <Pine.LNX.3.96.1020723165428.2194A-100000@gatekeeper.tmr.com>; from davidsen@tmr.com on Tue, Jul 23, 2002 at 05:20:57PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2002 at 05:20:57PM -0400, Bill Davidsen wrote:
> On Thu, 18 Jul 2002, Dominik Brodowski wrote:
> 
> > An u8 was casted into an u32, then all 32 bits were set to zero, this
> > causing another variable - in my case, processor flags - to be corrupted. 
> > 
> > Dominik
> 
> But that's not what's happening here, the pointer is being cast, if the
> object of the pointer is not u32, then casting the pointer doesn't fix the
> real problem. If the "data" pointer points to a u8, then no casting will
> make it work right when you save 32 bits into an 8 bit space. If this
> changes the problem it's because of alignment, perhaps.
There is the argument "size" to acpi_hw_low_level_read which makes sure that
only the right data is being read. Problem is that a sort of
"segmentation fault" occurs when such a cast allows writing in different
memory than allocated for the value.
 
> You give neither the kernel version nor the architecture
kernel version 2.5.2[5,6] or 2.4.-kernels with acpi-patch 20020709, 
architecture: all architectures that implement Embedded Controllers.

> I think the cast is just to avoid the compiler whining about types, the
> version I have is actually type "(acpi_generic_address*)" not (u32*), I
> would think the compiler would still complain, but maybe only with
> -pedantic or whatever.
The casts were probably introduced for that reason. Per se, they are not
critical - but if there is any assumption later on that the data structure
is indeed of the large size, there is a problem.

Dominik
