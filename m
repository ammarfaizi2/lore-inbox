Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318203AbSHZSrU>; Mon, 26 Aug 2002 14:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318205AbSHZSrU>; Mon, 26 Aug 2002 14:47:20 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:32402 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318203AbSHZSrU>; Mon, 26 Aug 2002 14:47:20 -0400
Date: Mon, 26 Aug 2002 11:45:36 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Pavel Machek <pavel@elf.ucw.cz>, Andrea Arcangeli <andrea@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mikael Pettersson <mikpe@csd.uu.se>,
       john stultz <johnstul@us.ibm.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Leah Cunningham <leahc@us.ibm.com>,
       wilhelm.nuesser@sap.com, paramjit@us.ibm.com, msw@redhat.com
Subject: Re: [PATCH] tsc-disable_B9
Message-ID: <159220000.1030387536@flay>
In-Reply-To: <20020826161031.GA479@elf.ucw.cz>
References: <1028812663.28883.32.camel@irongate.swansea.linux.org.uk> <1028860246.1117.34.camel@cog> <20020815165617.GE14394@dualathlon.random> <1029496559.31487.48.camel@irongate.swansea.linux.org.uk> <15708.64483.439939.850493@kim.it.uu.se> <20020821131223.GB1117@dualathlon.random> <1029939024.26425.49.camel@irongate.swansea.linux.org.uk> <20020821143323.GF1117@dualathlon.random> <1029942115.26411.81.camel@irongate.swansea.linux.org.uk> <20020821161317.GI1117@dualathlon.random> <20020826161031.GA479@elf.ucw.cz>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> And following your argument that these apps have been silenty broken
>> since 1999, if there's no broken app out there, nobody will ever get the
>> instruction fault. If there's any app broken out there we probably like
> 
> No. rdtsc is still usefull if you are clever and statistically filter
> out. Also rdtsc provides you number of cycles, so if you want to know
> how many cycles mov %eax,%ebx takes, you can do that even on
> speedstep. Anything that correlates rdtsc to real time is broken, however.

It's not correlating it to real time that's the problem. It's getting resceduled
inbetween calls that hurts. Take your example.

rdtsc
mov %eax,%ebx
			<- get rescheduled here
rdtsc

Broken. May even take negative "time".

M.

