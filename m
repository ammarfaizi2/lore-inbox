Return-Path: <linux-kernel-owner+w=401wt.eu-S964994AbWLUOb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbWLUOb6 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 09:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965047AbWLUOb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 09:31:58 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:7899 "EHLO
	pd4mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964994AbWLUOb6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 09:31:58 -0500
Date: Thu, 21 Dec 2006 08:31:54 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: newbie questions about while (1) in kernel mode and spinlocks
In-reply-to: <fa.D8ff1OmLNpVeVOoaJAP7ENpm+Wk@ifi.uio.no>
To: linux-kernel@vger.kernel.org
Cc: Sorin Manolache <sorinm@gmail.com>
Message-id: <458A9ADA.8040709@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.D8ff1OmLNpVeVOoaJAP7ENpm+Wk@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorin Manolache wrote:
> 
> The Linux Device Drivers book says that a spin_lock should not be
> shared between a process and an interrupt handler. The explanation is
> that the process may hold the lock, an interrupt occurs, the interrupt
> handler spins on the lock held by the process and the system freezes.
> Why should it freeze? Isn't it possible for the interrupt handler to
> re-enable interrupts as its first thing, then to spin at the lock, the
> timer interrupt to preempt the interrupt handler and to relinquish
> control to the process which in turn will finish its critical section
> and release the lock, making way for the interrupt handler to
> continue.

When the timer interrupt finishes, it's not going to return control to 
the process, it's going to return control to what it interrupted which 
is the interrupt handler in your code which will just continue spinning. 
Interrupt handlers are not preemptible by anything other than other 
interrupt handlers (and then only in some cases) so it will sit spinning 
on that lock forever.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

