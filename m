Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263207AbTJKByN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 21:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263209AbTJKByN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 21:54:13 -0400
Received: from jdavies.dsl.xmission.com ([166.70.25.250]:51757 "EHLO
	smtp.millcreeksys.com") by vger.kernel.org with ESMTP
	id S263207AbTJKByL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 21:54:11 -0400
Message-ID: <1065837246.3f8762bedd4db@secure.millcreeksys.com>
Date: Fri, 10 Oct 2003 19:54:06 -0600
From: Michael Jensen <kernel@millcreeksys.com>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.7 "thoughts"] V0.3
References: <D9B4591FDBACD411B01E00508BB33C1B01F24E98@mesadm.epl.prov-liege.be> <1065820650.3f8721ea4162b@secure.millcreeksys.com> <200310102205.h9AM5lRX007520@turing-police.cc.vt.edu>            <1065825189.3f8733a55cfd4@secure.millcreeksys.com> <200310102313.h9ANDtRX009446@turing-police.cc.vt.edu>
In-Reply-To: <200310102313.h9ANDtRX009446@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 12.254.174.58
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for setting me straight.  For some reason I thought that whenever a
binary was executed (even through a buffer overflow), an exec() was issued.

Don't ask what I've been smoking...





Quoting Valdis.Kletnieks@vt.edu:

> On Fri, 10 Oct 2003 16:33:09 MDT, Michael Jensen said:
> 
> > I agree that it wouldn't have any effect on buffer overflows.  It would
> prevent
> > further abuse of the system unless the perpetrator was able to install and
> load
> > a modified kernel.  Even if they had root access, they would be unable to
> > execute backdoor binaries because they would not be signed with a trusted
> key. 
> > This would also thwart rootkits.
> 
> Umm... let me see if I got this straight...  They already exploited the
> system once
> to get in originally, and you think that the same method that didn't stop
> them
> from executing code to get in will also stop them from exploiting further?
> 
> All they need to do is park their code-to-execute in a file *anywhere* on the
> box,
> and then invoke any of the numerous programs that have local buffer
> overflows,
> and then use that program and an overflow sled to act as a poor-man's
> replacement
> for /lib/ld-linux.
> 
> Hmm.. /bin/ls segfaults under some overflow conditions?  Just set up the
> conditions, run /bin/ls, get the signed binary to run, and use it to load
> your
> code. Game over. /bin/ls isn't exploitable?  Wander over to packetstorm and
> pick and choose a ready-made exploit for lots of other stuff..
> 
> The basic problem here is that you're assuming that "the code loaded by
> exec()"
> is trusted, therefor the code actually executed is trusted.  Given that most
> modern
> processors are Von Neumann architectures rather than Harvard machines, that's
> a
> problematic assumption.  That's why things like exec-shield or SELinux are
> probably
> more productive directions - they are taking a different model:
> 
> exec-shield - We don't care if you're a trusted program, you're not executing
> off the stack.
> 
> SELinux - We don't care what binary you are, if you started in this security
> domain,
> you're staying in it and having the restrictions enforced (yes, I know I'm
> simplifying
> the issues with 'newrole' and the like)...
