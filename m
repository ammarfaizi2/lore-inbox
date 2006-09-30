Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWI3IgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWI3IgR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 04:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWI3IgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 04:36:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43935 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750755AbWI3IgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 04:36:13 -0400
Date: Sat, 30 Sep 2006 01:35:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch 00/23]
Message-Id: <20060930013549.a489fbb1.akpm@osdl.org>
In-Reply-To: <20060929234435.330586000@cruncher.tec.linutronix.de>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


General readability comment.  This:

enum hrtimer_mode {
	HRTIMER_ABS,	/* Time value is absolute */
	HRTIMER_REL,	/* Time value is relative to now */
};

enum hrtimer_restart {
	HRTIMER_NORESTART,
	HRTIMER_RESTART,
};


#define HRTIMER_INACTIVE	0x00
#define HRTIMER_ACTIVE		0x01
#define HRTIMER_CALLBACK	0x02
#define HRTIMER_PENDING		0x04


is quite bad.  They enumerate different conceptual things but they are all
in the sane namespace.  The reader sees code which is using a mixture of
HRTIMER_ABS, HRTIMER_RESTART and HRTIMER_ACTIVE and gets needlessly
confused over what they all signify.  

This:

enum hrtimer_cb_mode {
	HRTIMER_CB_SOFTIRQ,
	HRTIMER_CB_IRQSAFE,
	HRTIMER_CB_IRQSAFE_NO_RESTART,
	HRTIMER_CB_IRQSAFE_NO_SOFTIRQ,
};

is better.
