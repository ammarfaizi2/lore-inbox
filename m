Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbWIRNVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWIRNVA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 09:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWIRNVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 09:21:00 -0400
Received: from smarthost2.sentex.ca ([205.211.164.50]:29182 "EHLO
	smarthost2.sentex.ca") by vger.kernel.org with ESMTP
	id S1750726AbWIRNU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 09:20:59 -0400
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "'Andi Kleen'" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: TCP stack behaviour question
Date: Mon, 18 Sep 2006 09:20:44 -0400
Organization: Connect Tech Inc.
Message-ID: <000001c6db25$3f778c30$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
In-Reply-To: <p73slip4lyf.fsf@verdi.suse.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: On Behalf Of Andi Kleen

Thanks for replying, I appreciate it.

> Stevens is a good reference to BSD networking, but not 
> necessarily to Linux.

Which is why I posted here. I was wondering about the specific
implementation.

What happened was this: I had a run where I captured output with
tcpdump. My original post was based on that, and the results of the
debug output from my app. For whatever reason, it appears the stack
didn't generate all of the packets it should have. When the log showed
a second-last to last retransmit time of about 27 seconds, and then a
gap of about 400 to the very next packet of any kind, I assumed that
meant the stack had given up on the retransmits when it appears
something else was going on.

I did some digging into the kernel and on the next run found that all
the expected retransmit packets were being generated, and that once
the stack gives up on the retransmits then system calls return errors.

> > Question 2a: How can my app find out the EHOSTUNREACH error
> > immediately? IP_RECVERR is not implemented on TCP, and 
> SO_ERROR always
> > reports no error (0).
> 
> Did you really read the manpages?  It is implemented and it's 
> documented.

Yes I did and no it's not, according to the man page. I quoth:
# man 7 ip
..
               Note that TCP has no error queue; MSG_ERRQUEUE is
illegal on SOCK_STREAM sockets.  Thus all errors are returned by
socket function return or SO_ERROR only.

Maybe the man page is wrong? That's from my FC 3 install.

..Stu

