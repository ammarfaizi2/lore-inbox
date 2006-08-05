Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751472AbWHETIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbWHETIj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 15:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbWHETIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 15:08:39 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:9742 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S1751472AbWHETIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 15:08:38 -0400
Message-ID: <44D4ECB2.5050109@superbug.co.uk>
Date: Sat, 05 Aug 2006 20:08:34 +0100
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Thunderbird 1.5.0.5 (X11/20060730)
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Problem with drivers/usb/input/hid-core.c
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried posting to the linux-usb-devel list, but it seems to have died.

<Extract start>
/*
 * Analyse a received field, and fetch the data from it. The field
 * content is stored for next report processing (we do differential
 * reporting to the layer).
 */

static void hid_input_field(struct hid_device *hid, struct hid_field
*field, __u8 *data, int interrupt, struct pt_regs *regs)

<Extract end>

Why is "differential reporting to the layer" done?

I have a USB device that uses the interrupt urb to notify the PC of
events. Each time an event happens, a usb interrupt is created, and the
driver reads the value from the report. Most of the time the event
contains exactly the same report info as the previous interrupt. As a
result of this differential reporting, I only see the first event, and
then no more until the event changes. How can I get repeated events of
the same report up to user space? I am currently using the
/dev/usb/hiddev0 interface.

Any clues?

For now, I am removing the "differential reporting to the layer" code,
ensuring that all interrupt urbs reach the higher layers.

The "differential reporting" code must be there for a reason, does
anyone know why it is present?

James

