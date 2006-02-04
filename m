Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945944AbWBDQJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945944AbWBDQJt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 11:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946080AbWBDQJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 11:09:49 -0500
Received: from mx1.rowland.org ([192.131.102.7]:26637 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1945944AbWBDQJs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 11:09:48 -0500
Date: Sat, 4 Feb 2006 11:09:47 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Martin Michlmayr <tbm@cyrius.com>
cc: jgarzik@pobox.com, <linux-kernel@vger.kernel.org>
Subject: Re: Bad interaction between uhci_hcd and de2104x
In-Reply-To: <20060204111521.GB18806@deprecation.cyrius.com>
Message-ID: <Pine.LNX.4.44L0.0602041101130.757-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Feb 2006, Martin Michlmayr wrote:

> > For some reason, the de2104x driver isn't listed as a handler for
> > IRQ 10.  That's probably the cause of the problem.  Did you have any
> > full- or low-speed USB devices plugged in at the time this occurred?
> > If you didn't then the UHCI hardware would not have generated any
> > interrupt requests.
> 
> No, I don't think I ever used USB on this machine.  I did some more
> tests based on what you said and have the following data points:
>  - Having a USB device (USB stick) plugged in when booting doesn't
>    make a difference.
>  - When I load the de2104x driver _before_ uhci_hcd, both USB and
>    Ethernet work fine.
>  - Both modules load fine.  USB also works.  The problem only occurs
>    when I actually try to use the Ethernet device (i.e. run DHCP).
>    Then I get that traceback, and USB also stops working.

It sure looks as though the ethernet interface is generating an interrupt 
request before the de2104x driver has registered its interrupt handler.  
When uhci-hcd isn't already loaded the IRQ is unused, hence disabled, and 
so nothing bad happens.  If uhci-hcd is already loaded then the IRQ is 
enabled (because uhci-hcd is using it), so you get the problem -- an 
interrupt occurs with no registered handler.

Alan Stern

