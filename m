Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbTJIQii (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 12:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbTJIQii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 12:38:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61836 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262285AbTJIQie
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 12:38:34 -0400
Message-ID: <3F858EF8.5080105@pobox.com>
Date: Thu, 09 Oct 2003 12:38:16 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: Linus Torvalds <torvalds@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] disable_irq()/enable_irq() semantics and ide-probe.c
References: <3F858885.1070202@colorfullife.com>
In-Reply-To: <3F858885.1070202@colorfullife.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> I'd like to use that for nic shutdown for natsemi:
> 
>    disable_irq();
>    shutdown_nic();
>    free_irq();
>    enable_irq();


Why not just shutdown the NIC inside spin_lock_irqsave or disable_irq, 
and then free_irq separately?

If you can't stop the NIC hardware from generating interrupts, that's a 
driver bug.  And if the driver cannot handle its interrupt handler 
between the spin_unlock_irqrestore() and free_irq() (shared irq case), 
it's also buggy.

	Jeff



