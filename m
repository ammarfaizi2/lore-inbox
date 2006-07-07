Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWGGEcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWGGEcW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 00:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbWGGEcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 00:32:22 -0400
Received: from mail.gmx.de ([213.165.64.21]:35757 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750872AbWGGEcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 00:32:22 -0400
Cc: linux-kernel@vger.kernel.org, tytso@mit.edu, torvalds@osdl.org,
       paire@ri.silicomp.fr, eggert@cs.ucla.edu, roland@redhat.com,
       rlove@rlove.org, mtk-lkml@gmx.net, mtk-manpages@gmx.net
Content-Type: text/plain; charset="utf-8"
Date: Fri, 07 Jul 2006 06:32:20 +0200
From: "Michael Kerrisk" <michael.kerrisk@gmx.net>
In-Reply-To: <44AD5CB6.7000607@redhat.com>
Message-ID: <20060707043220.186800@gmx.net>
MIME-Version: 1.0
References: <44A92DC8.9000401@gmx.net> <44AABB31.8060605@colorfullife.com>
 <20060706092328.320300@gmx.net> <44AD599D.70803@colorfullife.com>
 <44AD5CB6.7000607@redhat.com>
Subject: Re: Re: Strange Linux behaviour with blocking syscalls and stop
 signals+SIGCONT
To: Ulrich Drepper <drepper@redhat.com>, manfred@colorfullife.com
X-Authenticated: #2864774
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Von: Ulrich Drepper <drepper@redhat.com>

> Manfred Spraul wrote:
> > 1) I would go further and try ERESTARTSYS: ERESTARTSYS means that the
> > kernel signal handler honors SA_RESTART
> > 2) At least for the futex functions, it won't be as easy as replacing
> > EINTR wiht ERESTARTSYS: the futex functions receive a timeout a the
> > parameter, with the duration of the wait call as a parameter. You must
> > use ERESTART_RESTARTBLOCK.
> 
> Whoa, not so fast.  At least the futex syscall but be interruptible by
> signals.  It is crucial to return EINTR.

When you say "return" do you mean "in kernel", or "return 
to userspace"?  My (possibly naive) understanding is that
one could simply s/EINTR/ERESTARTNOHAND/ for FUTEX_WAIT, in
order to achieve the change I want: for userland that 
ERESTARTNOHAND would be returned as EINTR if a signal 
handler interrupted the FUTEX_WAIT.

Cheers,

Michael
-- 


"Feel free" – 10 GB Mailbox, 100 FreeSMS/Monat ...
Jetzt GMX TopMail testen: http://www.gmx.net/de/go/topmail
