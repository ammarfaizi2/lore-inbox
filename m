Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319290AbSH2SfF>; Thu, 29 Aug 2002 14:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319291AbSH2SfE>; Thu, 29 Aug 2002 14:35:04 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:40719
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S319290AbSH2SfE>; Thu, 29 Aug 2002 14:35:04 -0400
Subject: Re: [PATCH] misc. kernel preemption bits
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0208291136180.2316-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0208291136180.2316-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 29 Aug 2002 14:39:25 -0400
Message-Id: <1030646366.979.2573.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-29 at 14:38, Linus Torvalds wrote:

> I think we should return silently, and simply consider the case of
> disabled local interrupts to be equivalent to having preemption disabled.
> 
> So I would remove even the warning.
> 
> Comments?

This is a tough question.

I originally did just that but Ingo said we should aim to find the
problem areas, too.  The issue is, for 99% of the cases, disabling
interrupts really is equivalent to disabling preemption (e.g.
preempt_schedule() is never called).  For the remaining 1% of the cases,
it is possible to fix up the problems by playing safely with interrupts
off.

We _must_ return since we are seeing these in the wild.  If we want to
leave the debug checking to try to "fix" the remaining cases we can do
so too.

How about this: add the return now (i.e. accept the patch as-is) and
keep the debug check so we can continue to find areas that cause
incorrect preemptions.  Before 2.6, I will send a patch to remove the
check and just return silently.

Sound good?

	Robert Love

