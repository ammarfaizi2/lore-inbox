Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269216AbTGORnA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 13:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269211AbTGORmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 13:42:46 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:13458 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S269187AbTGORl2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 13:41:28 -0400
Date: Tue, 15 Jul 2003 19:38:44 +0200
From: Dominik Brodowski <linux@brodo.de>
To: Dave Jones <davej@codemonkey.org.uk>, Matt Reppert <repp0017@tc.umn.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.0-test1
Message-ID: <20030715173844.GB1950@brodo.de>
References: <Pine.LNX.4.44.0307132055080.2096-100000@home.osdl.org> <20030715001132.3b0fd7a5.repp0017@tc.umn.edu> <20030715105657.GA13879@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030715105657.GA13879@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 11:56:57AM +0100, Dave Jones wrote:
> On Tue, Jul 15, 2003 at 12:11:32AM -0400, Matt Reppert wrote:
>  > I need this to build on powerpc (plus the patch by Jasper Spaans already posted).
> 
>  >   * cpufreq_parse_policy - parse a policy string
>  > diff -NruX /home/arashi/kdontdiff linux-2.6.0-test1-orig/include/linux/notifier.h linux-2.6.0-test1/include/linux/notifier.h
>  > --- linux-2.6.0-test1-orig/include/linux/notifier.h     2003-07-13 23:30:36.000000000 -0400
>  > +++ linux-2.6.0-test1/include/linux/notifier.h  2003-07-14 23:41:56.000000000 -0400
>  > @@ -65,6 +65,7 @@
>  >  #define CPU_UP_CANCELED        0x0004 /* CPU (unsigned)v NOT coming up */
>  >  #define CPU_OFFLINE    0x0005 /* CPU (unsigned)v offline (still scheduling) */
>  >  #define CPU_DEAD       0x0006 /* CPU (unsigned)v dead */
>  > +#define CPUFREQ_ALL_CPUS               ((NR_CPUS))
>  > 
>  >  #endif /* __KERNEL__ */
>  >  #endif /* _LINUX_NOTIFIER_H */
> 
> include/linux/cpufreq.h seems a more natural place to put this.
> Can you confirm that works ok on PPC? I lack hardware to test.

No, please don't do this. There is no function at all in the cpufreq core 
which may be called with CPUFREQ_ALL_CPUS as arguments. Well, there had 
been, many months ago. But it really shall not be defined or used anywhere 
outside the 2.4. proc-intf any more.

Now, wrt the ppc-cpufreq driver: benh's 2.5. tree includes a much more
updated version than plain 2.6.0-test1 -- Ben, can you push that to Linus,
please? Also, please change the line 
 	freqs.cpu = CPUFREQ_ALL_CPUS;
in do_set_cpu_speed() to 
	freqs.cpu = 0;
which is the way it should be done now.

	Dominik
