Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030529AbVIBDAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030529AbVIBDAc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 23:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030659AbVIBDAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 23:00:32 -0400
Received: from smtpout.mac.com ([17.250.248.47]:23292 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1030529AbVIBDAb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 23:00:31 -0400
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C670AD22-97CF-46AA-A527-965036D78667@mac.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: [RFC] Splitting out kernel<=>userspace ABI headers
Date: Thu, 1 Sep 2005 23:00:16 -0400
To: LKML Kernel <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A while ago there was a big discussion about splitting out the
userspace-accessible portions of the kernel headers into a separate
directory, "kabi", "kernel-abi", "linux-abi", or a half-dozen other
suggestions.  Linus sprinkled a bit of holy-penguin-pee on the idea,
but nothing ever really happened after that.  I have some available
time at the moment, and I would be willing to undertake the task,
but I would like a bit of guidance first, both from Linus/akpm/etc,
and from the list in general, about a few initial issues I see from
my initial attempts to sort through the mess:

   1)  There are a couple header files upon which almost everything
else depends, among them {asm,linux}/{posix_,}types.h, which have
some significant duplications.  Many of the archs have weird sizes
for those types to preserve some backwards-compatibility ABI, but
nowhere does it explain if there are any type-size restrictions in
general.  I would propose that those headers be reorganized so that
there are sane defaults for all the types in kabi/types.h, and
archs that require different would #define exceptions in their
kabi/arch-foo/types.h.  This would allow new archs to start with a
sane standard ABI before it becomes set in stone.

   2)  There is a bunch of stuff that would be _really_ useful in
userspace programs as well, even though not kernel ABI, such as
list.h, atomic.h (with a few archs modified due to privilege
restrictions), etc.  If there is interest, I would attempt to split
off those headers into a kcore/kerncore/linuxcore/whatever inline
header collection included in the linux distribution and installed
as part of the kernel headers.

   3)  What names are preferable for the above?  My personal
preferences are "kabi" and "kcore", because those save the most
typing for the sucker trying to do all this (IE: me), although if
someone has good reasons otherwise, I'll listen.

I realize this project is only slightly short of massive, however I
do have a bunch of time and am willing to do the grunt work if
enlightened as to the community desires.  I have a few different
semi-patches almost ready, and I can probably finish up a couple
this weekend if I can figure out which way people want to go.  One
of the major challenges is that kernel files have historically kind
of indiscriminately included asm/foo.h when they really meant
linux/foo.h (See the types.h example), only to have it magically
work because some other header already included linux/types.h
anyways.  If arch/driver/etc maintainers are willing to take patches
to clean that up, I'll start with that and eventually get a decent
set of kabi/* headers.


Cheers,
Kyle Moffett

--
Unix was not designed to stop people from doing stupid things,  
because that
would also stop them from doing clever things.
   -- Doug Gwyn


