Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbTJIQLA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 12:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbTJIQLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 12:11:00 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:40108 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262280AbTJIQK5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 12:10:57 -0400
Message-ID: <3F858885.1070202@colorfullife.com>
Date: Thu, 09 Oct 2003 18:10:45 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [RFC] disable_irq()/enable_irq() semantics and ide-probe.c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus wrote:

>Nobody has ever really complained, but if anybody 
>ever wants to do this, then the way to do it would be to
>
> - find out the irq
> - disable it
> - request the irq
> - enable the PCI routing for it
> - set up the device
> - enable the irq
>
I'd like to use that for nic shutdown for natsemi:

    disable_irq();
    shutdown_nic();
    free_irq();
    enable_irq();

The irq handler touches registers that restart the nic. Right now I use 
a np->hands_off variable to avoid that.

But I don't know if all systems can support atomic request_irq/free_irq 
calls. request_irq creates /proc/irq/x/cpu_affinity, and I could imagine 
that on some archs it might have perform IPIs to reconfigure the irq 
controller of a remote node.

--
    Manfred

