Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbUB2MDE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 07:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbUB2MDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 07:03:04 -0500
Received: from pat.uio.no ([129.240.130.16]:8878 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262039AbUB2MC7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 07:02:59 -0500
To: Peter Williams <peterw@aurema.com>
Cc: Timothy Miller <miller@techsource.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <fa.fi4j08o.17nchps@ifi.uio.no> <fa.ctat17m.8mqa3c@ifi.uio.no>
From: Joachim B Haga <c.j.b.haga@fys.uio.no>
Date: 29 Feb 2004 12:58:14 +0100
In-Reply-To: <fa.ctat17m.8mqa3c@ifi.uio.no>
Message-ID: <yydjishqw10p.fsf@galizur.uio.no>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams <peterw@aurema.com> writes:

>>> They already do e.g. renice is such a program.
>> No one's talking about LOWERING priority here.  You can only DoS
>> someone else if you can set negative nice values, and non-root
>> can't do that.
> 
> Which is why root has to be in control of the mechanism.

It seems to me that much of this could be solved if the user *were*
allowed to lower nice values (down to 0).

Right now the only way I can prioritize between my own processes by
starting important/timing sensitive programs normally and everything
else reniced. The problem is that the first category consists of one
or two programs while the second category is, well, "everything else".

I would *love* to be able to start the window manager and all children
at +10 and be able to adjust priorities, from 0 (important user-level)
to 10 (normal) to 20. Negative values could still be root-only.

So why shouldn't this be possible? Because a greedy user in a
multi-user system would just run everything at max prio thus defeating
the purpose? Sure, that would be annoying but it would have another
solution ie. an entitlement based scheduler or something.


(and isn't it this simple?)

--- linux-2.6.3-mm3/kernel/sys.c.orig   2004-02-29 12:58:45.000000000 +0100
+++ linux-2.6.3-mm3/kernel/sys.c        2004-02-29 12:59:20.000000000 +0100
@@ -276,7 +276,7 @@
                error = -EPERM;
                goto out;
        }
-       if (niceval < task_nice(p) && !capable(CAP_SYS_NICE)) {
+       if (niceval < 0 && !capable(CAP_SYS_NICE)) {
                error = -EACCES;
                goto out;
        }


Regards,
Joachim B Haga
