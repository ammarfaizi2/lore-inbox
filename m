Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263483AbTC2WA0>; Sat, 29 Mar 2003 17:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263485AbTC2WA0>; Sat, 29 Mar 2003 17:00:26 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:40200
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263483AbTC2WAY>; Sat, 29 Mar 2003 17:00:24 -0500
Subject: Re: [OOPS][2.5.66bk3+] run_timer_softirq - IRQ Mishandlings
From: Robert Love <rml@tech9.net>
To: Shawn Starr <spstarr@sh0n.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <004201c2f63c$25d4aa00$030aa8c0@unknown>
References: <001c01c2f634$2e517da0$030aa8c0@unknown>
	 <1048972543.13757.3.camel@localhost>
	 <004201c2f63c$25d4aa00$030aa8c0@unknown>
Content-Type: text/plain
Organization: 
Message-Id: <1048975906.13757.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 29 Mar 2003 17:11:47 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-29 at 16:42, Shawn Starr wrote:

> How can I go about debugging this? How can I find the path causing
> the problem?

Begin by finding out where the EIP is.  It should be a spin_lock().  The
oops says it is kernel/timer.c:258.

This line is a double locking of an already-locked lock.  So find where
the initial lock was.  The oops said that is kernel/timer.c:398.

Look at the call chain (from the oops) from the first to the second
lock.  Someone assumed it could not happen.  Obviously they were wrong.

	Robert Love

