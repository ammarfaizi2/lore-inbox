Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262386AbVBCUqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbVBCUqm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 15:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263477AbVBCUqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 15:46:42 -0500
Received: from RT-soft-2.Moscow.itn.ru ([80.240.96.70]:51922 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S263158AbVBCUq3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 15:46:29 -0500
Message-ID: <42028F4D.2040708@ru.mvista.com>
Date: Thu, 03 Feb 2005 23:53:33 +0300
From: "Eugeny S. Mints" <emints@ru.mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc2-V0.7.37-02
References: <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu> <20041214132834.GA32390@elte.hu> <20050104064013.GA19528@nietzsche.lynx.com> <20050104094518.GA13868@elte.hu> <20050115133454.GA8748@elte.hu> <20050122122915.GA7098@elte.hu> <20050201201402.GA31930@elte.hu>
In-Reply-To: <20050201201402.GA31930@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------030905040608030006070203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030905040608030006070203
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> i have released the -V0.7.37-02 Real-Time Preemption patch, which can be
> downloaded from the usual place:
> 
>   http://redhat.com/~mingo/realtime-preempt/
Minor fix for deadlock tracer: "...acquired at XXX"  may print  caller's 
of an up() eip instead of eip of caller of a down() in case a lock was 
initally contended before deadlock is detected.

Seems actual for 37-03 as well. pathc is attached.
	
			Eugeny


--------------030905040608030006070203
Content-Type: text/plain;
 name="deadlock_trace_minor_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="deadlock_trace_minor_fix.patch"

--- rt.c.orig	2005-02-03 23:35:42.000000000 +0300
+++ rt.c	2005-02-03 23:35:58.000000000 +0300
@@ -734,7 +734,7 @@
 
 	list_del_init(&waiter->pi_list);
 
-	set_new_owner(lock, old_owner, new_owner, eip);
+	set_new_owner(lock, old_owner, new_owner, waiter->eip);
 	/* Don't touch waiter after ->task has been NULLed */
 	mb();
 	waiter->task = NULL;

--------------030905040608030006070203--

