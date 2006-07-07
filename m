Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbWGGWsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbWGGWsy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 18:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWGGWsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 18:48:54 -0400
Received: from 142.163.233.220.exetel.com.au ([220.233.163.142]:53642 "EHLO
	idefix.homelinux.org") by vger.kernel.org with ESMTP
	id S932365AbWGGWsy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 18:48:54 -0400
Subject: Re: Suspend to RAM regression tracked down
From: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
To: Dave Jones <davej@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, cpufreq@lists.linux.org.uk
In-Reply-To: <20060707162152.GB3223@redhat.com>
References: <1151837268.5358.10.camel@idefix.homelinux.org>
	 <44A80B20.1090702@goop.org> <1152271537.5163.4.camel@idefix.homelinux.org>
	 <20060707162152.GB3223@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Organization: =?ISO-8859-1?Q?Universit=E9?= de Sherbrooke
Date: Sat, 08 Jul 2006 08:48:49 +1000
Message-Id: <1152312530.14453.16.camel@idefix.homelinux.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 07 juillet 2006 à 12:21 -0400, Dave Jones a écrit :
> On Fri, Jul 07, 2006 at 09:25:37PM +1000, Jean-Marc Valin wrote:
>  > > There was a race in ondemand and conservative which made them lock up on 
>  > > resume (possibly only on SMP systems though).  There's a patch for that 
>  > > in current -mm, but I suspect there's another problem (still haven't had 
>  > > any time to track it down).
>  > 
>  > OK, I tried the patch with 2.6.17 and it didn't work. My laptop failed
>  > to resume on the first try, so it must be something else. Could someone
>  > actually have a look at the changes in 2.6.12-rc5-git6 (which happen to
>  > be cpufreq-related)? I spend months pinpointing the problem to that
>  > version (it's takes several days to reproduce). I'd appreciate if
>  > someone could at least have a look at what changed there and maybe fix
>  > it.
> 
> Can you show /proc/cpuinfo for the affected system ?
> If it's 15/3/4 or 15/4/1, that would explain why this kernel,
> as this was when support for those models got introduced to
> speedstep-centrino.

Not sure what's the 15/..., but here's the content:
% cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 9
model name      : Intel(R) Pentium(R) M processor 1600MHz
stepping        : 5
cpu MHz         : 598.132
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 sep mtrr pge mca cmov
pat clflush dts acpi mmx fxsr sse sse2 tm pbe est tm2
bogomips        : 1197.24

BTW, speedstep worked fine on my laptop with 2.6.12-rc5-git5 and
earlier.

> If it's not that, there is a pretty large delta in the ondemand
> governor in this update, but I don't see anything blindlingly
> obvious from looking over it.

Well, is there some way of doing a bisection over these changes? As far
as I know, the problem probably affects all Dell D600 owners, probably
others.

	Jean-Marc
