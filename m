Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267246AbSLSWlq>; Thu, 19 Dec 2002 17:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267218AbSLSWlp>; Thu, 19 Dec 2002 17:41:45 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:33551
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267374AbSLSWiS>; Thu, 19 Dec 2002 17:38:18 -0500
Subject: Re: [BENCHMARK] scheduler tunables with contest - prio_bonus_ratio
From: Robert Love <rml@tech9.net>
To: Con Kolivas <conman@kolivas.net>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200212200850.32886.conman@kolivas.net>
References: <200212200850.32886.conman@kolivas.net>
Content-Type: text/plain
Organization: 
Message-Id: <1040337982.2519.45.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 19 Dec 2002 17:46:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-19 at 16:50, Con Kolivas wrote:

> Changing this tunable seems to shift the balance in either direction depending 
> on the load. Most of the disk writing loads have shorter times as pb goes up, 
> but under heavy mem_load the time goes up (without an increase in the amount 
> of work done by the mem_load itself). The effect is quite large.

This is one of the most interesting tests.  Thanks, Con.

prio_bonus_ratio determines how big a bonus we give to interactive
tasks, as a percentage of the full -20 to +19 nice range.  Setting it to
zero means we scale the bonuses/penalties be zero percent, i.e. we do
not give a bonus or penalty.  25% implies 25% of the range is used (i.e.
-/+5 points).  Etc.

I suspect tests where you see an improvement as the value increases are
ones in which the test is more interactive than the background load.  In
that case, the larger bonuses helps more so to the test and it completes
quicker.

When you see a decrease associated with a larger value, the test is less
interactive than the load.  Thus the load is scheduled to the detriment
of the test, and the test takes longer to complete.

Not too sure what to make of it.  It shows the interactivity estimator
does indeed help... but only if what you consider "important" is what is
considered "interactive" by the estimator.  Andrew will say that is too
often not the case.

	Robert Love

P.S. This setting is also useful for endusers to test.  Setting
prio_bonus_ratio to zero effectively disables the interactivity
estimator, so users can test without that feature enabled.  It should
fix e.g. Andrew's X wiggle issue.

