Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266595AbUIJA5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266595AbUIJA5E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 20:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266582AbUIJA5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 20:57:03 -0400
Received: from gw.goop.org ([64.81.55.164]:17553 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S266595AbUIJA5A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 20:57:00 -0400
Subject: Re: [PATCH] Fix for spurious interrupts on e100 resume
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Nathan Bryant <nbryant@optonline.net>
Cc: john.ronciak@intel.com, ganesh.venkatesan@intel.com,
       scott.feldman@intel.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4140EDDD.8010808@optonline.net>
References: <1094769368.4298.7.camel@localhost>
	 <4140EDDD.8010808@optonline.net>
Content-Type: text/plain
Date: Thu, 09 Sep 2004 17:53:50 -0700
Message-Id: <1094777630.4298.19.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 (1.5.9.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-09 at 19:57 -0400, Nathan Bryant wrote:
> You sure this is right? The comment seems to imply that writing the 
> reset command to the registers also clears the interrupt mask. So you 
> might need to have the e100_disable_irq() both before and after the reset.

Good point - I'm not sure.  I don't really know what would cause the
chip to raise an interrupt.  Could it do it spontaneously, in which case
there's always a window between poking the selective/software_reset and
the disable_irq?  Or is it that the chip raises an interrupt on reset,
which is masked by disabling the interrupt, but then it enables the
interrupt after the reset is complete?  Or perhaps "it's unmasked after
reset" means "after a hardware reset (power cycle)" and not by poking
the reset registers.

Well, there was definitely a real bug there before, and it works with a
bit of testing.  We'll see how it goes over the next few days (and maybe
someone who actually understands this hardware will weigh in).

	J

