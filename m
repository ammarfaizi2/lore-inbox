Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbUCIKYi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 05:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbUCIKYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 05:24:38 -0500
Received: from mo02.iij4u.or.jp ([210.130.0.19]:8666 "EHLO mo02.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261852AbUCIKYh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 05:24:37 -0500
Date: Tue, 9 Mar 2004 19:24:33 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: linux-kernel@vger.kernel.org
Subject: Add pm function for 8250
Message-Id: <20040309192433.1d7423ca.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I want to add per-port pm function to 8250's serial port.
Doesn't the method exist now?

Yoichi

struct uart_8250_port {
        struct uart_port        port;
        struct timer_list       timer;          /* "no irq" timer */
        struct list_head        list;           /* ports on this IRQ */
        unsigned int            capabilities;   /* port capabilities */
        unsigned short          rev;
        unsigned char           acr;
        unsigned char           ier;
        unsigned char           lcr;
        unsigned char           mcr_mask;       /* mask of user bits */
        unsigned char           mcr_force;      /* mask of forced bits */
        unsigned char           lsr_break_flag;

        /*
         * We provide a per-port pm hook.
         */
        void                    (*pm)(struct uart_port *port,                  <-- here
                                      unsigned int state, unsigned int old);
};
