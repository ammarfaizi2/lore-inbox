Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269446AbTCDRkx>; Tue, 4 Mar 2003 12:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269447AbTCDRkx>; Tue, 4 Mar 2003 12:40:53 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:18192
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S269446AbTCDRkw>; Tue, 4 Mar 2003 12:40:52 -0500
Subject: Re: Inconsistency in changing the state of task ??
From: Robert Love <rml@tech9.net>
To: prash_t@softhome.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <courier.3E646584.000059D3@softhome.net>
References: <courier.3E646584.000059D3@softhome.net>
Content-Type: text/plain
Organization: 
Message-Id: <1046800283.999.59.camel@phantasy.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 04 Mar 2003 12:51:23 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-04 at 03:36, prash_t@softhome.net wrote:

>      while browsing through fs/select.c file of 2.4.19, I came across two 
> DIFFERENT ways of changing the state of the current task in do_select(): 
> 
>             set_current_state = TASK_INTERRUPTIBLE;
>      AND    current->state = TASK_RUNNING; 
> 
> I am curious to know if the second line of code doesn't cause any problem in 
> SMP systems.  I also see the same situation in do_poll().

You normally want to use set_current_state(), which is a nice
abstraction and safe for SMP.

Sometimes it is safe to use __set_current_state(), which does not
provide a memory barrier.

The above open-coded line can be changed to
__set_current_state(TASK_RUNNING).

	Robert Love

