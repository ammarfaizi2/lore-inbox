Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267170AbUFZOd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267170AbUFZOd1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 10:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267171AbUFZOd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 10:33:27 -0400
Received: from web50607.mail.yahoo.com ([206.190.38.94]:28087 "HELO
	web50607.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267170AbUFZOd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 10:33:26 -0400
Message-ID: <20040626143326.50865.qmail@web50607.mail.yahoo.com>
Date: Sat, 26 Jun 2004 07:33:26 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: 2.6.x signal handler bug
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I looked at the test program and do not see anything wrong with the code.
Contrary to what's already been said in this thread, sigsetjmp/siglongjmp only
differ in that they restore the signal context. This should never cause a
segfault. 

Regarding re-entrancy, longjmp is stated as one of only 2 ways to exit signal
handlers. Also, while the printf is not signal safe, it is not your problem
either. BTW, this mechanism is used by some servers to prevent crashes even in
the face of big problems. xinetd for one does this...so its important to have
working.

I ran the test program on my machine under 2.4 and all works as expected. Under
2.6, it definitely segfaults. I tried using Electric Fence and valgrind to trap
the error. Neither one could.

In summary, the program is valid and real world servers do this kind of thing. It
does segfault under 2.6.

Hope this helps...
-Steve Grubb

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
