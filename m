Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932521AbVKWEvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbVKWEvk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 23:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbVKWEvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 23:51:40 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:22975 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S932521AbVKWEvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 23:51:39 -0500
Subject: Re: [PATCH] Fix USB suspend/resume crasher
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Brownell <david-b@pacbell.net>, Paul Mackerras <paulus@samba.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Alan Stern <stern@rowland.harvard.edu>
In-Reply-To: <1132715288.26560.262.camel@gaston>
References: <1132715288.26560.262.camel@gaston>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1132715647.4707.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 23 Nov 2005 14:14:07 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2005-11-23 at 14:08, Benjamin Herrenschmidt wrote:
> This is my latest patch against current linus -git, it closes the IRQ
> race and makes various other OHCI & EHCI code path safer vs.
> suspend/resume. I've been able to (finally !) successfully suspend and
> resume various Mac models, with or without USB mouse plugged, or
> plugging while asleep, or unplugging while asleep etc... all without a
> crash. There are still some races here or there in the USB code, but at
> least the main cause of crash is now fixes by this patch (access to a
> controller that has been suspended, due to either shared interrupts or
> other code path).
> 
> I haven't fixed UHCI as I don't have any HW to test, though I hope I
> haven't broken it neither. Alan, I would appreciate if you could have a
> look.
> 
> This patch applies on top of the patch that moves the PowerMac specific
> code out of ohci-pci.c to hcd-pci.c where it belongs. This patch isn't
> upstream yet for reasons I don't fully understand (why does USB stuffs
> has such a high latency for going upstream ?), I'm sending it as a reply
> to this email for completeness.
> 
> Without this patch, you cannot reliably sleep/wakeup any recent Mac, and
> I suspect PCs have some more sneaky issues too (they don't frankly crash
> with machine checks because x86 tend to silently swallow PCI errors but
> that won't last afaik, at least PCI Express will blow up in those
> situations, but the USB code may still misbehave).

Sounds great. Maybe I'll finally be able to change my first question to
people with suspend problems from: "Do you have USB built as modules and
unloaded while suspending."

Regards,

Nigel

