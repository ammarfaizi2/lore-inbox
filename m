Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270530AbTGaWwU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 18:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270586AbTGaWwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 18:52:20 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:48110 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S270530AbTGaWwM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 18:52:12 -0400
Subject: Re: linux-2.6.0-test2: Never using pm_idle (CPU wasting power)
From: Robert Love <rml@tech9.net>
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
Cc: Christian Vogel <vogel@skunk.physik.uni-erlangen.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200308010045.08178.roger.larsson@skelleftea.mail.telia.com>
References: <20030731150722.A5938@skunk.physik.uni-erlangen.de>
	 <200308010045.08178.roger.larsson@skelleftea.mail.telia.com>
Content-Type: text/plain
Message-Id: <1059692337.931.325.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-5) 
Date: 31 Jul 2003 15:58:57 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-31 at 15:45, Roger Larsson wrote:

> This smells preemptive kernel, correct?

Doesn't look like anything specific to kernel preemption to me.

But if need_resched() is never zero, the while loop fails, and
schedule() _should_ be reached. So something is fishy here. Looking at
it the other way, however, if schedule() is never called, then
need_resched() will remain non-zero forever. Maybe you mean
need_resched() is never non-zero, i.e., it is always zero?

I think the problem is that there is a race between whatever you are
saying ACPI is doing with pm_idle and the setting of idle. Actually,
that is exactly what you are saying :)

Your fix smells exactly of that. Maybe have APCI set need_resched, so
the loop flips over again?

	Robert Love


