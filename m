Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbWAJNsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWAJNsa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 08:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbWAJNsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 08:48:30 -0500
Received: from aun.it.uu.se ([130.238.12.36]:42195 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1750875AbWAJNs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 08:48:29 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17347.47882.735057.154898@alkaid.it.uu.se>
Date: Tue, 10 Jan 2006 14:47:54 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2G memory split
In-Reply-To: <20060110125852.GA3389@suse.de>
References: <20060110125852.GA3389@suse.de>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe writes:
 > Hi,
 > 
 > It does annoy me that any 1G i386 machine will end up with 1/8th of the
 > memory as highmem. A patch like this one has been used in various places
 > since the early 2.4 days at least, is there a reason why it isn't merged
 > yet? Note I just hacked this one up, but similar patches abound I'm
 > sure. Bugs are mine.
 > 
 > Signed-off-by: Jens Axboe <axboe@suse.de>
 > 
 > diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
 > index d849c68..0b2457b 100644
 > --- a/arch/i386/Kconfig
 > +++ b/arch/i386/Kconfig
 > @@ -444,6 +464,24 @@ config HIGHMEM64G
 >  
 >  endchoice
 >  
 > +choice
 > +	depends on NOHIGHMEM
 > +	prompt "Memory split"
 > +	default DEFAULT_3G
 > +	help
 > +	  Select the wanted split between kernel and user memory. On a 1G
 > +	  machine, the 3G/1G default split will result in 128MiB of high
 > +	  memory. Selecting a 2G/2G split will make all of memory available
 > +	  as low memory. Note that this will make your kernel incompatible
 > +	  with binary only kernel modules.

2G/2G is not the only viable alternative. On my 1GB x86 box I'm
using "lowmem1g" patches for both 2.4 and 2.6, which results in
2.75G for user-space. I'm sure others have other preferences.
Any standard option for this should either have several hard-coded
alternatives, or should support arbitrary values (within reason).

(See http://www.csd.uu.se/~mikpe/linux/patches/*/patch-i386-lowmem1g-*
if you're interested.)

/Mikael
