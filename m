Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267372AbUH3LvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267372AbUH3LvG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 07:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267737AbUH3LvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 07:51:06 -0400
Received: from purplechoc.demon.co.uk ([80.176.224.106]:3200 "EHLO
	skeleton-jack.localnet") by vger.kernel.org with ESMTP
	id S267372AbUH3LvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 07:51:02 -0400
Date: Mon, 30 Aug 2004 12:50:59 +0100
To: linux-kernel@vger.kernel.org
Subject: PS/2 mouse driver panics during boot - 2.6.8.1
Message-ID: <20040830115059.GA8907@skeleton-jack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
From: Peter Horton <pdh@colonel-panic.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every other time I boot my x86 box the kernel panics in
psmouse_interrupt() because ->protocol_handler is NULL. Looks like
psmouse_connect() runs before ->protocol_handler is set and generates an
interrupt from the mouse. The mouse driver is built in, and I'm not
passing it any parameters.

This is a Micro$oft Wireless Optical Mouse 2.0A.

The call stack is something like this

	psmouse_interrupt
	serio_interrupt
	i8042_interrupt
	handle_IRQ_event
	do_IRQ
	common_interrupt
	__do_softirq
	do_softirq
	do_IRQ
	common_interrupt
	i8042_command
	i8042_activate_port
	i8042_open
	i8042_interrupt
	serio_open
	psmouse_connect
	serio_find_dev
	serio_register_port
	i8042_port_register
	i8042_init
	serio_init

P.
