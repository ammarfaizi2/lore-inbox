Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317102AbSILScy>; Thu, 12 Sep 2002 14:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317112AbSILScx>; Thu, 12 Sep 2002 14:32:53 -0400
Received: from kim.it.uu.se ([130.238.12.178]:61613 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S317102AbSILScw>;
	Thu, 12 Sep 2002 14:32:52 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15744.57073.2852.707839@kim.it.uu.se>
Date: Thu, 12 Sep 2002 20:37:36 +0200
To: Robert Love <rml@tech9.net>
Cc: alan@redhat.com, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4-ac task->cpu abstraction and optimization
In-Reply-To: <1031855035.2958.5.camel@phantasy>
References: <1031782906.982.33.camel@phantasy>
	<15744.14760.938667.636159@kim.it.uu.se>
	<1031855035.2958.5.camel@phantasy>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love writes:
 > On Thu, 2002-09-12 at 02:52, Mikael Pettersson wrote:
 > 
 > > This is fairly similar to the "up-opt" patch I have been using for my
 > > 2.4 standard (not -ac) kernels since last winter, available as
 > > <http://www.csd.uu.se/~mikpe/linux/patches/2.4/patch-up-opt-2.4.20-pre6>.
 > > It's not a direct substitute for yours, since -ac changes kernel/sched.c
 > > quite a bit, and it has some unnecessary patches to SMP code, but other
 > > than that, I totally agree with the intention of your patch.
 > 
 > Good ;)
 > 
 > I should of added this is from 2.5; so it has been around for awhile.  I

Actually, the 2.5 patch sort of originates from my 2.4 patch: I did a 2.5
version, Dave Jones included it in the -dj kernel, and Ingo pulled it out
and pushed it into Linus' kernel.

 > also took a look at your patch -- looks good, you should submit it to
 > Marcelo... it cannot hurt for 2.4.

I might do that, unless Alan plans on pushing the -ac sched.c stuff to
Marcelo, in which case my patch would just confuse things. Alan?

 >     -	int processor;
 >     +#ifdef CONFIG_SMP
 >     +	int processor; /* keep old name to avoid upsetting all archs */
 >     +#endif
 > 
 > It is normally bad form to have conditionally entries in the
 > task_struct... otherwise, looks good.

I did that mainly to help catch unconverted references to ->processor.
It's easy enough to clean out.

/Mikael
