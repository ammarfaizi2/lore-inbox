Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVB0JfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVB0JfX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 04:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVB0JfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 04:35:22 -0500
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:26375 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261278AbVB0JfP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 04:35:15 -0500
Date: Sun, 27 Feb 2005 10:35:38 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Andreas Oberritter <obi@saftware.de>
Cc: Greg KH <greg@kroah.com>, LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] possible bug in i2c-algo-bit's inb function
Message-Id: <20050227103538.218fa1b0.khali@linux-fr.org>
In-Reply-To: <E1D5GN2-0000Bi-KG@localhost.localdomain>
References: <E1D5GN2-0000Bi-KG@localhost.localdomain>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adreas,

> while writing a driver for a cardbus card which is supposed to use the
> bit-banging algorithm I noticed that communication with the I2C slave
> (Philips TDA10046) would fail without this patch. It forces SDA to
> high for every bit in i2c_inb() instead of once per byte. Can this
> patch go into the mainline kernel or will this break other drivers? I
> am using Kernel version 2.6.10.

There is no reason why this would be necessary. Once SDA is set high on
the master's side, the client will be controlling it for the rest of the
byte (transferred from client to master). Setting SDA high again on the
master's side for each bit shouldn't have any effet, let alone the
substantial slowdown. If it changes something for you, then either your
implementation of setscl or getsda is broken and does actually change
SDA as a side effect, or what really helps is the additional delay, not
setting SDA high per se. In the former case, check your code. If you
can't figure out what's wrong, post it here and I'll take at look.
What's your bus master BTW? In the latter case, you might simply need to
lower the bus speed (increase udelay).

Thanks,
-- 
Jean Delvare
