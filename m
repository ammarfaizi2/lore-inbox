Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbWA3Pjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWA3Pjv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 10:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWA3Pju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 10:39:50 -0500
Received: from mba.ocn.ne.jp ([210.190.142.172]:6113 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S932294AbWA3Pju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 10:39:50 -0500
Date: Tue, 31 Jan 2006 00:39:27 +0900 (JST)
Message-Id: <20060131.003927.112625901.anemo@mba.ocn.ne.jp>
To: gdavis@mvista.com
Cc: rmk+serial@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: Add spin_lock_init() in 8250
 early_serial_setup() to init port.lock
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060126032403.GG5133@mvista.com>
References: <20060126032403.GG5133@mvista.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 25 Jan 2006 22:24:03 -0500, "George G. Davis" <gdavis@mvista.com> said:

gdavis> Need spin_lock_init(&serial8250_ports[port->line].port.lock)
gdavis> in early_serial_setup() since we're copying struct uart_port
gdavis> *port into serial8250_ports[port->line].port and *port.lock is
gdavis> typically unitiliased by the caller.

Is this really needed?   The port.lock will be initialized in
uart_set_options() or uart_add_one_port().

I think spin_lock_init() in serial8250_isa_init_ports() can be omitted
also.

---
Atsushi Nemoto
