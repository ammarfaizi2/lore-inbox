Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318918AbSHWQsM>; Fri, 23 Aug 2002 12:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318946AbSHWQsM>; Fri, 23 Aug 2002 12:48:12 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:39952
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S318918AbSHWQsM>; Fri, 23 Aug 2002 12:48:12 -0400
Subject: Re: interrupt handler
From: Robert Love <rml@tech9.net>
To: root@chaos.analogic.com
Cc: sanket rathi <sanket@linuxmail.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1020823123854.2797A-100000@chaos.analogic.com>
References: <Pine.LNX.3.95.1020823123854.2797A-100000@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 23 Aug 2002 12:52:20 -0400
Message-Id: <1030121541.1935.3684.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-23 at 12:45, Richard B. Johnson wrote:

> On 23 Aug 2002, Robert Love wrote:
> > Only the current interrupt handler is disabled... interrupts are
> > normally ON.
> 
> No. Check out irq.c, line 446. The interrupts are turned back on
> only if the flag did not have SA_INTERRUPT set. Certainly most
> requests for interrupt services within drivers have SA_INTERRUPT
> set.

Sigh... SA_INTERRUPT is used only for fast interrupts.  Certainly most
drivers do not have it (and most that do are probably from the way old
days when we went through great pains to distinguish between fast and
slow interrupt handlers).

Today, very few things should run with all interrupts disabled.  That is
just dumb.  In fact, on this system, it seems only the timer interrupt
sets SA_INTERRUPT...

	Robert Love

