Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751440AbWEDIZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbWEDIZp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 04:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWEDIZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 04:25:45 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:46799 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751440AbWEDIZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 04:25:44 -0400
Date: Thu, 4 May 2006 10:30:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] futex-pi: fix possible pi_lock deadlock
Message-ID: <20060504083040.GA29469@elte.hu>
References: <1146730854.27820.157.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146730854.27820.157.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> From: Ingo Molnar <mingo@elte.hu>
> 
> The lock validator detected a possible deadlock between tasklist lock 
> and task->pi_lock. Prevent the deadlock by disabling interrupts across 
> pi_lock operations.

some background about how this bug sneaked in: we have pi_lock as an 
irq-safe lock in the -rt tree but we didnt realize that it was needed in 
the pi-futex implementation too. The race window is pretty narrow there 
so it didnt trigger during testing. (the window is wider in -rt)

	Ingo
