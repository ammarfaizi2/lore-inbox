Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVDGKRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVDGKRx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 06:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbVDGKRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 06:17:53 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:19111 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261347AbVDGKRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 06:17:43 -0400
Subject: Re: 2.6.12-rc2 in_atomic() picks up preempt_disable()
From: Arjan van de Ven <arjan@infradead.org>
To: Keith Owens <kaos@sgi.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <13730.1112868613@kao2.melbourne.sgi.com>
References: <13730.1112868613@kao2.melbourne.sgi.com>
Content-Type: text/plain
Date: Thu, 07 Apr 2005 12:17:37 +0200
Message-Id: <1112869057.6290.36.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-07 at 20:10 +1000, Keith Owens wrote:
> 2.6.12-rc2, with CONFIG_PREEMPT and CONFIG_PREEMPT_DEBUG.  The
> in_atomic() macro thinks that preempt_disable() indicates an atomic
> region so calls to __might_sleep() result in a stack trace.

but you're not allowed to schedule when preempt is disabled!

> preempt_count() returns 1, no soft or hard irqs are running and no
> spinlocks are held.  It looks like there is no way to distinguish
> between the use of preempt_disable() in the lock functions (atomic) and
> preempt_disable() outside the lock functions (do nothing that might
> migrate me).

in what code are you seeing this?


