Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbVBKPOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbVBKPOv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 10:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbVBKPOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 10:14:51 -0500
Received: from one.firstfloor.org ([213.235.205.2]:19331 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262256AbVBKPOs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 10:14:48 -0500
To: "Simon White" <s_a_white@email.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Detecting kernel shutdown in a kernel driver
References: <20050210200537.AD4754BE65@ws1-1.us4.outblaze.com>
From: Andi Kleen <ak@muc.de>
Date: Fri, 11 Feb 2005 16:14:47 +0100
In-Reply-To: <20050210200537.AD4754BE65@ws1-1.us4.outblaze.com> (Simon
 White's message of "Thu, 10 Feb 2005 15:05:37 -0500")
Message-ID: <m1fz03uo0o.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Simon White" <s_a_white@email.com> writes:

> Hi,
>
> I've been writing a device driver for a piece of hardware that we recently found the pci bridge has an issue on software reset (kernel 2.6.8.1, hardware reset is fine).  The bridge appears to corrupt the subvendor/device ids on next boot.  We have found a software work around in that I can write to the bridge on module exit and it will always detect correctly next boot (through module_exit when rmmod'd).
>
> However on shutting down a machine with the module loaded it never works next time, so is module_exit actually called?

It's only called when the module is explicitely unloaded.

You can use register_reboot_notifier() though.

-Andi
