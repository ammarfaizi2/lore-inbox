Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136762AbREAXPE>; Tue, 1 May 2001 19:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136763AbREAXOz>; Tue, 1 May 2001 19:14:55 -0400
Received: from mail.gci.com ([205.140.80.57]:17419 "EHLO daytona.gci.com")
	by vger.kernel.org with ESMTP id <S136762AbREAXOo>;
	Tue, 1 May 2001 19:14:44 -0400
Message-ID: <BF9651D8732ED311A61D00105A9CA3150446DC82@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: linux-kernel@vger.kernel.org, suse-sparc@suse.com
Subject: DHCP comiling issues under sparc linux
Date: Tue, 1 May 2001 15:14:38 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the end of a thread between myself and Ted Lemon
regarding building DHCP under Sparc Linux.

I'm not well versed in parsing the kernel code to know
what the subtle differences in the different implementations
of this IOCtl, and am looking for some guidance from the
appropriate maintainers.

Please read below for the summary. I'll be happy to fill
in the blanks off-list.

Thanks,
Leif

-----Original Message-----
Ted Lemon responds to:
> Leif Sawyer who wrote:
> Under Kernel 2.4.3, at least for Sparc64, the following
> define in includes/cf/linux.h  creates the problem:
> 
> 154: #define SIOCGIFCONF_NULL_BUF_GIVES_CORRECT_LEN
> 
> undef'ing this out allows the server to build correctly
> and initialize properly.
>
> #if !(defined(__sparc__) && (LINUX_MAJOR >= 2 && LINUX_MINOR >= 4))
> #define SIOCGIFCONF_NULL_BUF_GIVES_CORRECT_LEN
> #endif

Hm.   So Linux 2.4 on Sparc provides a different API than Linux 2.4 on
Intel.   That's lame.

But I would like to think that this would be considered a bug, and
therefore fixed.

> I'll try this on my i386 box at home and see if it compiles correctly
> as well.  That won't be until late tonight, if i'm lucky.

Cool, thanks.   The code *should* work unmodified on Linux 2.4/i386.
Really, it should work for the sparc version as well - I don't suppose
I could talk you into reporting this to the Linux/sparc people as a
bug?

The deal is that you're supposed to be able to call SIOCGIFCONF with a
length of zero, and SIOCGIFCONF will return the length of the buffer
needed to record all the interface configuration information, and then
you allocate a buffer that size and call SIOCGIFCONF again.   This
supposedly works on 2.4 for intel, and on 2.2 for intel, so it makes
sense that it should work on 2.2 and 2.4 for sparc as well.   :'}

			       _MelloN_
