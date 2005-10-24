Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbVJXWyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbVJXWyF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 18:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbVJXWyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 18:54:05 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:48597 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751373AbVJXWyD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 18:54:03 -0400
Date: Mon, 24 Oct 2005 15:54:38 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Badari Pulavarty <pbadari@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Oeser <ioe-lkml@rameria.de>,
       lkml <linux-kernel@vger.kernel.org>, arjan@infradead.org, pavel@ucw.cz,
       dipankar@in.ibm.com, vatsa@in.ibm.com, rusty@au1.ib.com, mingo@elte.hu,
       manfred@colorfullife.com, gregkh@kroah.com
Subject: Re: [PATCH] RCU torture-testing kernel module
Message-ID: <20051024225438.GE12812@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051022231214.GA5847@us.ibm.com> <200510230922.26550.ioe-lkml@rameria.de> <20051023143617.GA7961@us.ibm.com> <200510232055.17782.ioe-lkml@rameria.de> <20051023120521.26031051.akpm@osdl.org> <20051024004709.GA9454@us.ibm.com> <1130171073.6831.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130171073.6831.6.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2005 at 09:24:33AM -0700, Badari Pulavarty wrote:
> On Sun, 2005-10-23 at 17:47 -0700, Paul E. McKenney wrote:
> > On Sun, Oct 23, 2005 at 12:05:21PM -0700, Andrew Morton wrote:
> > > Ingo Oeser <ioe-lkml@rameria.de> wrote:
> > > >
> > > > DEBUG_KERNEL should do nothing more than showing the debugging
> > > >  options. 
> > > 
> > > yup.
> > > 
> > > >  E.g. I don't expect to enable any additional code in an 
> > > >  unrelated file, if I enable Magic-SysRQ on an embedded, unattended device
> > > >  to be able to analyze potential problems via serial console.
> > > > 
> > > >  @Andrew: Would you accept a patch to fix that?
> > > 
> > > more yup.
> > 
> > OK, the attached patch covers this and also fixes the redundant #include
> > that Greg KH spotted.
> > 
> > Thoughts?
> 
> Paul,
> 
> I enabled RCU_TORTURE_TEST in 2.6.14-rc5-mm1. My machine took 10+
> minutes to boot and let me login. RCU kthreads are hogging the CPU. 
> Is this expected ? 

If you did CONFIG_RCU_TORTURE_TEST=y, then yes.

I do CONFIG_RCU_TORTURE_TEST=m so that I can just do a "modprobe rcutorture"
when I want to start the test.  Also allows me to do several runs per boot
with different arguments.

I wonder if I should somehow exclude "=y" on this one -- I haven't come
up with any case where it is useful.

Thoughts?

							Thanx, Paul

> Thanks,
> Badari
> 
> top - 15:32:55 up 22 min,  1 user,  load average: 10.96, 12.07, 9.18
> Tasks:  94 total,  11 running,  83 sleeping,   0 stopped,   0 zombie
> Cpu(s):  2.5% us, 97.5% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,
> 0.0% si
> Mem:   7145152k total,   350656k used,  6794496k free,    50876k buffers
> Swap:  1048784k total,        0k used,  1048784k free,   160168k cached
> 
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>   168 root      20  -5     0    0    0 R 50.2  0.0  10:44.01
> rcu_torture_rea
>   171 root      20  -5     0    0    0 R 50.2  0.0  10:47.86
> rcu_torture_rea
>   175 root      20  -5     0    0    0 R 50.2  0.0  10:49.83
> rcu_torture_rea
>   169 root      20  -5     0    0    0 R 49.9  0.0  10:47.07
> rcu_torture_rea
>   172 root      20  -5     0    0    0 R 49.9  0.0  10:50.04
> rcu_torture_rea
>   173 root      20  -5     0    0    0 R 49.9  0.0  10:43.79
> rcu_torture_rea
>   174 root      20  -5     0    0    0 R 49.9  0.0  10:39.16
> rcu_torture_rea
>   170 root      20  -5     0    0    0 R 40.2  0.0  10:38.68
> rcu_torture_rea
> 
> 
> 
> 
