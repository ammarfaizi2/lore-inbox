Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268324AbTCFTy6>; Thu, 6 Mar 2003 14:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268325AbTCFTy6>; Thu, 6 Mar 2003 14:54:58 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:13577
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S268324AbTCFTy5>; Thu, 6 Mar 2003 14:54:57 -0500
Subject: Re: Inconsistency in changing the state of task ??
From: Robert Love <rml@tech9.net>
To: prash_t@softhome.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <courier.3E674902.000007D9@softhome.net>
References: <courier.3E646584.000059D3@softhome.net>
	 <1046800283.999.59.camel@phantasy.awol.org>
	 <courier.3E674902.000007D9@softhome.net>
Content-Type: text/plain
Organization: 
Message-Id: <1046981138.684.7.camel@phantasy.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 06 Mar 2003 15:05:39 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-06 at 08:11, prash_t@softhome.net wrote:

> Thanks Robert for the reply.
> But I notice that __set_current_state() is same as current->state. So, I 
> didn't understand the safety factor on using __set_current_state( ). 

There is no safety with __set_current_state().  It is just an
abstraction.

The safety comes from set_current_state(), which ensures memory
ordering.

This is an issue not just on SMP, but on a weakly ordered processor like
Alpha.

> Also why should I use __set_current_state() instead of set_current_state() 
> when the later is SMP safe.

You only use __set_current_state() if you know you do not need to ensure
memory ordering constraints.

	Robert Love

