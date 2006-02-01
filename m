Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbWBABEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWBABEA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 20:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbWBABEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 20:04:00 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:22206 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1751295AbWBABD7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 20:03:59 -0500
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Wed,  1 Feb 2006 02:03:57 +0100
In-reply-to: <7f45d9390601311459o45de3c34sd4d25fc7990c728d@mail.gmail.com>
To: Shaun Jackman <sjackman@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Liyitec PS/2 touch panel driver [PATCH]
Message-Id: <20060201010355.D5D6D22AEF3@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Shaun Jackman wrote:
>I've written an input driver for the Liyitec PS/2 touch panel. The
>patch follows. As this is my first input driver, I'd appreciate any
>feedback.
>
>Please cc me in your reply. Cheers,
>Shaun
[snip]
>+static irqreturn_t liyitec_interrupt(struct serio *serio,
>+		unsigned char data, unsigned int flags, struct pt_regs *regs)
>+{
>+	struct liyitec *liyitec = serio_get_drvdata(serio);
>+
>+	if (liyitec->count < 0) {
>+		if (data != LIYITEC_RET_ACK)
>+			printk(KERN_DEBUG "liyitec: expected ACK: 0x%02x\n", data);
>+	} else
>+		liyitec->data[liyitec->count] = data;
>+	liyitec->count++;
>+
>+	if (liyitec->count == 1 && !(data & LIYITEC_SYNC)) {
>+		printk(KERN_DEBUG "liyitec: unsynchronized data: 0x%02x\n", data);
It would be great to use dev_*() rather than printks.
dev_dbg(&serio->dev, "unsynchronized data: 0x%02x\n", data);
for instance.

regards,
--
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E
