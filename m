Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbWCZIbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWCZIbZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 03:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWCZIbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 03:31:25 -0500
Received: from ishtar.tlinx.org ([64.81.245.74]:35282 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S1751218AbWCZIbZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 03:31:25 -0500
Message-ID: <4426515B.5040307@tlinx.org>
Date: Sun, 26 Mar 2006 00:31:23 -0800
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Save 320K on production machines?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have one older system with fixed resources (upgraded
as far as it will go) that I try to use as a "stable" machine.
It's had maybe 2-3 unexplained "Oopses" over the past 3-4
years (subtracting out configuration problems, where I usually
had a debug-enabled kernel installed anyway).  To minimize
problems, I disable unused hardware, and all _used_ hardware
is compiled in (no module loading overhead, no chances for
arbitrary code insertion).

I find I can save a bunch of memory if I turn off Debugging
symbols and enable compile-time optimization.  I know it's
not something useful for development, but some people might
find the extra memory useful.

320240    bytes of memory savings comes from:
188464    Turning off debugging symbols (CONFIG_KALLSYMS)
125008    Compiler Optimization
  6784    Disabling unused code (HOTPLUG stubs)**2


** primarily "funit-at-a-time", though -fweb &
    -frename-registers may add a bit (GCC 3.3.5 as
   patched by SuSE; Maybe extra optimizations could
   be a "CONFIG" option much like regparms is now?

**2 (please don't this as condescending; I know many
    people already know this stuff, but, I find it's
    best not to _assume_ what people know) But anyway...
    I've always been taught that disabling unused code
    was one way to improve reliability and performance. 
    Generally, it is in the code-paths and features
    that are least used that are most likely to have
    hidden problems.  I've always been told that it is
    more secure to disable whatever features and drivers
    you don't need.  It's similar to the concept of not
    putting a C-development environment or ssh-client
    on your web server. 

I know 320K isn't that much to some people, but you have
to remember, that double that amount is all some people
will "ever need"...:-)  Not working with new hardware
is leading me to attempting to squeeze the last bits of
performance out of my current hardware and software.   :-)

-l


