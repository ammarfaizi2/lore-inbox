Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315544AbSHASXQ>; Thu, 1 Aug 2002 14:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316397AbSHASXQ>; Thu, 1 Aug 2002 14:23:16 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:46353 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S315544AbSHASXP>;
	Thu, 1 Aug 2002 14:23:15 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200208011826.g71IQH0383895@saturn.cs.uml.edu>
Subject: Re: Linux 2.4.19ac3rc3 on IBM x330/x340 SMP - "ps" time skew
To: ltd@cisco.com (Lincoln Dale)
Date: Thu, 1 Aug 2002 14:26:17 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
       david_luyer@pacific.net.au (David Luyer),
       alan@lxorguk.ukuu.org.uk ('Alan Cox'), linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20020801190102.0295bea0@mira-sjcm-3.cisco.com> from "Lincoln Dale" at Aug 01, 2002 09:40:29 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lincoln Dale writes:
> At 09:33 PM 31/07/2002 -0400, Albert D. Cahalan wrote:

>> No shit. Now, how do you create a ps executable that handles
>> a 2.4.xx kernel with a modified HZ value? People did this all
>> the time. I got many bug reports from these people, so don't
>> go saying they don't exist. Remember: one executable, running
>> on both of the these:
>
> thanks for the rant.  most entertaining.  for what its worth, i wasn't 
> trolling.
>
>> 2.2.xx i386 as shipped by Linus
>> 2.4.xx i386 with HZ modified
>
> (i assume you mean 2.4.xx i386 as shipped by Linus)

No.

"Debian GNU/Linux 3.0 released July 19th, 2002
...
This version of Debian supports the 2.2 and 2.4
releases of the Linux kernel."

>> Come on, write the code if you think it's so easy.
>> You get bonus points for supporting 2.0.xx kernels
>> and the IA-64 kernel with that same executable.
>
> i suspect you're confusing me with someone else.

Yes and no. You seem to express a common opinion.
Unlike the others, you may have provided a more
reliable hack than the one currently used.

> in either case, for ELF executables, the kernel puts the CLOCKS_PER_TICK on 
> the stack when loading an elf binary.
> this is defined to be HZ on all platforms except ia32 where its set to 
> 100.  one would hope that if you redefine HZ to something else, you also 
> remember to redefine CLOCKS_PER_TICK to that same value too.

Uh... that's not good. It makes AT_CLKTCK unreliable on i386, cris,
mips, and mips64. I'll have to think about your "one would hope".

> the following code determines the value of CLOCKS_PER_TICK in a reliable 
> manner on the hosts i have here (2.4.xx, 2.5.xx, ia32):
> i don't have any alpha or ia64 boxes here, but i'm confident it'll still 
> give you the correct result.

Thank you very much. I'll have to try this on a 64-bit box.
It works on 32-bit ppc with the 2.4.16 kernel.

> the code doesn't work on a 2.2.16 box here, given 2.2.16 doesn't have 
> AT_CLKTCK, but i believe that is incidental to this discussion.

Not really, but I might rely on sysconf() when AT_CLKTCK is missing.
Then I can tolerate:

a. any unmodified kernel, except alpha arch @ 1200HZ and user-mode @ 20HZ
b. any 2.4.xx kernel with HZ==CLOCKS_PER_SEC, even with an old libc
c. any 2.6.xx kernel, even with an old libc

That might be good enough. Asking users to run 2.4.xx if they want
to play with HZ is pretty reasonable. Asking them to run 2.5.xx,
or hack up the proc filesystem, is not.


