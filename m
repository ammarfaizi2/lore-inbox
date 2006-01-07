Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752591AbWAGWiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591AbWAGWiR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 17:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752593AbWAGWiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 17:38:17 -0500
Received: from gate.crashing.org ([63.228.1.57]:15509 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1752591AbWAGWiR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 17:38:17 -0500
Subject: i2c/ smbus question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: khali@linux-fr.org
Cc: Greg KH <greg@kroah.com>, Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sun, 08 Jan 2006 09:36:03 +1100
Message-Id: <1136673364.30123.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Can you confirm the difference between writing a block of data with
I2C_SMBUS_BLOCK_DATA vs I2C_SMBUS_I2C_BLOCK_DATA on the wire ? It's my
understanding that the former will actually send the lenght byte on the
wire before the data while the later won't, though they both send a
subaddress.

I'm completely rewriting the powermac i2c support (consolidating all
busses behind a low level layer that I need to use in circumstances
where the linux i2c layer isn't useable, and with a single driver in
drivers/i2c/busses/* replacing i2c-keywest.c and i2c-pmac-smu.c) and I
think I'm hitting a problem where i2c-keywest didn't implement
I2C_SMBUS_BLOCK_DATA properly (didn't send the lenght byte) and some
drivers (our sound drivers) rely on that behaviour (that's fine, I can
fix them too, I just want to make sure I understand what the semantic
should be).

I'm a bit surprised that there seem to be no wrapper for writing with
I2C_SMBUS_I2C_BLOCK_DATA, only for reading, in i2c-core.c since it
appears to me that it's the most common one, at least for all devices
I've dealt with so far (mostly sound & clock chips in addition to
sensors)...

Cheers,
Ben.


