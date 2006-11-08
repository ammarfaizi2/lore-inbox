Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753393AbWKHBgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753393AbWKHBgO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 20:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753827AbWKHBgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 20:36:14 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:30463 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1753393AbWKHBgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 20:36:13 -0500
Message-ID: <4551348B.6070604@mvista.com>
Date: Tue, 07 Nov 2006 17:36:11 -0800
From: Kevin Hilman <khilman@mvista.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: 2.6.18-rt7: rollover with 32-bit cycles_t
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On ARM, I'm noticing the 'bug' message from check_critical_timing()
where two calls to get_cycles() are compared and the 2nd is assumed to
be >= the first.

This isn't properly handling the case of rollover which occurs
relatively often with fast hardware clocks and 32-bit cycle counters.

Is this really a bug?  If the get_cycles() can be assumed to run between
0 and (cycles_t)~0, using the right unsigned math could get a proper
delta even in the rollover case.  Is this a safe assumption?

Kevin





