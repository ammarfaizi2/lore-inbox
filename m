Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269083AbUJEQvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269083AbUJEQvV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 12:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269116AbUJEQvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 12:51:00 -0400
Received: from siaag1ag.compuserve.com ([149.174.40.13]:6227 "EHLO
	siaag1ag.compuserve.com") by vger.kernel.org with ESMTP
	id S269083AbUJEQto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 12:49:44 -0400
Date: Tue, 5 Oct 2004 12:46:34 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [Patch] new serial flow control
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Message-ID: <200410051249_MC3-1-8B8B-5504@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samual Thibault wrote:

>+      } else if (info->flags & ASYNC_TVB_FLOW) {
>+              if (status & UART_MSR_CTS) {
>+                      if (!(info->MCR & UART_MCR_RTS)) {
>+                              /* start of TVB frame, raise RTS to greet data */
>+                              info->MCR |= UART_MCR_RTS;
>+                              serial_out(info, UART_MCR, info->MCR);
>+#if (defined(SERIAL_DEBUG_INTR) || defined(SERIAL_DEBUG_FLOW))
>+                              printk("TVB frame start...");
>+#endif
>+                      }
>+              } else {
>+                      if (info->MCR & UART_MCR_RTS) {
>+                              /* CTS went down, lower RTS as well */
>+                              info->MCR &= ~UART_MCR_RTS;
>+                              serial_out(info, UART_MCR, info->MCR);
>+#if (defined(SERIAL_DEBUG_INTR) || defined(SERIAL_DEBUG_FLOW))
>+                              printk("TVB frame started...");
>+#endif
                                                  ^^^^^^^

Shouldn't this be "ended"? ... or "end" since frame begin msg says "start"
i.e. is not past tense?


--Chuck Ebbert
