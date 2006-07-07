Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbWGGFHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbWGGFHe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 01:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWGGFHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 01:07:33 -0400
Received: from mail.gmx.de ([213.165.64.21]:33447 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751025AbWGGFHd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 01:07:33 -0400
Cc: mtk-manpages@gmx.net, mtk-lkml@gmx.net, rlove@rlove.org, roland@redhat.com,
       eggert@cs.ucla.edu, torvalds@osdl.org, tytso@mit.edu,
       linux-kernel@vger.kernel.org, manfred@colorfullife.com
Content-Type: text/plain; charset="utf-8"
Date: Fri, 07 Jul 2006 07:07:31 +0200
From: "Michael Kerrisk" <michael.kerrisk@gmx.net>
In-Reply-To: <44ADE9B6.1020900@redhat.com>
Message-ID: <20060707050731.186770@gmx.net>
MIME-Version: 1.0
References: <44A92DC8.9000401@gmx.net> <44AABB31.8060605@colorfullife.com>
 <20060706092328.320300@gmx.net> <44AD599D.70803@colorfullife.com>
 <44AD5CB6.7000607@redhat.com> <20060707043220.186800@gmx.net>
 <44ADE9B6.1020900@redhat.com>
Subject: Re: Re: Strange Linux behaviour with blocking syscalls and stop
 signals+SIGCONT
To: Ulrich Drepper <drepper@redhat.com>
X-Authenticated: #2864774
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Von: Ulrich Drepper <drepper@redhat.com>

> sem_wait() is another case.  Here the EINTR handling is exposed to the
> programmer.  Currently, as I understand it, even SA_RESTART handlers
> cause EINTR to be returned.  

Yes, this is true for sem_wait().

> Yes, this usually correct but it  might
> disrupt existing code.
> 
> This is why I'd caution anybody who thinks about changing something in
> this area.  *I* could live with it, I can fix and recompile all the code
> I use.  But others aren't that lucky.

Yes; this is why I'm only proposing to change EINTR to ERESTARTNOHAND
at the moment.  The only userspace visible change that I think
this will bring about is in the stop+SIGCONT case.  Changing EINTR
to ERESTARTSYS is likely to have more impact on userland (though 
it still strikes me as a desirable gola to have all system calls 
restartable via SA_RESTART).

Cheers,

Michael
-- 


"Feel free" – 10 GB Mailbox, 100 FreeSMS/Monat ...
Jetzt GMX TopMail testen: http://www.gmx.net/de/go/topmail
