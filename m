Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbUKSAxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbUKSAxh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 19:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262959AbUKSAv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 19:51:56 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:32273 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261217AbUKSAvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 19:51:25 -0500
Date: Fri, 19 Nov 2004 01:51:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: ak@suse.de, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: RFC: let x86_64 no longer define X86
Message-ID: <20041119005117.GM4943@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to send a patch after 2.6.10 that removes the following from 
arch/x86_64/Kconfig:

  config X86
        bool
        default y

Additionally, I'll also check all current X86 uses to prevent breakages.


Why?

X86 is _the_ symbol to identify the i386 architecture, but the x86_64 
port hijacked it. Kernel-wise, x86_64 is mostly simply a new port like 
e.g. ia64.


Where is the problem?

To say "X86", you currently have to write "(X86 && !X86_64)" in the 
Kconfig file. This is not intuitive.

Why is e.g. CONFIG_LBD available on x86_64 and even enabled in 
defconfig?


Isn't this an incompatible change?

Yes it is.
But according to the current development model, such changes are allowed 
in 2.6 .

And if you want to support both older and more recent kernels, the 
following dependencies will be correct both before and after this 
change:
- (X86 && !X86_64)
- (X86 && X86_64)


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

