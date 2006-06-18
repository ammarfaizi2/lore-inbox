Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbWFRQgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWFRQgK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 12:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWFRQgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 12:36:10 -0400
Received: from smtp102.sbc.mail.mud.yahoo.com ([68.142.198.201]:1618 "HELO
	smtp102.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932247AbWFRQgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 12:36:09 -0400
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] 2.6.17: dmesg flooded with "ohci_hcd 0000:00:02.0: wakeup"
Date: Sun, 18 Jun 2006 09:29:22 -0700
User-Agent: KMail/1.7.1
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, linux-kernel@vger.kernel.org
References: <200606181919.51126.arvidjaar@mail.ru>
In-Reply-To: <200606181919.51126.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606180929.23119.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 18 June 2006 8:19 am, Andrey Borzenkov wrote:
> After reboot with 2.6.17 dmesg is overflowed with the above. 2.6.16.20 was OK.
> Please let me know what additional information may be useful; for now I
> simply commented out this printk. dmesg, lsusb and lspci follow.

The printk means you're getting more IRQs than would be good.
Did you apply any patches to this, e.g. from the MM tree?

An alternative (but post-boot) workaround _should_ be

    echo disabled > /sys/bus/pci/devices/0000:00:02.0/power/wakeup

Looks like this is an old ALI-based motherboard with only one USB
controller; this might be a hardware problem, some others from
that era had problems handling USB suspend states.  In your case
(no USB devices hooked up here, right?) maybe this problem can
be automagically detected and worked around.

What would be most useful in this case -- and is ISTR one of
the FAQs for "how to report USB problems" -- is rebuilding
with CONFIG_USB_DEBUG and sending the boot log, so I can see
how that OHCI controller comes up in more detail than you've
provided here.

- Dave
