Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267582AbTBGAAv>; Thu, 6 Feb 2003 19:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267613AbTBGAAv>; Thu, 6 Feb 2003 19:00:51 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60421 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267582AbTBGAAt>; Thu, 6 Feb 2003 19:00:49 -0500
Date: Fri, 7 Feb 2003 00:10:07 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Restore module support.
Message-ID: <20030207001006.A19306@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Roman Zippel <zippel@linux-m68k.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	linux-kernel@vger.kernel.org
References: <20030204233310.AD6AF2C04E@lists.samba.org> <Pine.LNX.4.44.0302062358140.32518-100000@serv> <20030206232515.GA29093@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030206232515.GA29093@kroah.com>; from greg@kroah.com on Thu, Feb 06, 2003 at 03:25:15PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2003 at 03:25:15PM -0800, Greg KH wrote:
> Come on, what Rusty did was the "right thing to do" and has made life
> easier for all of the arch maintainers (or so says the ones that I've
> talked to)

And I'll promptly provide you with the other view.  I'm still trying to
sort out the best thing to do for ARM.  We have the choice of:

1. load modules in the vmalloc region and build two jump tables, one for
   the init text and one for the core text.

2. fix vmalloc and /proc/kcore to be able to cope with a separate module
   region located below PAGE_OFFSET.  Currently, neither play well with
   this option.

(1) has the advantage that it's all architecture code, its what we've
done with the old modutils, and I've finally managed to implement it.
However, it introduces an extra instruction and data cache line fetch
to branches from modules into the kernel text.

(2) has the disadvantage that its touching non-architecture specific
code, but this is the option I'd prefer due to the obvious performance
advantage.  However, I'm afraid that it isn't worth the effort to fix
up vmalloc and /proc/kcore.  vmalloc fix appears simple, but /proc/kcore
has issues (anyone know what KCORE_BASE is all about?)

I've not made up my mind which option I'm going to take.  If I don't get
around to fixing /proc/kcore by this weekend, I'll probably just throw
option (1) at Linus, which bring Linus' tree back to a buildable state
for some ARM targets again.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
