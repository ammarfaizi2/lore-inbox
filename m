Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261301AbTCTBg7>; Wed, 19 Mar 2003 20:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262628AbTCTBg7>; Wed, 19 Mar 2003 20:36:59 -0500
Received: from ext.aurema.com ([203.31.96.4]:12469 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id <S261301AbTCTBg6>;
	Wed, 19 Mar 2003 20:36:58 -0500
Date: Thu, 20 Mar 2003 12:47:55 +1100
From: Kingsley Cheung <kingsley@aurema.com>
To: linux-kernel@vger.kernel.org
Subject: Re: fluctuations in /proc/stat btime field
Message-ID: <20030320124755.A5602@aurema.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030319154554.C3492@aurema.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030319154554.C3492@aurema.com>; from kingsley@aurema.com on Wed, Mar 19, 2003 at 03:45:54PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 19, 2003 at 03:45:54PM +1100, Kingsley Cheung wrote:
> Hi,
> 
> On a dual SMP box running SuSE-2.4.19-79 (United Linux rc4), the boot
> time in /proc/stat can vary 1 second when read.  I haven't seen this
> on a UP box. Its not a major issue, but I guess its a hindrance if
> one's expecting it to never change:
> 
> gen2 12:06:52 ~: grep btime /proc/stat
> btime 1046838984
> gen2 12:07:06 ~: grep btime /proc/stat
> btime 1046838984
> gen2 12:07:07 ~: grep btime /proc/stat
> btime 1046838983
> gen2 12:07:07 ~: grep btime /proc/stat
> btime 1046838983
> gen2 12:07:08 ~: grep btime /proc/stat
> btime 1046838983
> gen2 12:07:09 ~: grep btime /proc/stat
> btime 1046838984
> gen2 12:07:10 ~: grep btime /proc/stat
> btime 1046838984
> gen2 12:07:11 ~: grep btime /proc/stat
> btime 1046838983
> 
> I'm not familiar with the way IO-APIC timers work or the interrupt
> timer itself, so can someone explain why this is the case? I'm
> guessing that it might simply be a timing issue between when the
> actual interrupt handling updating jiffies in do_timer and the bottom
> half updating xtime.tv_sec (see kernel/timer.c). 
> 
> Maybe by caching the btime value so that its only calculated once is
> the way to go. Attached is the suggested fix, as well as the output
> from /proc/cpuinfo & /proc/interrupts.
> 
> If someone could get back to me on this it would be much appreciated.
> 

Actually, correction: the boot-time does also fluctuate on a UP as
well.  Not nice if you want absolute boot-time.

-- 
		Kingsley
