Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262333AbVDFV1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262333AbVDFV1p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 17:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262334AbVDFV1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 17:27:45 -0400
Received: from fire.osdl.org ([65.172.181.4]:42149 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262333AbVDFV1m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 17:27:42 -0400
Date: Wed, 6 Apr 2005 14:27:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: barryn@pobox.com, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>, mjg59@scrf.ucam.org
Subject: Re: 2.6.12-rc2-mm1
Message-Id: <20050406142749.6065b836.akpm@osdl.org>
In-Reply-To: <20050406125958.GA8150@ip68-4-98-123.oc.oc.cox.net>
References: <20050405000524.592fc125.akpm@osdl.org>
	<20050405134408.GB10733@ip68-4-98-123.oc.oc.cox.net>
	<20050405141445.GA5170@ip68-4-98-123.oc.oc.cox.net>
	<20050405175600.644e2453.akpm@osdl.org>
	<20050406125958.GA8150@ip68-4-98-123.oc.oc.cox.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Barry K. Nathan" <barryn@pobox.com> wrote:
>
> Ok, I've narrowed the problem down to one patch. In 2.6.11-mm3, the
> problem goes away if I remove this patch:
> swsusp-enable-resume-from-initrd.patch

That really helps, thanks.

The patch looks fairly innocent.  I'll give up on this and cc the
developers.

> (Recap of the problem in case this gets forwarded: Resume is almost
> instant without the apparently-guilty patch. With the patch, resume
> takes almost half an hour.)
> 
> BTW, there's another strange thing that's introduced by 2.6.11-rc2-mm1:
> With that kernel, suspend is also ridiculously slow (speed is comparable
> to the slow resume with the aforementioned patch). 2.6.11-rc2 does not
> have that problem.

Does reverting swsusp-enable-resume-from-initrd.patch fix this also?

> Also, with 2.6.12-rc2-mm1, this computer happens to hit the bug where
> all the printk timestamps are 0000000.0000000 (don't take the # of
> digits too literally). Probably unrelated, but I may as well mention it.
> (System is an Athlon XP 2200+ with SiS chipset. I can't remember which
> model of SiS chipset.)

Yes, sorry.  Reverting
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm1/broken-out/sched-x86-sched_clock-to-use-tsc-on-config_hpet-or-config_numa-systems.patch
will fix that one.

