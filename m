Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267115AbSKXBJg>; Sat, 23 Nov 2002 20:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267116AbSKXBJg>; Sat, 23 Nov 2002 20:09:36 -0500
Received: from h-64-105-34-232.SNVACAID.covad.net ([64.105.34.232]:6886 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267115AbSKXBJf>; Sat, 23 Nov 2002 20:09:35 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 23 Nov 2002 17:16:32 -0800
Message-Id: <200211240116.RAA19023@adam.yggdrasil.com>
To: rth@twiddle.net
Subject: Re: [PATCH] modules as shared objects
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Although I remain skeptical that it is net benefit to have the
module loader in the kernel, I like the fact that your change is a net
deletion of 226 lines, which I think should be reason enough to apply
it if it has no disadvantages.

	I was wondering if there is any other ultimate benefit to your
change.  Is there something new that it would enable me to do,
something that I could do more easily, something that would run
faster, consume less memory, etc.?  The only thing that comes to mind
is perhaps loading certain very well behaved self-contained user level
shared libraries, like perhaps some compression, encryption or
non-floating-point math functions.

	Regarding the .init sections, I believe that there are
currently no modules with exception table entries pointing into .init.
So, if you adopt a policy that the .init section will be loaded
contiguously and not dropped if there is an exception table entry
pointing into .init, which currently happens ~0% of the time, you
allocate init and non-init sections the remaining ~100% of the time.
I believe this would allow for allocating smaller non-init sections
with kmalloc for better memory efficiency for small modules, which
will make it more practical have divide some modules into smaller
pieces that aren't always all needed together.  I should also check
and see if kmalloc returns pointers in the 4MB kernel huge page on x86,
which would improve TLB usage.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
