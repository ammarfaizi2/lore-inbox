Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263126AbUFRVHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbUFRVHf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 17:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbUFRVGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 17:06:44 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:22977 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263687AbUFRU74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 16:59:56 -0400
Message-ID: <40D357CB.8020904@opensound.com>
Date: Fri, 18 Jun 2004 13:59:55 -0700
From: 4Front Technologies <dev@opensound.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Stop the Linux kernel madness
References: <40D232AD.4020708@opensound.com> <3217460000.1087518092@flay> <40D23701.1030302@opensound.com> <20040618204655.GA4441@mars.ravnborg.org>
In-Reply-To: <20040618204655.GA4441@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:

> On Thu, Jun 17, 2004 at 05:27:45PM -0700, 4Front Technologies wrote:
> 
>>Our commercial OSS drivers work perfectly with Linux 2.6.5, 2.6.6, 2.6.7
>>and they are failing to install with SuSE's 2.6.5 kernel. The reason is that
>>they have gone and changed the kernel headers which mean that nothing works.
>>
>>For instance our kernel interface module doesn't compile anymore we see the 
>>following
>>errors:
>>
>>
>>>make -C /lib/modules/`uname -r`/build scripts scripts_basic 
>>>include/linux/version.h
>>>make[1]: Entering directory `/usr/src/linux-2.6.5-7.75-obj/i386/bigsmp'
>>>make[1]: Nothing to be done for `scripts'.
>>>make[1]: *** No rule to make target `scripts_basic'.  Stop.
>>>make[1]: Leaving directory `/usr/src/linux-2.6.5-7.75-obj/i386/bigsmp'
>>>make: *** [ossbuild] Error 2
>>>
>>>Trying to compile using 
>>>INCLUDE=/lib/modules/2.6.5-7.75-bigsmp/build/include
>>>In file included from /usr/include/asm/smp.h:18,
>>>                from /usr/include/linux/smp.h:17,
>>>                from /usr/include/linux/sched.h:23,
>>>                from /usr/include/linux/module.h:10,
>>>                from src/sndshield.c:49:
>>>/usr/include/asm/mpspec.h:6:25: mach_mpspec.h: No such file or directory
>>>In file included from /usr/include/asm/smp.h:18,
>>>                from /usr/include/linux/smp.h:17,
>>>                from /usr/include/linux/sched.h:23,
>>>                from /usr/include/linux/module.h:10,
>>
>>
>>
>>Why is this happening?. It's working fine with Linux 2.6.5 and also worked 
>>with
>>Linux 2.6.4 kernels from SuSE 9.1
> 
> 
> It looks like SuSE as the first distribution took the sane approach to
> seperate source and output files.
> I presume they have documented this somewhere - and I have a patch
> from Andreas G. that should actually solve this if a module is
> compiled in the usual way like you do.
> 
> So you seems to be bitten by a distributor starting to use a new
> facility in kbuild.
> 
> Why did you not post the error in your first mail btw?
> 
> 	Sam
> 


Sam,

The problem is that we had our software working correctly with Linux 2.6.7
and when we started to get a flood of support requests from our customers, I
just pulled down the sources from kernel.org to see what might be the
differences and when you start seeing huge 12.8 Megs of differences between
2.6.5 from kernel.org and SuSE's 2.6.5 kernel, you start to wonder if the
problem is with your software.

The fact is that we discovered belatedly that the whole problem
was nothing but a broken build link to the correct sources makes my point
that a) there are no standards for shipping sources for out-of-kernel modules
to be able to build b) massive variations from the vanilla kernels causes
developers to have to keep doing #ifdef SUSE or #ifdef REDHAT or #ifdef DEBIAN
and #if (SUSE && LINUX-2.6.5) && !(REDHAT && LINUX 2.6.5) and so on....is a
cause for massive amounts of grief.

I apologize for not having the forsight to figure out that KBUILD was the
problem.


best regards

Dev Mazumdar
-----------------------------------------------------------
4Front Technologies
4035 Lafayette Place, Unit F, Culver City, CA 90232, USA.
Tel: (310) 202 8530		URL: www.opensound.com
Fax: (310) 202 0496 		Email: info@opensound.com
-----------------------------------------------------------
