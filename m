Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262800AbSJJA7m>; Wed, 9 Oct 2002 20:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262805AbSJJA7m>; Wed, 9 Oct 2002 20:59:42 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:54532
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262800AbSJJA7l>; Wed, 9 Oct 2002 20:59:41 -0400
Subject: Re: [PATCH] set_cpus_allowed() atomicity fix
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0210091615540.9234-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0210091615540.9234-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 09 Oct 2002 21:05:17 -0400
Message-Id: <1034211918.753.340.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-09 at 19:17, Linus Torvalds wrote:

> On 9 Oct 2002, Robert Love wrote:
> > 
> > Anyhow, attached patch fixes the atomicity debugging error.
> 
> I don't think this is right. You have to be preempt safe over the whole 
> time you're holding the "rq" pointer, I think. Otherwise you might move to 
> another CPU, at which point the rq state isn't valid any more. Or maybe I 
> misunderstood.

I agree.  But aren't we?

We are preempt-safe through the entire function (starting at the top
with task_rq_lock()) until the preempt_disable().  The only instruction
outside of the critical section is the wait_for_completion() which
sleeps anyhow.

Or maybe _I_ misunderstood?

	Robert Love

