Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264336AbTDKMF7 (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 08:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264338AbTDKMF7 (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 08:05:59 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:8405 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S264336AbTDKMF6 (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 08:05:58 -0400
Date: Fri, 11 Apr 2003 11:27:28 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: george anzinger <george@mvista.com>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 kernel/timer.c may incorrectly reenable interrupts
Message-ID: <20030411112728.M626@nightmaster.csn.tu-chemnitz.de>
References: <24294.1050043625@kao2.melbourne.sgi.com> <3E966BAA.804@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3E966BAA.804@mvista.com>; from george@mvista.com on Fri, Apr 11, 2003 at 12:15:54AM -0700
X-Spam-Score: -32.5 (--------------------------------)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *193xTQ-0002cx-00*NtjA9X/c/g6*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 12:15:54AM -0700, george anzinger wrote:
> As machines get faster and faster, it will be come more and more of a 
> burden to "stop the world" and sync with the interrupt system, which 
> is running at a much slower speed.  This is what the cli / sti/ 
> restore flags causes.  I saw one test where the time to do the cli was 
> as long as the run_timer_list code, for example.

Maybe we could replace some cli/sti pairs with spinlocks? If it
takes more time to cli/sti than to run the whole code section
that will be protected by the spinlock, then it might be better
to use that instead and block in the IRQ dispatch code.

But I have no measures, how fast the spinlocks are in the
non-/contention case

Problems: 
   - The total amount of CLI/STI doesn't matter, for spinlocks it
     does (they are not recursive)

   - spinlocks are usally not compiled in

   - Older CPUs may still benefit from cli/sti.

What do you think?

Regards

Ingo Oeser
-- 
Marketing ist die Kunst, Leuten Sachen zu verkaufen, die sie
nicht brauchen, mit Geld, was sie nicht haben, um Leute zu
beeindrucken, die sie nicht moegen.
