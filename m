Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVEPNnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVEPNnu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 09:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbVEPNnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 09:43:50 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:64703 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261563AbVEPNnt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 09:43:49 -0400
Message-ID: <4288A55B.10F7240E@tv-sign.ru>
Date: Mon, 16 May 2005 17:51:23 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] improve SMP reschedule and idle routines
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
>
>  void default_idle(void)
>  {
> +	local_irq_enable();
> +

Stupid question. Why is this sti() needed?

Interrupts are enabled in start_secondary() before cpu_idle()
call, and they can't be disabled after return from schedule().

The same question applies to poll_idle/mwait_idle.

Oleg.
