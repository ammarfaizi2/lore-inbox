Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbUFEVjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbUFEVjR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 17:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbUFEVjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 17:39:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7858 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262020AbUFEVjQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 17:39:16 -0400
Date: Sat, 5 Jun 2004 14:36:49 -0700
From: "David S. Miller" <davem@redhat.com>
To: Andreas Schwab <schwab@suse.de>
Cc: olh@suse.de, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] compat bug in sys_recvmsg, MSG_CMSG_COMPAT check
 missing
Message-Id: <20040605143649.3fd6c22b.davem@redhat.com>
In-Reply-To: <jer7st7lam.fsf@sykes.suse.de>
References: <20040605204334.GA1134@suse.de>
	<20040605140153.6c5945a0.davem@redhat.com>
	<20040605140544.0de4034d.davem@redhat.com>
	<jer7st7lam.fsf@sykes.suse.de>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 05 Jun 2004 23:21:53 +0200
Andreas Schwab <schwab@suse.de> wrote:

> "David S. Miller" <davem@redhat.com> writes:
> 
> > This means also that Olaf's patch is broken, when CONFIG_COMPAT is not
> > set, MSG_CMSG_COMPAT is zero, thus ~MSG_CMSG_COMPAT is the unexpected
> > value all 1's thus breaking the tests for unexpected flags completely.
> 
> ??? Where do you get ~MSG_CMSG_COMPAT from?

Olaf's patch, it said:

-	if (flags & ~(MSG_PEEK|MSG_DONTWAIT|MSG_TRUNC))
+	if (flags & ~(MSG_PEEK|MSG_DONTWAIT|MSG_TRUNC|MSG_CMSG_COMPAT))
