Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbWBCRq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWBCRq0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 12:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWBCRq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 12:46:26 -0500
Received: from khc.piap.pl ([195.187.100.11]:45330 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751242AbWBCRqZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 12:46:25 -0500
To: Glen Turner <glen.turner@aarnet.edu.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 8250 serial console fixes -- issue
References: <Pine.LNX.4.44.0602011911360.22854-100000@gate.crashing.org>
	<1138844838.5557.17.camel@localhost.localdomain>
	<43E2B8D6.1070707@aarnet.edu.au>
	<20060203094042.GB30738@flint.arm.linux.org.uk>
	<43E36850.5030900@aarnet.edu.au>
	<20060203160218.GA27452@flint.arm.linux.org.uk>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Fri, 03 Feb 2006 18:46:24 +0100
In-Reply-To: <20060203160218.GA27452@flint.arm.linux.org.uk> (Russell King's message of "Fri, 3 Feb 2006 16:02:18 +0000")
Message-ID: <m3lkwse3nz.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> writes:

> My point stands - if the user can provide an arbitary string to printk,
> they can fake any kernel message.  That in itself is a security bug.
> If there is an instance of that, then that's the real bug which would
> need fixing.

I think the AT problem is valid - the user doesn't have to be able to
send anything to the console, the system alone can screw it up with
something as simple as ATZ^M (or with almost any string with embedded
[aA][tT].*^M).

_If_ we want to be able to connect a serial console to dial-up modem
we can't send _anything_ to it when DCD is down (except configuration
strings etc). I don't know exact timings but the modem will probably
accept commands hundreds of milliseconds after dropping DCD.


There are/were modems which could be configured using a jumper to
password-protected power-on dial-in mode and which doesn't accept
further Hayes commands - those are safe (they don't even abort
inbound connection negotiation if they receive characters from
the computer).
-- 
Krzysztof Halasa
