Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263310AbSKDCzU>; Sun, 3 Nov 2002 21:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263326AbSKDCzU>; Sun, 3 Nov 2002 21:55:20 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:30737
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263310AbSKDCzT>; Sun, 3 Nov 2002 21:55:19 -0500
Subject: Re: interrupt checks for spinlocks
From: Robert Love <rml@tech9.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20021104014224.GR23425@holomorphy.com>
References: <mailman.1036362421.16883.linux-kernel2news@redhat.com>
	<200211040028.gA40S8600593@devserv.devel.redhat.com>
	<20021104002813.GZ16347@holomorphy.com>
	<20021103194249.A1603@devserv.devel.redhat.com>
	<20021104005339.GA16347@holomorphy.com> <1036372685.752.7.camel@phantasy> 
	<20021104014224.GR23425@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Nov 2002 22:01:24 -0500
Message-Id: <1036378887.750.96.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-03 at 20:42, William Lee Irwin III wrote:

> I'll go figure out why before posting a follow-up. This is not doing
> what I wanted it to because the only one I originally wanted was (1),
> having to do with interrupt-time recursion on rwlocks and writer
> starvation caused by it.

You can do #1, but you need to figure out if your interrupt is the only
interrupt using the lock or not (possibly hard).

In other words, a lock unique to your interrupt handler does not need to
disable interrupts (since only that handler can grab the lock and it is
disabled).

If other handlers can grab the lock, interrupts need to be disabled.

So a test of irqs_disabled() would show a false-positive in the first
case.  No easy way to tell..

	Robert Love

