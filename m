Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbWJOPjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWJOPjA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 11:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbWJOPjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 11:39:00 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:17679 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751001AbWJOPi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 11:38:59 -0400
Date: Sun, 15 Oct 2006 16:38:51 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: pHilipp Zabel <philipp.zabel@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] Use own work queue
Message-ID: <20061015153851.GB12549@flint.arm.linux.org.uk>
Mail-Followup-To: pHilipp Zabel <philipp.zabel@gmail.com>,
	linux-kernel@vger.kernel.org
References: <20061001124240.16996.34557.stgit@poseidon.drzeus.cx> <74d0deb30610070717k17079940ybedbf94dc8af8460@mail.gmail.com> <452AB97B.5040309@drzeus.cx> <20061013075626.GB28654@flint.arm.linux.org.uk> <74d0deb30610150240y16d6ea92mc96705576b8f0824@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74d0deb30610150240y16d6ea92mc96705576b8f0824@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 15, 2006 at 11:40:31AM +0200, pHilipp Zabel wrote:
> On 10/13/06, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> >The problem is likely that the boot is continuing in parallel with
> >detecting the card, because the card detection is running in its own
> >separate thread.  Meanwhile, the init thread is trying to read from
> >the as-yet missing root device and erroring out.
> 
> Thanks, I can work around this by using the rootdelay kernel parameter.
> So does that mean this is the expected behavior, or should I do anything
> in the bootup sequence to make the init process wait for mmc detection?

That's up to Pierre now.  I originally ensured that the initial boot
time card detection was synchronous with the boot to avoid unexpected
problems like this.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
