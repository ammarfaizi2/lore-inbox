Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbUCLP2A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 10:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbUCLP2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 10:28:00 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:772 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S262191AbUCLP17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 10:27:59 -0500
Date: Fri, 12 Mar 2004 18:27:54 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Marc Giger <gigerstyle@gmx.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4 on Alpha uninterruptible sleep of processes
Message-ID: <20040312182754.A680@jurassic.park.msu.ru>
References: <20040312154613.7567adab@hdg.gigerstyle.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040312154613.7567adab@hdg.gigerstyle.ch>; from gigerstyle@gmx.ch on Fri, Mar 12, 2004 at 03:46:13PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 03:46:13PM +0100, Marc Giger wrote:
> After some time, new started processes are in a uninterruptible
> sleep state. It seems every process that opens a file hangs.
> E.g. I can't tail -f /var/log/messages

My fault. There was a typo in the semaphore patch.
Does this work for you?

Ivan.

--- 2.6.4/arch/alpha/kernel/semaphore.c	Thu Mar 11 05:55:27 2004
+++ linux/arch/alpha/kernel/semaphore.c	Fri Mar 12 18:17:24 2004
@@ -29,7 +29,7 @@ static inline int __sem_update_count(str
 
 	__asm__ __volatile__(
 	"1:	ldl_l	%0,%2\n"
-	"	cmovgt	%0,%0,%1\n"
+	"	cmovgt	%0,0,%1\n"
 	"	addl	%1,%3,%1\n"
 	"	stl_c	%1,%2\n"
 	"	beq	%1,2f\n"
