Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265519AbSJSDEw>; Fri, 18 Oct 2002 23:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265521AbSJSDEw>; Fri, 18 Oct 2002 23:04:52 -0400
Received: from zero.aec.at ([193.170.194.10]:47621 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S265519AbSJSDEv>;
	Fri, 18 Oct 2002 23:04:51 -0400
Date: Sat, 19 Oct 2002 05:10:02 +0200
From: Andi Kleen <ak@muc.de>
To: Jeff Dike <jdike@karaya.com>
Cc: john stultz <johnstul@us.ibm.com>, Linus Torvalds <torvalds@transmeta.com>,
       andrea <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>, Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] linux-2.5.43_vsyscall_A0
Message-ID: <20021019031002.GA16404@averell>
References: <1034981832.4042.58.camel@cog> <200210190352.WAA05769@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210190352.WAA05769@ccure.karaya.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2002 at 05:52:53AM +0200, Jeff Dike wrote:
> johnstul@us.ibm.com said:
> > Since no one really brought up any issues with the code itself
> > (correct me if I'm wrong), here is the i386 vsyscall gettimeofday port
> > I sent last night, synced up and ready for integration.
> 
> This vsyscall implementation breaks UML.  Any app that's run inside UML
> that uses vsyscalls will get the host's vsyscalls rather than the UML
> vsyscalls.

Ugh.

Guess you'll have some problems then with UML on x86-64, which always uses
vgettimeofday. But it's only used for gettimeofday() currently, perhaps it's 
not that bad when the UML child runs with the host's time.

I guess it would be possible to add some support for UML
to map own code over the vsyscall reserved locations. UML would need
to use the syscalls then. But it'll be likely ugly.

-Andi
