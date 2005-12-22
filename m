Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbVLVKWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbVLVKWX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 05:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbVLVKWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 05:22:23 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:56202
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1750724AbVLVKWW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 05:22:22 -0500
Subject: Re: [PATCH/RFC 10/10] example of simple continuous gettimeofday
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Ingo Molnar <mingo@elte.hu>, johnstul@us.ibm.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0512220028250.30930@scrub.home>
References: <Pine.LNX.4.61.0512220028250.30930@scrub.home>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 22 Dec 2005 11:29:42 +0100
Message-Id: <1135247382.2806.122.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-22 at 00:30 +0100, Roman Zippel wrote:

> - I still don't like the idea of a generic gettimeofday() as it prevents
>   more optimized versions, e.g. on the one end with a 1MHz clock you only
>   have usec resolution anyway and this allows to keep almost everything
>   within 32bits. On the other end 64bit archs can avoid the "if (nsec >
>   NSEC_PER_SEC)" by doing something like ppc64 does, but requires a
>   different scaling of the values (to sec instead of nsec).

I strongly disagree. Moving this back into the architechture code for
some micro optimizations is the wrong way to go and a big step back from
Johns patches.

As John correctly analyzed we have dozens of gettimeofday/settimeofday
implementations which are roughly the same and I dont see a benefit to
keep it that way.

The timekeeping is a core functionality which should and can be
completely abstracted. This way we can ensure that the timekeeping is
consistent across architectures. So improvements and extensions to the
core code are immidiately available for all architectures rather than
updating 26 architecture implementations every time.

This allows to handle generic problems like suspend/resume, dynamic
ticks and others in a central place rather than scattered all over the
architecture code.

Same applies for clock source management and switching clock sources. 

> - the clock switch infrastructure can be merged with the clock set
>   mechanism. When setting a clock some internal variables have to be
>   updated as well, which can be reused for the clock switch basically
>   by setting the clock immediately before the switch, so that both
>   clocks run synchronously for a few cycles.

This is a question of implementation details rather than a design
question. 

Can we please concentrate on a clear and generic design model before
discussing optimizations of 20 lines of code? 

	tglx


