Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264573AbTCZDvd>; Tue, 25 Mar 2003 22:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264577AbTCZDvd>; Tue, 25 Mar 2003 22:51:33 -0500
Received: from [131.215.233.56] ([131.215.233.56]:33802 "EHLO bryanr.org")
	by vger.kernel.org with ESMTP id <S264573AbTCZDvc>;
	Tue, 25 Mar 2003 22:51:32 -0500
Date: Tue, 25 Mar 2003 19:50:00 -0800
From: Bryan Rittmeyer <bryanr@bryanr.org>
To: John Levon <levon@movementarian.org>
Cc: oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [patch] oprofile + ppc750cx perfmon
Message-ID: <20030326035000.GA32590@bryanr.org>
References: <20030325050900.GA30294@bryanr.org> <20030325085759.GB30294@bryanr.org> <20030325174309.GB57374@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030325174309.GB57374@compsoc.man.ac.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 05:43:09PM +0000, John Levon wrote:
> > done. patches are -v0002 at http://bryanr.org/linux/oprofile/
> 
> Looks OK, modulo some minor style issues (see doc/CodingStyle).

will fix in v0004.

> The patch seems to be out of date already though. Does the new cpu speed
> code not work OK for you (for the default event value) ?

I was lagging cvs; v0003 merges to today's tree, including the new
CPU_SPEED code. posted at the url above.

> Then you should fix this generally, instead of adding the hack you do.

agree. here's a separate patch for x86+ia64. with it, there's one
extra argument to op_do_profile, and oprofile.c no longer uses op_arch.h
the architecture code directly passes eip and irq_enabled. tested on
i686 2.4.20 and ppc 2.4.20-benh.

http://bryanr.org/linux/oprofile/op_do_profile-refactor.patch

ppc v0003 depends on this change.

> > +/* TODO: fix upper level. [op_rtc_ops in ppc/ia64] is really lame.  */
> 
> Sure.

I'll let you handle this one.

BTW how do you feel about reworking add_sysctl and remove_sysctl to move
shared code inside oprofile.c? Right now the duplication is causing
inconsistency e.g ia64/op_pmu.c "next->mode = 0700;" vs x86/op_nmi.c
"next->mode = 0755;"

-Bryan
