Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262602AbREVJ4G>; Tue, 22 May 2001 05:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262603AbREVJzq>; Tue, 22 May 2001 05:55:46 -0400
Received: from mail.muc.eurocyber.net ([195.143.108.5]:5073 "EHLO
	mail.muc.eurocyber.net") by vger.kernel.org with ESMTP
	id <S262602AbREVJzl>; Tue, 22 May 2001 05:55:41 -0400
Message-ID: <3B0A3794.15BDF9D6@TeraPort.de>
Date: Tue, 22 May 2001 11:55:32 +0200
From: "Martin.Knoblauch" <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-ac11 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: hpa@transmeta.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] Output of L1,L2 and L3 cache sizes to /proc/cpuinfo
In-Reply-To: <3B0A28C0.2FFFC935@TeraPort.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin.Knoblauch" wrote:
> 
> >>
> >> Hi,
> >>
> >> while trying to enhance a small hardware inventory script, I found that
> >> cpuinfo is missing the details of L1, L2 and L3 size, although they may
> >> be available at boot time. One could of cource grep them from "dmesg"
> >> output, but that may scroll away on long lived systems.
> >>
> >
> >Any particular reason this needs to be done in the kernel, as opposed
> >to having your script read /dev/cpu/*/cpuid?
> >
> >        -hpa
> 
>  terse answer: probably the same reason as for most stuff in
> /proc/cpuinfo :-)
> 

 After some checking, I could have made the answer a bit less terse:

- it would require that the kernel is compiled with cpuid [module]
support
  - not everybody may want enable this, just for getting one or two
    harmless numbers.
- you would need a utility with root permission to analyze the cpuid
info. The
  cahce info does not seem to be there in clear ascii.
  - this limits my script to root users, or you need the setuid-bit on
the
    utility. Not really good for security.
- the cpuid stuff is i386 specific [today]. So are my changes. But
implementing
  them for other architectures [if there is interest in the info] would
not
  require to also implement the cpuid on other architectures. Which may
not make any
  sense at all.

 So, having the numbers in clear text in the cpuinfo file looks simpler
and safer to me, although reading /dev/cpu/*/cpuinfo maybe more
versatile [on i386] - at some cost.

 Question: are there any utilities or other uses for the cpuid device
today? Just interested. The kernel seems to work well without it.

Cheers
Martin
