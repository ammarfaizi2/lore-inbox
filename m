Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266097AbRF2ObM>; Fri, 29 Jun 2001 10:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266096AbRF2ObC>; Fri, 29 Jun 2001 10:31:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17414 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S266094AbRF2Oao>;
	Fri, 29 Jun 2001 10:30:44 -0400
Date: Fri, 29 Jun 2001 15:30:36 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Keith Owens <kaos@ocs.com.au>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.6-pre6: numerous dep_{bool,tristate} $CONFIG_ARCH_xxx bugs
Message-ID: <20010629153036.A10196@flint.arm.linux.org.uk>
In-Reply-To: <200106291410.HAA10170@baldur.yggdrasil.com> <27582.993824469@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <27582.993824469@ocs3.ocs-net>; from kaos@ocs.com.au on Sat, Jun 30, 2001 at 12:21:09AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2001 at 12:21:09AM +1000, Keith Owens wrote:
> Create arch/Config.in which contains
> 
>   define_bool CONFIG_ARCH_i386 n
>   define_bool CONFIG_ARCH_ia64 n
>   define_bool CONFIG_ARCH_sparc n
> 
> etc., then change each of the arch/xxx/Config.in files to
> source arch/Config.in as their first line first.  Still ugly but the
> mainline configs will be much more readable.  It also guarantees that
> any future tests on $CONFIG_ARCH_somearch will work, even if the code
> does not use if statements.

I'd rather that we fixed dep_* so that undefined symbols were treated as
'n', just like the makefiles treat undefined symbols.

On ARM, we have a lot of CONFIG_ARCH_* variables (which yes, I know, should
be CONFIG_MACH_*, but its too late to change it now), and cluttering up the
place with lots of if ... then fi stuff is much less readable than the
dep_* stuff.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

