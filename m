Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317619AbSGOUNM>; Mon, 15 Jul 2002 16:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317620AbSGOUNL>; Mon, 15 Jul 2002 16:13:11 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:10511 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S317619AbSGOUNK>;
	Mon, 15 Jul 2002 16:13:10 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200207152015.g6FKFuv227476@saturn.cs.uml.edu>
Subject: Re: HZ, preferably as small as possible
To: torvalds@transmeta.com (Linus Torvalds)
Date: Mon, 15 Jul 2002 16:15:56 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
       rmk@arm.linux.org.uk (Russell King), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0207151148080.19586-100000@penguin.transmeta.com> from "Linus Torvalds" at Jul 15, 2002 11:50:58 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
> On Mon, 15 Jul 2002, Albert D. Cahalan wrote:

>> It's not a different value in libproc. There's autodetection.
>> I can't just support "the majority of ARM", and people keep
>> giving me shit about HZ supposedly being a per-arch constant.
>> (not that there's a sane way to get a per-arch constant from
>> user code anyway)
>
> But that's just _wrong_.

If you only support recent kernels and glibc, true.
Debian is about to release a distribution with the 2.2 kernel.

> There _is_ a sane way to get the per-arch constant, and there has been for 
> a long long time.

Your "long long time" is very different, because you
always (?) run the very latest kernel.

> The kernel exports it with the AT_CLKTCK ELF auxiliary note to every ELF
> binary ever loaded, and I think glibc in turn exports that value through
> the regular sysconf(_SC_CLK_TCK) thing. (Yeah, I disagree with some of the
> glibc sysconf implementation, but it sure should be there, and it's
> documented).
>
> If that doesn't work, then it's a glibc bug (well, in theory there could
> be a kernel bug too, but since it's a one-liner in the kernel I really
> doubt it).

Yeah, NOW it should work fine. App code sees:

old glibc and old kernel  -->  guess
old glibc and new kernel  -->  guess
new glibc and old kernel  -->  guess
new glibc and new kernel  -->  useful data

(the guess is correct for unmodified x86)

Two problems with that:

1. must handle the "guess" case
2. can't tell a guess from useful data!

So I can't use the useful data for a few more years.
I can cut that time down to maybe 2 years if I write
code to dig up the ELF notes myself, assuming that
were introduced with the 2.4 kernel.
