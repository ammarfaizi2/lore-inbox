Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWCZOcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWCZOcb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 09:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWCZOcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 09:32:31 -0500
Received: from reserv5.univ-lille1.fr ([193.49.225.19]:61400 "EHLO
	reserv5.univ-lille1.fr") by vger.kernel.org with ESMTP
	id S1751283AbWCZOca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 09:32:30 -0500
Message-ID: <4426A5BF.2080804@tremplin-utc.net>
Date: Sun, 26 Mar 2006 16:31:27 +0200
From: Eric Piel <Eric.Piel@tremplin-utc.net>
User-Agent: Thunderbird 1.5 (X11/20060225)
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: nix@esperi.org.uk, rob@landley.net, mmazur@kernel.pl,
       linux-kernel@vger.kernel.org, llh-discuss@lists.pld-linux.org
Subject: Re: [RFC][PATCH 0/2] KABI example conversion and cleanup
References: <200603141619.36609.mmazur@kernel.pl>	<200603231811.26546.mmazur@kernel.pl>	<DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com>	<200603241623.49861.rob@landley.net>	<878xqzpl8g.fsf@hades.wkstn.nix>	<D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com> <20060326065205.d691539c.mrmacman_g4@mac.com>
In-Reply-To: <20060326065205.d691539c.mrmacman_g4@mac.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-2.0.2 (reserv5.univ-lille1.fr [193.49.225.19]); Sun, 26 Mar 2006 16:31:49 +0200 (CEST)
X-USTL-MailScanner-Information: Please contact the ISP for more information
X-USTL-MailScanner: Found to be clean
X-USTL-MailScanner-From: eric.piel@tremplin-utc.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

26.03.2006 13:52, Kyle Moffett wrote/a écrit:
> On Fri, 24 Mar 2006 17:46:27 -0500 Kyle Moffett <mrmacman_g4@mac.com> wrote:
>> I'm working on some sample patches now which I'll try to post in a
>> few days if I get the time.
> 
> Ok, here's a sample of the KABI conversion and cleanup patches that I'm
> proposing.  I have a few fundamental goals for these patches:
> 1)  The Linux kernel compiles and works at every step along the way
> 2)  Since most of the headers are currently quite broken with respect to
>     GLIBC and userspace, I won't spend much extra time preserving
>     compatibility with GLIBC, userspace, or non-GCC compilers.
> 3)  Everything in include/kabi will have a __kabi_ or __KABI_ prefix.
> 4)  Headers in include/linux that need the KABI interfaces will include
>     the corresponding <kabi/*.h> header and define or typedef the
>     necessary KABI definitions to the names the kernel wants.
> 5)  The stuff in include/kabi/*.h should always be completely independent
>     of userspace/kernelspace and not require any includes outside of
>     <kabi/*>.  This means that the only preprocessor symbols that we can
>     assume are present are those provided by the compiler itself.
Hello,

I completely agree with rules 1, 2 and 5. However, IMHO rule 4 should 
just be the inverse of rule 5: The stuff in include/linux should always 
be independent from KABI (and userspace of course). Simply because the 
way we _implement_ things in the kernel has to be different from the 
things that we _specify_ in the kernel ABI. They just append to be both 
written in C language, but it's not a reason to mix them. The kernel 
developers has to be free of doing any kludge, clever things, 
compatibility workarounds without affecting the userspace applications. 
Otherwise, you'll end up with another include/linux after few months! 
Separating the implementation and the binary specification has the 
additional advantage that if some kernel hacker mistakenly change the 
ABI, it's easy to say : "see, after your commit xxxxxxxx, the linux 
header and the kabi header are semantically different. You did something 
Wrong".

As for rule 3, if you have independent headers, this should be much less 
necessary. Additionally, keeping all the names identical to what they 
are already called will allow userspace to just use include/kabi/ as the 
/usr/include/linux/ directory. Avoiding smelly things like:

linux/foo.h:
   #define __kabi_foo foo
   #include <kabi/foo.h>

That was my 2 cents :-)
Regards,
Eric

