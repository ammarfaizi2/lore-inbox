Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272280AbTGYUCA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 16:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272281AbTGYUCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 16:02:00 -0400
Received: from newweb.speedscript.com ([66.139.78.154]:52382 "EHLO
	mail.speedscript.com") by vger.kernel.org with ESMTP
	id S272280AbTGYUB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 16:01:59 -0400
Subject: Possible sparc64 signal handling issue
From: Hal Duston <hduston@speedscript.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1059164229.3926.16.camel@ulysseus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 25 Jul 2003 15:17:10 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In arch/sparc64/kernel/traps.c, data_access_exception() is defined to
receive 3 parameters, (and uses all three of them).  In
arch/sparc64/kernel/unaligned.c it is only passed a single parameter.  

This is causing me difficulty when handling segfault signals.  On most
Linux platforms I have access to the siginfo_t.si_addr isn't populated
at all anyway, and I use the ucontext_t third parameter given to the
handler.  Under sparc64 though, the third parameter doesn't point to
anything that I can discern, and due to the aforementioned three versus
one parameter issue, the value of si_addr in siginfo_t is incorrect as
well.

This issue appears to be present in both 2.4, and 2.6.

--
Hal Duston
hduston@speedscript.com

