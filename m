Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269099AbUJERZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269099AbUJERZr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 13:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269104AbUJERZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 13:25:47 -0400
Received: from mailfe07.swip.net ([212.247.154.193]:40173 "EHLO
	mailfe07.swip.net") by vger.kernel.org with ESMTP id S269099AbUJERZ3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 13:25:29 -0400
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
Date: Tue, 5 Oct 2004 19:25:22 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>, sebastien.hinderer@libertysurf.fr
Subject: Re: [Patch] new serial flow control
Message-ID: <20041005172522.GA2264@bouh.is-a-geek.org>
Mail-Followup-To: Chuck Ebbert <76306.1226@compuserve.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Russell King <rmk@arm.linux.org.uk>,
	sebastien.hinderer@libertysurf.fr
References: <200410051249_MC3-1-8B8B-5504@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200410051249_MC3-1-8B8B-5504@compuserve.com>
User-Agent: Mutt/1.5.6i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar 05 oct 2004 à 12:46:34 -0400, Chuck Ebbert a tapoté sur son clavier :
> Samual Thibault wrote:
> 
> >+      } else if (info->flags & ASYNC_TVB_FLOW) {
> >+              if (status & UART_MSR_CTS) {
> >+                      if (!(info->MCR & UART_MCR_RTS)) {
> >+                              /* start of TVB frame, raise RTS to greet data */
> >+                              info->MCR |= UART_MCR_RTS;
> >+                              serial_out(info, UART_MCR, info->MCR);
> >+#if (defined(SERIAL_DEBUG_INTR) || defined(SERIAL_DEBUG_FLOW))
> >+                              printk("TVB frame start...");
> >+#endif
> >+                      }
> >+              } else {
> >+                      if (info->MCR & UART_MCR_RTS) {
> >+                              /* CTS went down, lower RTS as well */
> >+                              info->MCR &= ~UART_MCR_RTS;
> >+                              serial_out(info, UART_MCR, info->MCR);
> >+#if (defined(SERIAL_DEBUG_INTR) || defined(SERIAL_DEBUG_FLOW))
> >+                              printk("TVB frame started...");
> >+#endif
>                                                   ^^^^^^^
> 
> Shouldn't this be "ended"? ... or "end" since frame begin msg says "start"
> i.e. is not past tense?

No: data actually pass _after_ CTS and RTS are lowered back: the flow control
only indicate the beginning of one frame.

Regards,
Samuel Thibault
