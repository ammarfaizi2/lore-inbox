Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbTENNvQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 09:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbTENNvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 09:51:16 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:55710 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262217AbTENNvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 09:51:14 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16066.19659.609760.316141@gargle.gargle.HOWL>
Date: Wed, 14 May 2003 16:03:55 +0200
From: mikpe@csd.uu.se
To: alexander.riesen@synopsys.COM
Cc: mikpe@csd.uu.se, linux-laptop@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.69+bk: oops in apmd after waking up from suspend mode
In-Reply-To: <20030514134600.GA16533@Synopsys.COM>
References: <20030514094813.GA14904@Synopsys.COM>
	<16066.16102.618836.204556@gargle.gargle.HOWL>
	<20030514134600.GA16533@Synopsys.COM>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Riesen writes:
 > mikpe@csd.uu.se, Wed, May 14, 2003 15:04:38 +0200:
 > > Since 2.5.69-bk8 or so, apm.c will invoke restore_processor_state()
 > > at resume-time. This is needed to reinitialise the SYSENTER MSRs
 > > used by 2.5's new system call mechanism.
 > 
 > and it supposed to go oops?

Of course not. It doesn't oops my Dell Latitude: on that laptop it
prevents oopses since otherwise user-space processes will oops the kernel
as soon as they make a system call or return from a system call. But this
only happens if both the CPU and glibc are capable of using SYSENTER.

 > >  >  <6>note: kapmd[4] exited with preempt_count 2
 > > This I don't like. I'm not convinced the resume path is preempt-safe.
 > > Please try again, either with CONFIG_PREEMPT disabled, or with a
 > > preempt_disable() / preempt_enable() pair around apm.c's suspend code,
 > > like in the patch below. (Untested, you may need to stick an #include
 > > <preempt.h> somewhere in apm.c to make it compile.)
 > 
 > It changed things a bit. preempt_count is 3 now.
 > Oops didn't change.

Ok so it wasn't preempt.
Can you identify in which statement the oops occurs?
And can you confirm that commenting out the calls in apm.c to
save_processor_state() and restore_processor_state() eliminates the oops?

/Mikael
