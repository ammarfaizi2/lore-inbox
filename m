Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318257AbSHZWoU>; Mon, 26 Aug 2002 18:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318258AbSHZWoU>; Mon, 26 Aug 2002 18:44:20 -0400
Received: from [195.223.140.120] ([195.223.140.120]:19568 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318257AbSHZWoT>; Mon, 26 Aug 2002 18:44:19 -0400
Date: Tue, 27 Aug 2002 00:49:47 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Pavel Machek <pavel@elf.ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Mikael Pettersson <mikpe@csd.uu.se>, john stultz <johnstul@us.ibm.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Leah Cunningham <leahc@us.ibm.com>,
       wilhelm.nuesser@sap.com, paramjit@us.ibm.com, msw@redhat.com
Subject: Re: [PATCH] tsc-disable_B9
Message-ID: <20020826224946.GW9899@dualathlon.random>
References: <20020815165617.GE14394@dualathlon.random> <1029496559.31487.48.camel@irongate.swansea.linux.org.uk> <15708.64483.439939.850493@kim.it.uu.se> <20020821131223.GB1117@dualathlon.random> <1029939024.26425.49.camel@irongate.swansea.linux.org.uk> <20020821143323.GF1117@dualathlon.random> <1029942115.26411.81.camel@irongate.swansea.linux.org.uk> <20020821161317.GI1117@dualathlon.random> <20020826161031.GA479@elf.ucw.cz> <159220000.1030387536@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159220000.1030387536@flay>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2002 at 11:45:36AM -0700, Martin J. Bligh wrote:
> >> And following your argument that these apps have been silenty broken
> >> since 1999, if there's no broken app out there, nobody will ever get the
> >> instruction fault. If there's any app broken out there we probably like
> > 
> > No. rdtsc is still usefull if you are clever and statistically filter
> > out. Also rdtsc provides you number of cycles, so if you want to know
> > how many cycles mov %eax,%ebx takes, you can do that even on
> > speedstep. Anything that correlates rdtsc to real time is broken, however.
> 
> It's not correlating it to real time that's the problem. It's getting resceduled
> inbetween calls that hurts. Take your example.
> 
> rdtsc
> mov %eax,%ebx
> 			<- get rescheduled here
> rdtsc
> 
> Broken. May even take negative "time".

you need to save %edx too, then it would be perfectly safe on a
synchronized TSC hardware (as far as the reschedule doesn't take more
than 2^64 ticks).

Andrea
