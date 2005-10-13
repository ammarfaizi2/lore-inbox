Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751548AbVJMIll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbVJMIll (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 04:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751540AbVJMIlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 04:41:40 -0400
Received: from mail.gmx.net ([213.165.64.21]:15844 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751149AbVJMIlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 04:41:40 -0400
Date: Thu, 13 Oct 2005 10:41:38 +0200 (MEST)
From: "Michael Kerrisk" <mtk-lkml@gmx.net>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: dan@debian.org, roland@redhat.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net
MIME-Version: 1.0
References: <434D48FA.FD0439AA@tv-sign.ru>
Subject: Re: Process with many NPTL threads terminates slowly on core dump signal
X-Priority: 3 (Normal)
X-Authenticated: #23581172
Message-ID: <18436.1129192898@www29.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Von: Oleg Nesterov <oleg@tv-sign.ru>
> Datum: Wed, 12 Oct 2005 21:33:46 +0400
> 
> Michael Kerrisk wrote:
> >
> > Following up (belatedly) from my earlier message, I took Daniel 
> > Jacobowitz's suggestion to investigate the result from booting 
> > with "profile=2".  When running my program (shwon below) on 
> > 2.6.14-rc4 to create 100 threads, and sending a core dump signal, 
> > the program takes 90 seconds to terminate, and readprofile shows 
> > the following:
> 
> I think the coredumping code in __group_complete_signal() is bogus
> and what happens is:

[...]

> TIF_SIGPENDING is not cleared, so get_signal_to_deliver() will be
> called again on return to userspace. When all threads will eat their
> ->time_slice, P will return from yield() and kill all threads.

Thanks for investiagting this further.

> Could you try this patch (added to mm tree):
> 	http://marc.theaimsgroup.com/?l=linux-kernel&m=112887453531139
> ? It does not solve the whole problem, but may help.
>
> Please report the result, if possible.

Thanks.  I've applied it to 2.6.14-rc4: this patch does fix the 
specific behaviour that my program demonstrates.  

What remains to be solved?

Cheers,

Michael

-- 
10 GB Mailbox, 100 FreeSMS/Monat http://www.gmx.net/de/go/topmail
+++ GMX - die erste Adresse für Mail, Message, More +++
