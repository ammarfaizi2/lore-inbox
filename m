Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262676AbUKENQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262676AbUKENQJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 08:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262684AbUKENQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 08:16:09 -0500
Received: from canuck.infradead.org ([205.233.218.70]:4614 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262676AbUKENJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 08:09:22 -0500
Subject: [PATCH] Correctly flush 8250 buffers, notify ldisc of line status
	changes.
From: David Woodhouse <dwmw2@infradead.org>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 05 Nov 2004 13:06:37 +0000
Message-Id: <1099659997.20469.71.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We weren't flushing the TX FIFO on 8250 uarts when uart_flush_buffer()
was called. This adds a flush_buffer() method to the uart_port
operations and calls it from uart_flush_buffer().

This also adds a method to the line discipline which is called upon line
status changes, and uses the helper function for that to clean up the
uart hardware drivers slightly, removing the explicit wakeup on
delta_msr_wait which is used for TIOCMIWAIT.

I'll be putting together a line discipline which actually needs this
callback shortly.

-- 
dwmw2

