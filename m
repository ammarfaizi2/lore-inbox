Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261515AbTCZJUh>; Wed, 26 Mar 2003 04:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261517AbTCZJUh>; Wed, 26 Mar 2003 04:20:37 -0500
Received: from turn6.biologie.uni-konstanz.de ([134.34.128.74]:38325 "EHLO
	turn6.biologie.uni-konstanz.de") by vger.kernel.org with ESMTP
	id <S261515AbTCZJUf>; Wed, 26 Mar 2003 04:20:35 -0500
Message-ID: <3E81737E.5080604@uni-konstanz.de>
Date: Wed, 26 Mar 2003 10:31:42 +0100
From: Kay Diederichs <kay.diederichs@uni-konstanz.de>
Organization: =?ISO-8859-1?Q?Universit=E4t_Konstanz?=
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030314
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
CC: Fionn Behrens <fionn@unix-ag.org>
Subject: Re: System time warping around real time problem - please help
References: <20030325164014$031c@gated-at.bofh.it>
In-Reply-To: <20030325164014$031c@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fionn,

I had similar problems, and reported them on this list on 12/04/2002 . 
The reason is the amd76x_pm module which leads to the TSCs of the CPUs 
to become unsyncronized.

One way around this is to disable TSC altogether; this in my case 
required installing a glibc compiled for i386 (instead of i686) which 
slows some things down, and to use the 'notsc' boot option.

However, programs that use rdtsc (in my case Intels Fortran Compiler, 
ifc) then fail. As I develop programs using ifc, I therefore have not 
been able to use amd76x_pm - I wish there were a better solution, and 
wonder why this is not a problem with e.g. dual-processor Xeons.

Kay



Fionn Behrens wrote:
> Hello all,
> 
> 
> I have got an increasingly annoying problem with our fairly new (fall
> '02) Dual Athlon2k+ Gigabyte 7dpxdw linux system running 2.4.20.
> The only kernel patch applied is Alan Cox's ptrace patch.
> 
> To say it right away: the system is not overclocked or anything and
> never was. It has decent cooling and is used as a combined workstation
> and server.
> 
> I cant say exactly when it started but the system clock tends to begin
> jumping around real time in an erratic manner, usually after about 12-48
> hours of uptime. The maximum time jump is about 5 seconds back or forth
> so the time is always "about" right.
> To give you an example to visualize, you can watch asclock in X and see
> the second clock-hand jumping like 3 seconds backwards, then 5 seconds
> forth, 2 back and 1 forth or so within 2 or 3 seconds.
> For a demonstration I wrote the following short example in python:
> 
> t = 0
> while 1:
>   n = time()
>   if t > n: print t, ">", n
>   t = n
> 
> Running this loop returned the following lines:
> 
> 1048608745.61 > 1048608745.60
> 1048608745.63 > 1048608745.62
> 1048608745.65 > 1048608745.64
> 1048608748.23 > 1048608745.67
> 1048608748.27 > 1048608745.71
> 1048608748.30 > 1048608745.74
> 1048608748.34 > 1048608745.78
> 1048608748.42 > 1048608745.86
> 1048608748.47 > 1048608745.91
> 1048608748.52 > 1048608745.96
> [----cut----]
> 
> So you see the time() on this system is constantly overtaking itself and
> jumping back. It almost looks like two parallel time()s are there and it
> switches back and forth between them.
> 
> I recompiled the kernel, I upgraded the BIOS to the latest version
> available, I disabled ntp and tried some more I dont recall yet - no
> success. Due to the erratic timer, working on the machine is no fun.
> Software crashes are regularly - naturally. No programmer expects system
> timers going back in time.
> 
> I am pretty desperate and I'd appreciate any hints on what to check.
> I'll glady present any system detail that you might miss for a proper
> analysis on request per email or on freenode (Fionn).
> 
> Thank you in advance,
>    			F. Behrens (Not a subscriber of this list)

-- 
Kay Diederichs         http://strucbio.biologie.uni-konstanz.de/~kay
email: Kay.Diederichs @ uni-konstanz.de  Tel +49 7531 88 4049 Fax 3183
When replying to my email, please remove the blanks before and after the 
"@" !
Fakultaet fuer Biologie, Universitaet Konstanz, Box M656, D-78457 Konstanz

