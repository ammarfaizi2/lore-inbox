Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265245AbRFUVf4>; Thu, 21 Jun 2001 17:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265248AbRFUVfi>; Thu, 21 Jun 2001 17:35:38 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:12977 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S265245AbRFUVfd>;
	Thu, 21 Jun 2001 17:35:33 -0400
Date: Thu, 21 Jun 2001 22:35:18 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Craig Milo Rogers <rogers@ISI.EDU>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: Controversy over dynamic linking -- how to end the panic (long)
Message-ID: <2144838090.993162917@[169.254.45.213]>
In-Reply-To: <1110.993155660@ISI.EDU>
In-Reply-To: <1110.993155660@ISI.EDU>
X-Mailer: Mulberry/2.1.0a6 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 3. A kernel module loaded at runtime, after kernel build, *is not*
>>   to be considered a derivative work.
>
> It doesn't much matter
> under the GPL, anyway, so long as the in-code kernel image isn't
> "copied or distributed".

Broadly agree - thanks for someone pointing out the obvious
here. Perhaps an analysis from a clause by clause reading
would be useful.

This seems to me to be the nub of the argument. There are three
questions to be considered:

1. Is development of a kernel module distributed under terms
   other than under the GPL (for instance, binary only) a
   breach of the license?

2. If not, is distributing such a kernel module (under its
   own license) along with the kernel (otherwise correctly,
   under its license) a breach of the GPL?

3. Is running the kernel, and loading such a kernel module,
   a breach of the kernel's license?

In order:

1. This hinges on whether the driver is covered by the GPL
   (definition of "Program" in 0). As the driver is clearly
   not the kernel, the test is whether it is a derived work,
   under copyright law. If we have already excluded (somehow,
   and I can't find it explicitly) inclusion of kernel headers
   from making a 'derived work', or if copyright law would
   not dictate that such inclusions made a 'derived work'
   (and I think that would be reasonably safe in a project
   of non-trivial size), then one could safely say that
   (1) would not be a breach of the license. Putting kernel
   headers under LGPL or other ammended GPL would clarify the
   matter beyond dispute.

2. To answer (2), we assume that (1) does not apply, and that
   a kernel module is (thus) not a derived work, and that the
   GPL does not apply to it. Reading license section (2):
   "If identifiable sections of that work are not derived
   from the Program, and can be reasonably considered independent
   and separate works in themselves, then this License, and its
   terms, do not apply to those sections when you distribute
   them as separate works." and further "In addition, mere
   aggregation of another work not based on the Program
   with the Program (or with a work based on the Program) on a
   volume of a storage or distribution medium does not bring the
   other work under the scope of this License." clearly shows
   that if the distribution of the driver alone is not in
   breach of the GPL (as it is not a derived work), then,
   as a work that is not a derived work, it can be distributed
   with the kernel.

3. The license states "Activities other than copying, distribution
   and modification are not covered by this License; they are
   outside its scope.  The act of running the Program is not
   restricted, and the output from the Program is covered only
   if its contents constitute a work based on the
   Program (independent of having been made by running the Program).
   Whether that is true depends on what the Program does."
   Now it is reasonably easy to argue that loading linux kernel, and
   linking with arbitrary kernel modules after running the kernel
   is not distribution. It could easilly be argued that it is
   not copying, any more than playing a CD whose contents
   are (temporarilly) copied into buffers on the CD player is
   copying. There is a possibility that the 'work' is being
   modified. However, the work modifies itself in several ways
   (it unzips the image) as part of its normal running. Further,
   the header from Linus says "NOTE! This copyright does *not*
   cover user programs that use kernel services by normal system
   calls - this is merely considered normal use of the kernel, and
   does *not* fall under the heading of "derived work". Note the
   use of the words 'user programs' not 'user mode programs'. But
   in anycase, insmod is a user program and a user mode program,
   which uses normal system calls (documented in libraries),
   albeit to change the behaviour of the kernel. But crucially,
   let us assume this argument fails, and 'insmod' actually
   performs modification of the work. The only obligations
   on modifiers seem to be under section (2), which obligies
   modifiers to do things with modified files (none), and
   on distribution (none, of the modified work). An implication
   of this reading is that you are free to modify the linux
   kernel (or any other GPL program) in any way you want,
   and retain whatever copyright you want on such modifications,
   so long as you neither copy nor distribute the result (though
   arguably you could distribute the modifications if you did not
   distribute any part of the original). I believe that (at least
   without the parenthesised element) is entirely within both the
   letter and the spirit of the GPL - it is /not/ designed to
   keep you from developing (under copyright or otherwise)
   your own modifications, it's designed to keep you from denying
   or restricting rights of distribution of the GPL'd code if
   you distribute stuff yourself. This is set out clearly
   in the preamble.

Areas of doubt:

A. Are all contributed patches / files /always/ under a license
   no more restrictive than 'COPYING' - including Linus'
   preamble.

B. Is it clear that inclusion of kernel headers when compiling
   a progam does not make that program a derived work of the
   kernel.

Implications:

A. It would be worth Linus publicising the fact (or some URL
   be added to Linux kernel postings) that patches by default
   will be assumed to be under the 'COPYING' license.

B. It would be worth someone clearing up the status of the
   license on header files.

C. It would be preferable if people read the COPYING file
   before commenting on license issues.

--
Alex Bligh
