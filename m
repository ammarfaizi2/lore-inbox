Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751442AbWFPPJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbWFPPJd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 11:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWFPPJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 11:09:32 -0400
Received: from lx-ltd.ru ([85.113.143.174]:31690 "EHLO iserver.lx.intercon.ru")
	by vger.kernel.org with ESMTP id S1751442AbWFPPJc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 11:09:32 -0400
From: Sergej Pupykin <ps@lx-ltd.ru>
To: linux-kernel@vger.kernel.org
Subject: High CPU load and reading from usb intr bulk
Date: Fri, 16 Jun 2006 19:09:30 +0400
Message-ID: <m3y7vx2l3p.fsf@lx-ltd.ru>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

I write usb driver for embedded sh4 200MHz system (2.4.28 kernel) and added
printk into rx_callback and it prints following.
(this is just example)

packet 1: length=14, data=02 02 02 02 02 02 02 02 02 02 01 01 01 01
packet 2: length=10, data=02 02 02 02 02 02 02 02 02 02

while right result must be
packet 1: length=14, data=01 01 01 01 01 01 01 01 01 01 01 01 01 01
packet 2: length=10, data=02 02 02 02 02 02 02 02 02 02

It seems that 2nd packet placed over 1st one.
I submit single int urb and it happens often while high CPU usage.

As I understand it can not be fixed because of there is no HCI flow control
between host and usb device. Am I right?

(I use usb-skeleton.c as a template)

